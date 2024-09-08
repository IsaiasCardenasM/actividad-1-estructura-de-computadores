.data
cantidad_numeros: .asciiz "Ingrese la cantidad de n�meros de la serie Fibonacci que desea generar: "      # Mensaje para solicitar la cantidad de n�meros
salto_linea: .asciiz "\n"                   # Salto de l�nea
fibonacci: .asciiz "Serie Fibonacci: "      # Mensaje para la serie Fibonacci
caracter_coma: .asciiz ", "                 # Coma para separar los n�meros
suma_serie: .asciiz "Suma de la serie: "    # Mensaje para la suma de la serie

.text
.globl main

main:
    # Solicitar al usuario la cantidad de n�meros de la serie Fibonacci
    li $v0, 4                   # C�digo de syscall para imprimir cadena
    la $a0, cantidad_numeros    # Cargar la direcci�n del mensaje en $a0
    syscall                     # Llamar a syscall para imprimir el mensaje

    li $v0, 5                   # C�digo de syscall para leer un entero
    syscall                     # Llamar a syscall para leer el n�mero
    move $t0, $v0               # Guardar la cantidad de n�meros en $t0

    # Inicializar los primeros dos n�meros de la serie Fibonacci
    li $t1, 0   # Fibonacci(0)
    li $t2, 1   # Fibonacci(1)
    li $t3, 0   # Suma de la serie
    li $t4, 2   # Contador de la serie

    # Imprimir el primer n�mero de la serie
    li $v0, 4           # C�digo de syscall para imprimir cadena
    la $a0, fibonacci   # Cargar la direcci�n del mensaje en $a0
    syscall             # Llamar a syscall para imprimir el mensaje

    li $v0, 1           # C�digo de syscall para imprimir entero
    move $a0, $t1       # Mover el primer n�mero a $a0
    syscall             # Llamar a syscall para imprimir el n�mero

    # Imprimir una coma despu�s del primer n�mero
    li $v0, 4               # C�digo de syscall para imprimir cadena
    la $a0, caracter_coma   # Cargar la direcci�n de la coma en $a0
    syscall                 # Llamar a syscall para imprimir la coma

    # Imprimir el segundo n�mero de la serie
    li $v0, 1           # C�digo de syscall para imprimir entero
    move $a0, $t2       # Mover el segundo n�mero a $a0
    syscall             # Llamar a syscall para imprimir el n�mero

    # Sumar los dos primeros n�meros
    add $t3, $t1, $t2   # Sumar Fibonacci(0) y Fibonacci(1)

    # Generar e imprimir el resto de la serie
    loop:
        beq $t4, $t0, end_loop  # Si el contador alcanza la cantidad deseada, salir del bucle

        add $t5, $t1, $t2       # Calcular el siguiente n�mero de la serie
        move $t1, $t2           # Actualizar los valores para el siguiente ciclo
        move $t2, $t5

        # Imprimir una coma antes del siguiente n�mero
        li $v0, 4               # C�digo de syscall para imprimir cadena
        la $a0, caracter_coma   # Cargar la direcci�n de la coma en $a0
        syscall                 # Llamar a syscall para imprimir la coma

        # Imprimir el siguiente n�mero de la serie
        li $v0, 1               # C�digo de syscall para imprimir entero
        move $a0, $t5           # Mover el siguiente n�mero a $a0
        syscall                 # Llamar a syscall para imprimir el n�mero

        # Sumar el siguiente n�mero a la suma total
        add $t3, $t3, $t5       # Sumar el siguiente n�mero a la suma total

        addi $t4, $t4, 1        # Incrementar el contador
        j loop                  # Saltar al inicio del bucle

    end_loop:
        # Imprimir un salto de l�nea
        li $v0, 4               # C�digo de syscall para imprimir cadena
        la $a0, salto_linea     # Cargar la direcci�n del salto de l�nea en $a0
        syscall                 # Llamar a syscall para imprimir el salto de l�nea

        # Imprimir la suma de la serie
        li $v0, 4               # C�digo de syscall para imprimir cadena
        la $a0, suma_serie      # Cargar la direcci�n del mensaje en $a0
        syscall                 # Llamar a syscall para imprimir el mensaje

        li $v0, 1               # C�digo de syscall para imprimir entero
        move $a0, $t3           # Mover la suma total a $a0
        syscall                 # Llamar a syscall para imprimir la suma

        # Salir del programa
        li $v0, 10      # C�digo de syscall para salir del programa
        syscall         # Llamar a syscall para salir
