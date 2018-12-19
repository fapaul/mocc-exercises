#include <stdio.h>
#include <unistd.h>
#include <sys/types.h>
#include <stdlib.h>

 int main (int argc, char *argv[])
{
    if (argc < 2) {
        exit(1);
    }
    int start = atoi(argv[1]);
    int end = atoi(argv[2]);
    int range = end - start;
    pid_t pid;
    pid_t pid2;
    pid_t pid3;
    int fd2[2];
    pipe(fd2);
    pid = fork();
    if (pid == 0) {
        int fd1[2];
        pipe(fd1);
        pid2 = fork();
        int sum = 0;
        if (pid2 == 0) {
            for (int i = start; i < start + range / 4 + 1; i++) {
                sum += i;
            }
            close(fd1[1]);
            int childResult;
            read(fd1[0], &childResult, sizeof(sum));
            close(fd2[0]);
            sum += childResult;
            write(fd2[1], &sum, sizeof(sum));
        } else {
            for (int i = start + range / 4 + 1; i < start + range / 2 + 1; i++) {
                sum += i;
            }
            close(fd1[0]);
            write(fd1[1], &sum, sizeof(sum));
        }
    } else {
        int fd1[2];
        pipe(fd1);
        pid3 = fork();
        int sum = 0;
        if (pid3 == 0) {
            for (int i = start + range / 2 + 1; i < start + range * 3 / 4 + 1; i++) {
                sum += i;
            }
            close(fd1[1]);
            int childResult;
            read(fd1[0], &childResult, sizeof(sum));
            sum += childResult;
            close(fd2[1]);
            read(fd2[0], &childResult, sizeof(sum));
            sum += childResult;
            printf("%d\n", sum);
        } else {
            for (int i = start + range * 3 / 4 + 1; i < start + range + 1; i++) {
                sum += i;
            }
            close(fd1[0]);
            write(fd1[1], &sum, sizeof(sum));
        }
    }
}
