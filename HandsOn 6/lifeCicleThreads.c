#include <pthread.h>
#include <stdio.h>
#include <stdlib.h>

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

    printf("Hilo desvinculado, programa principal continúa.\n");
    return 0;
}
