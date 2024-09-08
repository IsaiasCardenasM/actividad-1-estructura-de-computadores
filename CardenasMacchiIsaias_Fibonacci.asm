.data
cantidad_numeros: .asciiz "Ingrese la cantidad de números de la serie Fibonacci que desea generar: "      # Mensaje para solicitar la cantidad de números
salto_linea: .asciiz "\n"                   # Salto de línea
fibonacci: .asciiz "Serie Fibonacci: "      # Mensaje para la serie Fibonacci
caracter_coma: .asciiz ", "                 # Coma para separar los números
suma_serie: .asciiz "Suma de la serie: "    # Mensaje para la suma de la serie

.text
.globl main

main:
    # Solicitar al usuario la cantidad de números de la serie Fibonacci
    li $v0, 4                   # Código de syscall para imprimir cadena
    la $a0, cantidad_numeros    # Cargar la dirección del mensaje en $a0
    syscall                     # Llamar a syscall para imprimir el mensaje

    li $v0, 5                   # Código de syscall para leer un entero
    syscall                     # Llamar a syscall para leer el número
    move $t0, $v0               # Guardar la cantidad de números en $t0

    # Inicializar los primeros dos números de la serie Fibonacci
    li $t1, 0   # Fibonacci(0)
    li $t2, 1   # Fibonacci(1)
    li $t3, 0   # Suma de la serie
    li $t4, 2   # Contador de la serie

    # Imprimir el primer número de la serie
    li $v0, 4           # Código de syscall para imprimir cadena
    la $a0, fibonacci   # Cargar la dirección del mensaje en $a0
    syscall             # Llamar a syscall para imprimir el mensaje

    li $v0, 1           # Código de syscall para imprimir entero
    move $a0, $t1       # Mover el primer número a $a0
    syscall             # Llamar a syscall para imprimir el número

    # Imprimir una coma después del primer número
    li $v0, 4               # Código de syscall para imprimir cadena
    la $a0, caracter_coma   # Cargar la dirección de la coma en $a0
    syscall                 # Llamar a syscall para imprimir la coma

    # Imprimir el segundo número de la serie
    li $v0, 1           # Código de syscall para imprimir entero
    move $a0, $t2       # Mover el segundo número a $a0
    syscall             # Llamar a syscall para imprimir el número

    # Sumar los dos primeros números
    add $t3, $t1, $t2   # Sumar Fibonacci(0) y Fibonacci(1)

    # Generar e imprimir el resto de la serie
    loop:
        beq $t4, $t0, end_loop  # Si el contador alcanza la cantidad deseada, salir del bucle

        add $t5, $t1, $t2       # Calcular el siguiente número de la serie
        move $t1, $t2           # Actualizar los valores para el siguiente ciclo
        move $t2, $t5

        # Imprimir una coma antes del siguiente número
        li $v0, 4               # Código de syscall para imprimir cadena
        la $a0, caracter_coma   # Cargar la dirección de la coma en $a0
        syscall                 # Llamar a syscall para imprimir la coma

        # Imprimir el siguiente número de la serie
        li $v0, 1               # Código de syscall para imprimir entero
        move $a0, $t5           # Mover el siguiente número a $a0
        syscall                 # Llamar a syscall para imprimir el número

        # Sumar el siguiente número a la suma total
        add $t3, $t3, $t5       # Sumar el siguiente número a la suma total

        addi $t4, $t4, 1        # Incrementar el contador
        j loop                  # Saltar al inicio del bucle

    end_loop:
        # Imprimir un salto de línea
        li $v0, 4               # Código de syscall para imprimir cadena
        la $a0, salto_linea     # Cargar la dirección del salto de línea en $a0
        syscall                 # Llamar a syscall para imprimir el salto de línea

        # Imprimir la suma de la serie
        li $v0, 4               # Código de syscall para imprimir cadena
        la $a0, suma_serie      # Cargar la dirección del mensaje en $a0
        syscall                 # Llamar a syscall para imprimir el mensaje

        li $v0, 1               # Código de syscall para imprimir entero
        move $a0, $t3           # Mover la suma total a $a0
        syscall                 # Llamar a syscall para imprimir la suma

        # Salir del programa
        li $v0, 10      # Código de syscall para salir del programa
        syscall         # Llamar a syscall para salir
