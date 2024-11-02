#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

/**
 * infinite_while - Runs an infinite while loop with a sleep interval.
 *
 * Return: Always 0.
 */
int infinite_while(void)
{
	while (1)
	{
		sleep(1);
	}
	return (0);
}

/**
 * main - Creates 5 zombie processes.
 *
 * Return: Always 0.
 */
int main(void)
{
	pid_t child_pid;
	int i;

	for (i = 0; i < 5; i++)
	{
		child_pid = fork();
		if (child_pid == 0)
		{
			exit(0);  /* Exit immediately to create a zombie */
		}
		else
		{
			printf("Zombie process created, PID: %d\n", child_pid);
		}
	}

	infinite_while();  /* Keep the parent process running */
	return (0);
}
