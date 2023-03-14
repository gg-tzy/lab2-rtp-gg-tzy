#include "util.h"
#include "rtp.h"
#include "receiver_def.h"
#include <stdint.h>
#include <stdlib.h>
#include <string.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <fcntl.h>
#include <sys/stat.h>
#include <time.h>

int windowsize;//windowsize
int nextseqnum;
int cache[513];
struct RTP_packet cache_pkt[513];

int GetFileSize(const char* filename)
{
    struct stat statbuf;
    if(stat(filename,&statbuf)==0)
        return statbuf.st_size;
    return -1;
}

int recv_check_checksum(struct RTP_packet pkt,size_t n_bytes){
    uint32_t checksum=pkt.rtp.checksum;
    pkt.rtp.checksum=0;
    if(checksum== compute_checksum((struct RTP_packet*)&pkt, n_bytes)){
        return 0;
    }
    return -1;
}

/**
 * @brief 开启receiver并在所有IP的port端口监听等待连接
 *
 * @param port receiver监听的port
 * @param window_size window大小
 * @return -1表示连接失败，0表示连接成功
 */
 
int fd,len;
struct sockaddr_in cliaddr,serveraddr;

int initReceiver(uint16_t port, uint32_t window_size){
    fd= socket(AF_INET,SOCK_DGRAM,0);

    bzero(&serveraddr,sizeof(serveraddr));
    serveraddr.sin_family=AF_INET;
    serveraddr.sin_addr.s_addr= htonl(INADDR_ANY);
    serveraddr.sin_port= htons(port);
    len=sizeof(cliaddr);

    if(bind(fd,(struct sockaddr*)&serveraddr, sizeof(serveraddr))<0){
        return -1;
    }

    struct RTP_packet START,ACK_START;
    ssize_t size= recvfrom(fd,(struct RTP_packet*)&START,11,0,(struct sockaddr*)&cliaddr,&len);
    if(size<0){
        return -1;
    }
    if(START.rtp.type==0&& recv_check_checksum(START,11)==0){
        ACK_START.rtp.checksum=0;
        ACK_START.rtp.type=3;
        ACK_START.rtp.seq_num=START.rtp.seq_num;
        ACK_START.rtp.length=0;
        bzero(ACK_START.payload, sizeof(ACK_START.payload));
        ACK_START.rtp.checksum= compute_checksum(&ACK_START,11);
        size= sendto(fd,(struct RTP_packet*)&ACK_START,11,0,(struct sockaddr*)&cliaddr,len);
        if(size<0){
            return -1;
        }
        windowsize=window_size;
        return 0;
    }else if (recv_check_checksum(START,11)==-1){
        close(fd);
    }
    return -1;
}

/**
 * @brief 用于接收数据并在接收完后断开RTP连接
 * @param filename 用于接收数据的文件名
 * @return >0表示接收完成后到数据的字节数 -1表示出现其他错误
 */
int recvMessage(char* filename){
    int flag= fcntl(fd,F_GETFL,0);
    fcntl(fd,F_GETFL,flag|O_NONBLOCK);//nonblock

    nextseqnum=0;
    FILE* fq;
    fq= fopen(filename,"w");
    if(fq<0){
        return -1;
    }
    clock_t start,end;
    double wait_time;

    while(1){

        struct RTP_packet DATA,ACK;
        bzero(DATA.payload, PAYLOAD_SIZE);
        ssize_t size= recvfrom(fd,(void *)&DATA,11+PAYLOAD_SIZE,MSG_DONTWAIT,(struct sockaddr*)&cliaddr,&len);

        if(size<0){
            end= clock();
            wait_time=(double )(end-start)/CLOCKS_PER_SEC;
            if(wait_time>10.000000){
                close(fd);
                return -1;
            }
        }
        if(size>0) {
            start=clock();
            //recv END
            if (DATA.rtp.type == 1 && DATA.rtp.seq_num == nextseqnum && recv_check_checksum(DATA, 11) == 0) {
                //printf("end\n");
                ACK.rtp.checksum = 0;
                ACK.rtp.seq_num = nextseqnum;
                ACK.rtp.type = 3;
                ACK.rtp.length = 0;
                bzero(ACK.payload, sizeof(ACK.payload));
                ACK.rtp.checksum = compute_checksum(&ACK, 11);
                sendto(fd, (struct RTP_packet *) &ACK, 11, 0, (struct sockaddr *) &cliaddr, len);
                close(fd);
                fclose(fq);
                return GetFileSize(filename);
            }
            //recv DATA
            if (DATA.rtp.type == 2) {
                if (recv_check_checksum(DATA, 11 + DATA.rtp.length) == 0) {
                    if (DATA.rtp.seq_num == nextseqnum) {
                        fwrite(DATA.payload, 1, DATA.rtp.length, fq);
                        nextseqnum=DATA.rtp.seq_num+1;
                        for (int i = 1; i < windowsize; i++) {
                            if (cache[i] == 0) {
                                break;
                            } else if (cache[i] == 1) {
                                fwrite(cache_pkt[i].payload, 1, cache_pkt[i].rtp.length, fq);
                                cache[i] = 0;
                                nextseqnum = cache_pkt[i].rtp.seq_num + 1;
                            }
                        }
                        for (int i = 1; i < windowsize; i++) {
                            if (cache[i] == 1) {
                                cache[i] = 0;
                                cache_pkt[(cache_pkt[i].rtp.seq_num - nextseqnum) % windowsize] = cache_pkt[i];
                                cache[(cache_pkt[i].rtp.seq_num - nextseqnum) % windowsize] = 1;
                            }
                        }
                    } else if (DATA.rtp.seq_num > nextseqnum && DATA.rtp.seq_num <= nextseqnum + windowsize - 1) {
                        if (cache[(DATA.rtp.seq_num - nextseqnum) % windowsize] == 0) {
                            cache[(DATA.rtp.seq_num - nextseqnum) % windowsize] = 1;
                            cache_pkt[(DATA.rtp.seq_num - nextseqnum) % windowsize] = DATA;
                        }
                    }
                    //printf("%d\n", nextseqnum);
                    ACK.rtp.seq_num = nextseqnum;
                    ACK.rtp.checksum = 0;
                    ACK.rtp.type = 3;
                    ACK.rtp.length = 0;
                    bzero(ACK.payload, sizeof(ACK.payload));
                    ACK.rtp.checksum = compute_checksum(&ACK, 11);
                    sendto(fd, (struct RTP_packet *) &ACK, 11, 0, (struct sockaddr *) &cliaddr, len);
                }
            }
        }
    }
}



/**
 * @brief 用于接收数据并在接收完后断开RTP连接 (优化版本的RTP)
 * @param filename 用于接收数据的文件名
 * @return >0表示接收完成后到数据的字节数 -1表示出现其他错误
 */
int recvMessageOpt(char* filename){
    int flag= fcntl(fd,F_GETFL,0);
    fcntl(fd,F_GETFL,flag|O_NONBLOCK);//nonblock

    nextseqnum=0;
    FILE* fq;
    fq= fopen(filename,"w");
    if(fq<0){
        return -1;
    }
    clock_t start,end;
    double wait_time;

    while(1){
        struct RTP_packet DATA,ACK;
        bzero(DATA.payload, PAYLOAD_SIZE);
        ssize_t size= recvfrom(fd,(void *)&DATA,11+PAYLOAD_SIZE,MSG_DONTWAIT,(struct sockaddr*)&cliaddr,&len);

        if(size<0){
            end=clock();
            wait_time=(double )(end-start)/CLOCKS_PER_SEC;
            if(wait_time>10.000000){
                close(fd);
                return -1;
            }
        }

        if(size>0) {
            start=clock();
            //recv END
            if (DATA.rtp.type == 1 && DATA.rtp.seq_num == nextseqnum && recv_check_checksum(DATA, 11) == 0) {
                //printf("end\n");
                ACK.rtp.checksum = 0;
                ACK.rtp.seq_num = nextseqnum;
                ACK.rtp.type = 3;
                ACK.rtp.length = 0;
                bzero(ACK.payload, sizeof(ACK.payload));
                ACK.rtp.checksum = compute_checksum(&ACK, 11);
                sendto(fd, (struct RTP_packet *) &ACK, 11, 0, (struct sockaddr *) &cliaddr, len);
                close(fd);
                fclose(fq);
                return GetFileSize(filename);
            }
            //recv DATA
            if (DATA.rtp.type == 2) {
                if (recv_check_checksum(DATA, 11 + DATA.rtp.length) == 0) {
                    if (DATA.rtp.seq_num == nextseqnum) {
                        fwrite(DATA.payload, 1, DATA.rtp.length, fq);
                        nextseqnum=DATA.rtp.seq_num+1;
                        for (int i = 1; i < windowsize; i++) {
                            if (cache[i] == 0) {
                                break;
                            } else if (cache[i] == 1) {
                                fwrite(cache_pkt[i].payload, 1, cache_pkt[i].rtp.length, fq);
                                cache[i] = 0;
                                nextseqnum = cache_pkt[i].rtp.seq_num + 1;
                            }
                        }
                        for (int i = 1; i < windowsize; i++) {
                            if (cache[i] == 1) {
                                cache[i] = 0;
                                cache_pkt[(cache_pkt[i].rtp.seq_num - nextseqnum) % windowsize] = cache_pkt[i];
                                cache[(cache_pkt[i].rtp.seq_num - nextseqnum) % windowsize] = 1;
                            }
                        }
                    } else if (DATA.rtp.seq_num > nextseqnum && DATA.rtp.seq_num <= nextseqnum + windowsize - 1) {
                        if (cache[(DATA.rtp.seq_num - nextseqnum) % windowsize] == 0) {
                            cache[(DATA.rtp.seq_num - nextseqnum) % windowsize] = 1;
                            cache_pkt[(DATA.rtp.seq_num - nextseqnum) % windowsize] = DATA;
                        }
                    }
                   // printf("%d\n", nextseqnum);
                    if(DATA.rtp.seq_num<=nextseqnum+windowsize-1) {
                        ACK.rtp.seq_num = DATA.rtp.seq_num;
                        ACK.rtp.checksum = 0;
                        ACK.rtp.type = 3;
                        ACK.rtp.length = 0;
                        bzero(ACK.payload, sizeof(ACK.payload));
                        ACK.rtp.checksum = compute_checksum(&ACK, 11);
                        sendto(fd, (struct RTP_packet *) &ACK, 11, 0, (struct sockaddr *) &cliaddr, len);
                    }
                }
            }
        }
    }
}

/**
 * @brief 用于接收数据失败时断开RTP连接以及关闭UDP socket
 */
void terminateReceiver(){
    close(fd);
}
