#include "rtp.h"
#include "util.h"
#include "sender_def.h"
#include <stdint.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <time.h>
#include <fcntl.h>
#include <sys/stat.h>
#define MAX_NUM 71800


//get filesize
int FileSize(const char* filename)
{
    struct stat statbuf;
    if(stat(filename,&statbuf)==0)
        return statbuf.st_size;
    return -1;
}

int check_checksum(struct RTP_packet pkt,size_t n_bytes){
    uint32_t checksum=pkt.rtp.checksum;
    pkt.rtp.checksum=0;
    if(checksum== compute_checksum((struct RTP_packet*)&pkt, n_bytes)){
        return 0;
    }
    return -1;
}

int socketfd;
struct sockaddr_in servaddr;

int N;//windowsize
int send_base;
int seqnum;
int n;//the total number of pkt
int last_size;//sizeof the last pkt
int ack[MAX_NUM];
/**
 * @brief 用于建立RTP连接
 * @param receiver_ip receiver的IP地址
 * @param receiver_port receiver的端口
 * @param window_size window大小
 * @return -1表示连接失败，0表示连接成功
 **/
int initSender(const char* receiver_ip, uint16_t receiver_port, uint32_t window_size){
    int ret=0;
    socketfd= socket(AF_INET,SOCK_DGRAM,0);
    int flag= fcntl(socketfd,F_GETFL,0);
    fcntl(socketfd,F_GETFL,flag|O_NONBLOCK);//nonblock

    bzero(&servaddr,sizeof(servaddr));
    servaddr.sin_family=AF_INET;
    servaddr.sin_port= htons(receiver_port);
    inet_pton(AF_INET,receiver_ip,&servaddr.sin_addr);

    struct RTP_packet START;
    START.rtp.type=0;
    START.rtp.checksum=0;
    START.rtp.length=0;
    START.rtp.seq_num=rand();//random
    bzero(START.payload, sizeof(START.payload));
    START.rtp.checksum= compute_checksum(&START,11);
    sendto(socketfd,(struct RTP_packet*)&START, 11,0,(struct sockaddr*)&servaddr, sizeof(servaddr));

    struct RTP_packet ACK_START;
    clock_t start,end;
    double wait_time;
    start=clock();

    while(1){
        end=clock();
        wait_time=(double )(end-start)/CLOCKS_PER_SEC;
        //printf("%f\n",wait_time);

        if(wait_time>=0.100000){
            ret=-1;
            break;
        }
        ssize_t size= recvfrom(socketfd,(struct RTP_packet*)&ACK_START, 11,MSG_DONTWAIT,NULL, NULL);
        //printf("%d\n",size);
        if(size==11){
            if(ACK_START.rtp.type==3&& check_checksum(ACK_START,11)==0&&ACK_START.rtp.seq_num==START.rtp.seq_num){
                ret=0;
                N=window_size;
                break;
            } else{
                ret=-1;
                break;
            }
        }
    }
    //send END
    if(ret==-1){
        struct RTP_packet END,ACK_END;
        END.rtp.length=0;
        END.rtp.checksum=0;
        END.rtp.seq_num=seqnum;
        END.rtp.type=1;
        bzero(END.payload, sizeof(END.payload));
        END.rtp.checksum= compute_checksum(&END,11);
        sendto(socketfd,(struct RTP_packet*)&END, 11,0,(struct sockaddr*)&servaddr, sizeof(servaddr));
        start=clock();
        while(1){
            end=clock();
            wait_time=(double )(end-start)/CLOCKS_PER_SEC;
            if(wait_time>=0.100000){
                break;
            }
            if(recvfrom(socketfd,(struct RTP_packet*)&ACK_END, 11,0,NULL, NULL)==11){
                if(ACK_END.rtp.type==3&&ACK_END.rtp.seq_num==END.rtp.seq_num&& check_checksum(ACK_END,11)==0){
                    break;
                }
            }
        }
        //printf("close\n");
        close(socketfd);
    }
    return ret;
}


/**
 * @brief 用于发送数据
 * @param message 要发送的文件名
 * @return -1表示发送失败，0表示发送成功
 **/
int sendMessage(const char* message){
    send_base=0;
    seqnum=0;
    int file_size= FileSize(message);
    n=(file_size+PAYLOAD_SIZE-1)/PAYLOAD_SIZE;//number of pkt
    last_size=file_size-(n-1)*PAYLOAD_SIZE;
    //printf("%d\n%d\n%d\n",file_size,n,last_size);
    FILE* fq;

    fq= fopen(message,"r");
    if(fq<0){
        return -1;
    }

    clock_t start,end;
    double wait_time;
    ssize_t size;
    int times=0;

    while(1){
        //send over
        if(send_base>=n){
            seqnum=n;
            //printf("OK\n");
            //printf("%d\n%d\n%d\n",seqnum,times,n);
            return 0;
        }

        if(seqnum>=send_base&&seqnum<send_base+N&&seqnum<n){
            struct RTP_packet DATA;
            DATA.rtp.checksum=0;
            bzero(DATA.payload, sizeof(DATA.payload));
            DATA.rtp.type=2;
            DATA.rtp.seq_num=seqnum;
            DATA.rtp.length=PAYLOAD_SIZE;
            if(seqnum==n-1){
                DATA.rtp.length=last_size;
            }
            fseek(fq,seqnum*PAYLOAD_SIZE,0);
            fread(DATA.payload, DATA.rtp.length,1,fq);
            DATA.rtp.checksum= compute_checksum(&DATA,11+DATA.rtp.length);
            size=sendto(socketfd,(struct RTP_packet*)&DATA, 11+DATA.rtp.length,0,(struct sockaddr*)&servaddr, sizeof(servaddr));
            //printf("%ld\n",size);
            //printf("    %d\n",DATA.rtp.seq_num);
            times++;
            if(seqnum==0){
                start=clock();
            }
            seqnum++;
        }
        struct RTP_packet ACK_DATA;
        while(recvfrom(socketfd,(struct RTP_packet*)&ACK_DATA, 11,MSG_DONTWAIT,NULL, NULL)==11){
            if(ACK_DATA.rtp.type==3&& check_checksum(ACK_DATA,11)==0) {
                if(ACK_DATA.rtp.seq_num>send_base){
                    send_base = ACK_DATA.rtp.seq_num;
                    //printf("%d\n",ACK_DATA.rtp.seq_num);
                    if (send_base > seqnum)
                        send_base = seqnum;
                    start = clock();
                }
            }
        }
        //printf("%d\n",size);
        end=clock();
        wait_time=(double )(end-start)/CLOCKS_PER_SEC;
        //printf("%f\n",wait_time);
        if(wait_time>=0.100000){
            seqnum=send_base;
            start=clock();
        }
    }

}



/**
 * @brief 用于发送数据 (优化版本的RTP)
 * @param message 要发送的文件名
 * @return -1表示发送失败，0表示发送成功
 **/
int sendMessageOpt(const char* message){
    send_base=0;
    seqnum=0;
    int file_size= FileSize(message);
    n=(file_size+PAYLOAD_SIZE-1)/PAYLOAD_SIZE;//number of pkt
    last_size=file_size-(n-1)*PAYLOAD_SIZE;
    //printf("%d\n%d\n%d\n",file_size,n,last_size);
    FILE* fq;

    fq= fopen(message,"r");
    if(fq<0){
        return -1;
    }

    clock_t start,end;
    double wait_time;
    ssize_t size;
    int times=0;

    while(1){
        //send over
        if(send_base>=n){
            seqnum=n;
            //printf("OK\n");
            //printf("%d\n%d\n%d\n",seqnum,times,n);
            return 0;
        }

        if(seqnum>=send_base&&seqnum<send_base+N&&seqnum<n){
            struct RTP_packet DATA;
            DATA.rtp.checksum=0;
            bzero(DATA.payload, sizeof(DATA.payload));
            DATA.rtp.type=2;
            DATA.rtp.seq_num=seqnum;
            DATA.rtp.length=PAYLOAD_SIZE;
            if(seqnum==n-1){
                DATA.rtp.length=last_size;
            }
            fseek(fq,seqnum*PAYLOAD_SIZE,0);
            fread(DATA.payload, DATA.rtp.length,1,fq);
            DATA.rtp.checksum= compute_checksum(&DATA,11+DATA.rtp.length);
            size=sendto(socketfd,(struct RTP_packet*)&DATA, 11+DATA.rtp.length,0,(struct sockaddr*)&servaddr, sizeof(servaddr));
            //printf("%ld\n",size);
            //printf("    %d\n",DATA.rtp.seq_num);
            times++;
            if(seqnum==0){
                start=clock();
            }
            seqnum++;
        }
        struct RTP_packet ACK_DATA;
        while(recvfrom(socketfd,(struct RTP_packet*)&ACK_DATA, 11,MSG_DONTWAIT,NULL, NULL)==11){
            if(ACK_DATA.rtp.type==3&& check_checksum(ACK_DATA,11)==0) {
                if(ACK_DATA.rtp.seq_num>send_base&&ACK_DATA.rtp.seq_num<send_base+N){
                    ack[ACK_DATA.rtp.seq_num]=1;
                } else if(ACK_DATA.rtp.seq_num==send_base){
                    ack[ACK_DATA.rtp.seq_num]=1;
                    for(int i=send_base+1;i<send_base+N,i<n;i++){
                        if(ack[i]==0){
                            break;
                        } else if(ack[i]==1){
                            send_base=i;
                        }
                    }
                    send_base++;
                    start=clock();
                }
            }
        }
        //printf("%d\n",size);
        end=clock();
        wait_time=(double )(end-start)/CLOCKS_PER_SEC;

        //resend the pkt[i] if ack[i]==0
        if(wait_time>=0.100000){
            for(int i=send_base;i<send_base+N,i<n;i++){
                if(ack[i]==0){
                    struct RTP_packet DATA;
                    DATA.rtp.checksum=0;
                    bzero(DATA.payload, sizeof(DATA.payload));
                    DATA.rtp.type=2;
                    DATA.rtp.seq_num=i;
                    DATA.rtp.length=PAYLOAD_SIZE;
                    if(i==n-1){
                        DATA.rtp.length=last_size;
                    }
                    fseek(fq,i*PAYLOAD_SIZE,0);
                    fread(DATA.payload, DATA.rtp.length,1,fq);
                    DATA.rtp.checksum= compute_checksum(&DATA,11+DATA.rtp.length);
                    sendto(socketfd,(struct RTP_packet*)&DATA, 11+DATA.rtp.length,0,(struct sockaddr*)&servaddr, sizeof(servaddr));
                }
            }
            start=clock();
        }
    }
}


/**
 * @brief 用于断开RTP连接以及关闭UDP socket
 **/
void terminateSender(){
    struct RTP_packet END,ACK_END;
    END.rtp.length=0;
    END.rtp.checksum=0;
    END.rtp.seq_num=seqnum;
    END.rtp.type=1;
    bzero(END.payload, sizeof(END.payload));
    END.rtp.checksum= compute_checksum(&END,11);
    sendto(socketfd,(struct RTP_packet*)&END, 11,0,(struct sockaddr*)&servaddr, sizeof(servaddr));
    clock_t start,end;
    double wait_time;
    start=clock();
    while(1){
        end=clock();
        wait_time=(double )(end-start)/CLOCKS_PER_SEC;
        if(wait_time>=0.100000){
            break;
        }
        if(recvfrom(socketfd,(struct RTP_packet*)&ACK_END, 11,0,NULL, NULL)==11){
            if(ACK_END.rtp.type==3&&ACK_END.rtp.seq_num==END.rtp.seq_num&& check_checksum(ACK_END,11)==0){
                break;
            }
        }
    }
    //printf("close\n");
    close(socketfd);
    return;
}
