#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>
#include <semaphore.h>

// Variable global para almacenar la suma
int sum = 0;
// Semáforo para sincronización
sem_t mutex;

// Función que será ejecutada por los hilos
void *add(void *arg) {
    int *ptr = (int *)arg; // Apunta al inicio del arreglo
    while (*ptr != -1) {   // Itera mientras no encuentre el terminador -1
        sem_wait(&mutex);  // Bloquea el semáforo para acceso exclusivo
        sum += *ptr;       // Suma el valor actual al total
        printf("value: %d, sum: %d\n", *ptr, sum);
        sem_post(&mutex);  // Libera el semáforo
        ptr++;             // Avanza al siguiente elemento del arreglo
    }
    return NULL;
}

int main(int argc, char *args[]) {
    // Arreglos a sumar
    int A[] = {1, 2, 3, -1}; // -1 marca el final del arreglo
    int B[] = {4, 2, 6, -1};

    // Declaración de hilos
    pthread_t t_a, t_b;

    // Inicialización del semáforo con valor inicial 1
    sem_init(&mutex, 0, 1);

    // Creación de hilos
    pthread_create(&t_a, NULL, add, A);
    pthread_create(&t_b, NULL, add, B);

    // Espera a que los hilos terminen
    pthread_join(t_a, NULL);
    pthread_join(t_b, NULL);

    // Imprime el resultado final
    printf("Total: %d\n", sum);

    // Destruye el semáforo
    sem_destroy(&mutex);

    return 0;
}
