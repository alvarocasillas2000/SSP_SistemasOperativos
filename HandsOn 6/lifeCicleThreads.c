#include <pthread.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h> // Para usar sleep

void* thread_function(void* arg) {
    printf("Hilo iniciado, se finalizará después.\n");
    pthread_exit(NULL); // Finaliza el hilo
}

int main() {
    pthread_t thread;

    if (pthread_create(&thread, NULL, thread_function, NULL) != 0) {
        perror("Error al crear el hilo");
        return 1;
    }

    // Desvincular el hilo (no se usa pthread_join)
    pthread_detach(thread);

    // Forzar espera en el programa principal para observar el hilo
    sleep(1); // Espera 1 segundo antes de finalizar

    printf("Hilo desvinculado, programa principal continúa.\n");
    return 0;
}
