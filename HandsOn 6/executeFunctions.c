#include <pthread.h>
#include <stdio.h>
#include <stdlib.h>

#define NUM_THREADS 5

void* print_message(void* thread_id) {
    long tid = (long) thread_id;
    printf("Hola desde el hilo %ld\n", tid);
    pthread_exit(NULL);
}

int main() {
    pthread_t threads[NUM_THREADS];

    for (long i = 0; i < NUM_THREADS; i++) {
        printf("Creando hilo %ld\n", i);
        if (pthread_create(&threads[i], NULL, print_message, (void*)i) != 0) {
            perror("Error al crear el hilo");
            return 1;
        }
    }

    // Esperar a que todos los hilos terminen
    for (int i = 0; i < NUM_THREADS; i++) {
        pthread_join(threads[i], NULL);
    }

    printf("Todos los hilos han terminado.\n");
    return 0;
}
