#include <stdio.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>

#ifndef _WIN32
#define O_BINARY 0
#endif



int main ( int argc, char **argv )
{
	if (argc != 2) {
		fprintf(stderr, "Bad usage\n");
		return 1;
	}
	int fd = open(argv[1], O_RDWR|O_BINARY);
	if (fd < 0) {
		perror("Cannot open file for R/W");
		return 1;
	}
	unsigned char buffer[0x10001];
	int ret = read(fd, buffer, sizeof buffer);
	if (ret < 0) {
		perror("File reading error");
		close(fd);
		return 1;
	}
	if (ret == sizeof buffer) {
		fprintf(stderr, "Too large file\n");
		close(fd);
		return 1;
	}
	if (read(fd, buffer + sizeof(buffer) - 1, 1) != 0) {
		fprintf(stderr, "Partial read or other error\n");
		close(fd);
		return 1;
	}
	if (!ret) {
		close(fd);
		return 0;
	}
	int old = ret;
	while (ret && buffer[ret - 1] == 0)
		ret--;
	if (ret < old) {
		printf("Stripping: %04Xh -> %04Xh: %s\n", old, ret, argv[1]);
		if (ftruncate(fd, ret)) {
			perror("Error at truncate syscall");
			close(fd);
			return 1;
		}
	} else {
		printf("Stripping: %04Xh -> SAME : %s\n", old, argv[1]);
	}
	close(fd);
	return 0;
}
