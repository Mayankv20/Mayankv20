/*
Spawns a shell by seting alice real and effective UID.
Use to demo SUID permission

To compile in the container:

apt update
apt install gcc
gcc hello.c -o hello

then run:
docker cp <container id>:/home/alice/hello ./

The Dockerfile will copy the executable when building the container

 */
#include <stdlib.h>
#include <sys/types.h>
#include <unistd.h>
#include <stdio.h>
int main () {
	printf("Trying to set uid 1000 (alice)\n");
	if (setreuid(1000,1000)<0) {
		printf("Failed to set alice uid. No permissions?\n");
		exit(1);
	}
	printf("Starting a shell as %4d!\n",geteuid());
	system("HOME=/home/alice; /bin/bash");
}
