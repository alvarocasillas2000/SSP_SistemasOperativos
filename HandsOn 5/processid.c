#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <unistd.h>

int main() {
   int mypid, myppid;
   printf("Programa para obtener información de PID y PPID\n");
   mypid = getpid();
   myppid = getppid();
   printf("Mi ID de proceso (PID) es %d\n", mypid);
   printf("El ID de mi proceso padre (PPID) es %d\n", myppid);
   printf("Verificación cruzada de PIDs ejecutando comandos en la terminal\n");
   system("ps -ef");
   return 0;
}
