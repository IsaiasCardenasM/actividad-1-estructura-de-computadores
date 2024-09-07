.data
cantidad_numeros: .asciiz "Ingrese la cantidad de n�meros a comparar (3-5): "                   # Mensaje para solicitar la cantidad de n�meros
validacion_cantidad_numeros: .asciiz "Cantidad inv�lida. La cantidad debe ser entre 3 y 5.\n"   # Mensaje de error para cantidad inv�lida
numero_ingresado: .asciiz "Ingrese un n�mero: "                                                 # Mensaje para solicitar un n�mero
resultado: .asciiz "El n�mero menor es: "                                                       # Mensaje para mostrar el resultado

.text
main:
    # Bucle para solicitar la cantidad de n�meros hasta que sea v�lida
fn_solicitar_cantidad_n�meros:
    li $v0, 4                       # C�digo de servicio para imprimir cadena
    la $a0, cantidad_numeros        # Cargar la direcci�n del mensaje en $a0
    syscall                         # Llamada al sistema para imprimir el mensaje

    li $v0, 5                       # C�digo de servicio para leer un entero
    syscall                         # Llamada al sistema para leer el entero
    move $t0, $v0                   # Guardar la cantidad de n�meros en $t0

    # Validar la cantidad de n�meros
    li $t4, 3                               # Cargar el valor 3 en $t4
    li $t5, 5                               # Cargar el valor 5 en $t5
    blt $t0, $t4, fn_cantidad_invalida      # Si $t0 < 3, ir a fn_cantidad_invalida
    bgt $t0, $t5, fn_cantidad_invalida      # Si $t0 > 5, ir a fn_cantidad_invalida

    # Inicializar el menor n�mero a un valor muy alto
    li $t1, 2147483647      # Cargar el valor m�ximo de un entero en $t1

    # Bucle para leer los n�meros
    li $t2, 0   # Inicializar el contador de n�meros ingresados en 0

fn_leer_numeros:
    beq $t2, $t0, fn_encontrar_minimo  # Si se han ingresado todos los n�meros, ir a fn_encontrar_minimo

    # Solicitar un n�mero
    li $v0, 4                   # C�digo de servicio para imprimir cadena
    la $a0, numero_ingresado    # Cargar la direcci�n del mensaje en $a0
    syscall                     # Llamada al sistema para imprimir el mensaje

    li $v0, 5                   # C�digo de servicio para leer un entero
    syscall                     # Llamada al sistema para leer el entero
    move $t3, $v0               # Guardar el n�mero ingresado en $t3

    # Comparar con el menor n�mero actual
    blt $t3, $t1, fn_actualizar_minimo  # Si $t3 < $t1, ir a fn_actualizar_minimo
    j fn_siguiente_numero               # De lo contrario, ir a fn_siguiente_numero

fn_actualizar_minimo:
    move $t1, $t3  # Actualizar el menor n�mero con el valor de $t3

fn_siguiente_numero:
    addi $t2, $t2, 1    # Incrementar el contador de n�meros ingresados
    j fn_leer_numeros   # Volver a leer otro n�mero

fn_encontrar_minimo:
    # Mostrar el menor n�mero
    li $v0, 4           # C�digo de servicio para imprimir cadena
    la $a0, resultado   # Cargar la direcci�n del mensaje en $a0
    syscall             # Llamada al sistema para imprimir el mensaje

    li $v0, 1           # C�digo de servicio para imprimir entero
    move $a0, $t1       # Mover el menor n�mero a $a0
    syscall             # Llamada al sistema para imprimir el n�mero

    # Salir del programa
    li $v0, 10          # C�digo de servicio para salir del programa
    syscall             # Llamada al sistema para terminar

fn_cantidad_invalida:
    # Mostrar mensaje de cantidad inv�lida
    li $v0, 4                               # C�digo de servicio para imprimir cadena
    la $a0, validacion_cantidad_numeros     # Cargar la direcci�n del mensaje en $a0
    syscall                                 # Llamada al sistema para imprimir el mensaje

    # Volver a solicitar la cantidad de n�meros
    j fn_solicitar_cantidad_n�meros     # Volver a fn_solicitar_cantidad_n�meros
