#include <pthread.h>
#include <stdio.h>
#include <stdlib.h>

// Función que ejecutará el hilo
void* thread_function(void* arg) {
    printf("El hilo se creo correctamente\n");
    return NULL;
}

int main() {
    pthread_t thread; // Declarar una variable para el hilo

    // Crear el hilo
    if (pthread_create(&thread, NULL, thread_function, NULL) != 0) {
        perror("Error al crear el hilo");
        return 1;
    }

    // Esperar a que el hilo termine
    pthread_join(thread, NULL);

    printf("¡Hilo finalizado!\n");
    return 0;
}
