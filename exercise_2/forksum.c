#include <stdio.h>
#include <sys/types.h>

int main()
{
    int start = 100;
    int end = 1000;
    int range = end - start;
    pid_t pid;
    pid_t pid2;
    pid_t pid3;
    pid = fork();
    if (pid == 0) {
        pid2 = fork();
        int sum = 0;
        if (pid2 == 0) {
            for (int i = start; i < start + range / 4 + 1; i++) {
                sum += i;
            }
            printf("%d, %d \n", pid2, sum);
        } else {
            for (int i = start + range / 4 + 1; i < start + range / 2 + 1; i++) {
                sum += i;
            }
            printf("%d, %d \n", pid2, sum);
        }
    } else {
        pid3 = fork();
        int sum = 0;
        if (pid3 == 0) {
            for (int i = start + range / 2 + 1; i < start + range * 3 / 4 + 1; i++) {
                sum += i;
            }
            printf("%d, %d \n", pid3, sum);
        } else {
            for (int i = start + range * 3 / 4 + 1; i < start + range + 1; i++) {
                sum += i;
            }
            printf("%d, %d \n", pid3, sum);
        }
    }
}
