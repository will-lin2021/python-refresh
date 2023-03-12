#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>

int main(int argc, char const *argv[]) {

	pid_t pid = fork();
	if (pid < 0) {
		perror("Failed to clear non-default python packages");
		return -1;
	}

	if (pid == 0) {

		execlp("zsh", "zsh", "-c", "pip3 freeze | xargs pip3 uninstall -y", NULL);

	} else {
		int status;

		if (waitpid(pid, &status, 0) == -1) {
			perror("Failed to clear non-default python packages");
			return -1;
		}

		printf("Cleared all non-default python packages\n");
	}

	return 0;
}