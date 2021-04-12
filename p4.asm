; ----------- macro para limpiar la pantalla 
LIMPIAR_PANTALLA macro
	mov ah,00h
	mov al,03h
	int 10h
endm
; - - - - - - - - - - - - - -- - - - - - - - - - - - - - - - - - - - - - - - -




; -------- macro para poner una espera en pantalla
PAUSA_PANTALLA macro
    mov ah,08
	int 21h
endm
; - - - - - - - - - - - - - -- - - - - - - - - - - - - - - - - - - - - - - - -




;---------- macro para imprimir un caracter 
PRINT macro cadena
    mov ah,09h
    lea dx,cadena
    int 21h 
endm
; - - - - - - - - - - - - - -- - - - - - - - - - - - - - - - - - - - - - - - -
        
        
        
;-------------- macro para impresion de caracteres por pantalla
PRINT_CARACTER macro caracter
    mov ah,02h 
    mov dl,caracter               
    int 21h
endm  
; - - - - - - - - - - - - - -- - - - - - - - - - - - - - - - - - - - - - - - -      



;-------------------------  macro para valida la extension del archivo de entrada  -----------------------------
VALIDAR_EXTENSION macro 
    ; local = para uar etiquetas en solo esta macro
    local for,fin_ciclo_for

    mov si,0            ; iterador lo pon en cero para comenzar la lectura de la ruta 
    mov ruta_valida,0   ; pone la variable booleana en 0 para hacer la validacion

    
    ; incio del ciclo for
    for:
        cmp si,100 ; tamanio del vector
        jge fin_ciclo_for ; salta a fin del ciclo si llega a la poscion 100 de la ruta


        ; lectura del caracter en la poscion del si
        mov al,path[si]

        ; verificacion del  caracter .
        cmp al,46 
        je validar_punto

        ; verificaciond el caracter caracter $
        cmp al,36
        je fin_ciclo_for

        ; a la hora de no  cumplir salta a la etiqueta
        jmp continuar_ciclo


        ; valida cuando encuentre un punt en la ruta
        validar_punto:
            inc si ;incremento en el contador
            mov al,path[si] ;obtiene el valor siguiente de la cadena
            cmp al,120 ;letra x
            je validar_m
            jmp error_ruta ; error al no encontra la x


            ; hace la validad de la letra m en la ruta
            validar_m:
                inc si ;incrementa el contador
                mov al,path[si] ; obtengo el siguiente caracter
                cmp al,109 ; se valida la letra M
                je validar_l
                jmp error_ruta ; erro en al no encontrar la m


                ; validacion de la letra l en la ruta
                validar_l:
                    inc si
                    mov al,path[si]

                    ; encuentra la letra l en la ruta salta a la etiqueta validez
                    cmp al,108
                    je validez

                    jmp error_ruta ; errro en la ruta al no encontrar la l


                    ; cambia la variable booleana a 1 = true, la extesion de la ruta es valida
                    validez:
                    mov ruta_valida,1
                    jmp fin_ciclo_for ; termina el ciclo


        ; hace que el ciclo for continue
        continuar_ciclo:
            inc si
            jmp for 


        ; mensaje de erro en la ruta de entrada
        error_ruta:
            PRINT txt_error_extension


    ; termina el ciclo for
    fin_ciclo_for:


endm   
;- - - fin del la macro para la validacion de la extensio de la ruta
; - - - - - - - - - - - - - -- - - - - - - - - - - - - - - - - - - - - - - - -




;================= macro para saber si hay un numero en la entrada del archivo
NUMERO macro fragmento
    cmp fragmento,48
    jmp es_numero
    
    cmp fragmento,49
    jmp es_numero 
    
    cmp fragmento,50
    jmp es_numero
    
    cmp fragmento,51
    jmp es_numero
    
    cmp fragmento,52
    jmp es_numero
    
    cmp fragmento,53
    jmp es_numero
    
    cmp fragmento,54
    jmp es_numero 
    
    cmp fragmento,55
    jmp es_numero
    
    cmp fragmento,56
    jmp es_numero 
    
    cmp fragmento,57
    jmp es_numero
    
    
endm   
; - - - - - - - - - - - - - -- - - - - - - - - - - - - - - - - - - - - - - - -





; ========== macro para guardar numero dentro de un vector  
INSERT_VECTOR macro vector,posicion,caracter   
    mov bx,0          ; borrador lo que tenga bx para usarlo
    mov bl,posicion
    mov si,bx         ; contador se mueve a si
    mov bl,caracter   ; muevo el caracter
    mov vector[si],bl ;guardo el caracter en la posicion que resive
endm
; - - - - - - - - - - - - - -- - - - - - - - - - - - - - - - - - - - - - - - -



; ========== macro para guardar numero dentro de un vector  
GET_NUMBER_VECTOR macro vector,posicion
    mov bx,0          ; borrador lo que tenga bx para usarlo
    mov bl,posicion
    mov si,bx         ; contador se mueve a si
    mov bl,vector[si] ; obtiene el caracter del vector en posicion si y guarda en bl
endm
; - - - - - - - - - - - - - -- - - - - - - - - - - - - - - - - - - - - - - - -



; ========== obtener el numero binario del vector
GET_NUMBER_BINARY macro vector,posicion,variable  
    mov bx,0          ; borrador lo que tenga bx para usarlo
    mov bl,posicion
    mov si,bx         ; contador se mueve a si
    mov bl,vector[si] ; obtiene el caracter del vector en posicion si y guarda en bl
    mov variable,bl
endm
; - - - - - - - - - - - - - -- - - - - - - - - - - - - - - - - - - - - - - - - 


; ========== insertar en un vector binario
SET_VECTOR_BINARY macro vector,posicion,variable
    ;mov si,0  
    mov bx,0          ; borrador lo que tenga bx para usarlo
    mov bl,posicion
    mov si,bx         ; contador se mueve a si
    mov bl,variable
    mov vector[si],bl   
    
endm
; - - - - - - - - - - - - - -- - - - - - - - - - - - - - - - - - - - - - - - - 
 


; ========== macro para imprimir el vector binario
PRINT_NUM macro numero ; Macro para imprimir un numero (Número de 16 bits)
    MOV AH, 02H
    MOV DL, numero
    add DL, 30H
    int 21H
endm
; - - - - - - - - - - - - - -- - - - - - - - - - - - - - - - - - - - - - - - - 



; ========== macor para imprimir un vector en binario
PRINT_BINARY_VECTOR macro vector,tamanio_vector

    ; ciclos locales del metodo
    local for_vector_binario,fin_for_vector_binario,imprimir_decena,imprimir_unidad

    ; variables para hacer la division
    mov unidad,0d
    mov decena,0d

    ; asigno el tamanio del vector a un contador para para el for 
    mov numero_en_posicion,0d
    mov variable,0d
    mov cx,0    
    mov ax,0
    mov dx,0
    mov cl,tamanio_vector
    mov n,cx

    ; -> inicio del ciclo for para recorrer un vector binario
    for_vector_binario:

            ;-> condidcion de salida del ciclo for 
            cmp n,0
            je fin_for_vector_binario            
            
            ;-> obtener el numero en binario
            GET_NUMBER_BINARY vector,numero_en_posicion,variable 
            
            
            ;-> division de la variable para saber su decena y unidad            
            mov dl,variable
            mov ax,dx
            mov cociente_division,10d 
            cwd
            div cociente_division
                         
           
            ;-> guardo la decena decena
            mov decena,al      
            
                        
            ;-> guardo la unidad
            mov unidad,dl   
                    
                        
            ;--- si existiera una decena en el numero
            cmp decena,0
            jne imprimir_decena
            
            ;--- si existiera una unidad en el numero
            cmp unidad,0
            jne imprimir_unidad
                     
                        
            ;--- muevo al siguiente posicion del vector
            inc numero_en_posicion                         
            ;--- decremento el numero para el ciclo for            
            dec n                        
            ;--- repitre el ciclo
            jmp for_vector_binario
            
                
         
        ;--- imprimir unidad si exite 
        imprimir_decena:
            PRINT_NUM decena  
            
        
        ;--- imprimir decena si exite
        imprimir_unidad:
            PRINT_NUM unidad 
            inc numero_en_posicion
            dec n 
            PRINT_CARACTER '-'
            jmp for_vector_binario 
            
            
        ;-> salia del ciclo for
        fin_for_vector_binario:
            PAUSA_PANTALLA ;-> pusa de pantalla para visualizar los numeros
            ;jmp menu

endm
; - - - - - - - - - - - - - -- - - - - - - - - - - - - - - - - - - - - - - - -  
  


; ========== macro para hacer una copi de un vector 
COPY_PASTE_VECTOR macro vector_fuente,vector_destino,tamanio_vector,size_copia

    ;-- etiquetas locales de la macro
    local for,fin_for

    ;--- variables utilizadas en el ciclo
    mov inicio_for_copia,0d ;variable para el for
    mov numero_a_copiar,0d  ;
    mov variable_copia,0d   ;variable para copiar el numero

    mov bx,0
    mov bl,tamanio_vector
    mov si,0d

    ;-> incio del ciclo for
    for:
        ;-> condicion de salida del ciclo for (mayor o igual)
        cmp inicio_for_copia,bl
        jge fin_for 

        ;-> obtener el numero en cierta poscion del vector original
        GET_NUMBER_BINARY vector_fuente,inicio_for_copia,variable_copia

        ;->depositar el numero en el vector destino (copia)
        SET_VECTOR_BINARY vector_destino,inicio_for_copia,variable_copia

        ;-> incremento en el for
        inc inicio_for_copia 

        ;-> incremeo el tamanio del vector copia
        inc size_copia

        ;-> para comprara con bl en el for por si se pierde el dato en bl
        mov bl,tamanio_vector

        ;-> regreos a la etiqueta for
        jmp for

    ;-> termina el cilo for
    fin_for:


endm 
; - - - - - - - - - - - - - -- - - - - - - - - - - - - - - - - - - - - - - - -  


; ========== Ordenamiento burbuja para un vector
ORDENAMIENTO_BURBUJA macro vector,size_vector

    local for_burbuja,intercambio,fin_burbuja_j,fin_burbuja

    ;-------------- limpieza y copia de variables
    mov i,0d
    mov j,0d
    mov temporal,0d
    mov valor_en_posicion_j,0d   
    mov valor_en_posicion_j_masUno,0d
    mov volor_en_posicion_i, 0d 
    mov siguiente_j,1d

    mov ax,0
    mov al,size_vector 
    mov size_copia2,al
    dec size_copia2
    mov cx,0
    mov dx,0 
    mov bx,0
    mov ax,0
    mov cl,size_vector
    mov dl,size_copia2


    for_burbuja:
            
            ;-- condicion de salida
            ;-- salta si i es mayor a dx
            cmp i,cl
            jnle fin_burbuja              
            
            ;---- for interno
            for_burbuja_j:
                
                ;---- condicion de salida  
                cmp j,dl
                jnle fin_burbuja_j
                
                
                ;--- if vector[j] > vector[j+1] 
                GET_NUMBER_BINARY copia_vector_binario,j,valor_en_posicion_j
                GET_NUMBER_BINARY copia_vector_binario,siguiente_j,valor_en_posicion_j_masUno 
                
                
                mov al,valor_en_posicion_j
                mov bl,valor_en_posicion_j_masUno
                
                ;--- si el numero vector[j] > a vector[j+1]
                cmp valor_en_posicion_j,bl
                jg  intercambio  
                
                
                ;--- regresa 
                inc j
                inc siguiente_j
                jmp for_burbuja_j
                
                
                ;-- intercambio de posiciones
                intercambio:
                    
                    ;--- temporal = vector[j]
                    GET_NUMBER_BINARY copia_vector_binario,j,temporal
                    
                    ;--- vector[j] = vector[j+1] 
                    SET_VECTOR_BINARY copia_vector_binario,j,valor_en_posicion_j_masUno
                    
                    
                    ;--- vector[j+1] = temporal 
                    SET_VECTOR_BINARY copia_vector_binario,siguiente_j,temporal
                
                    
                    ;--- regresa 
                    inc j ;j++
                    inc siguiente_j ;j+1 ++
                    jmp for_burbuja_j               
                
                
                
            fin_burbuja_j:
                inc i ;i++
                mov j,0d 
                mov siguiente_j,1d
                mov temporal,0
                mov valor_en_posicion_j_masUno,0
                mov valor_en_posicion_j,0   
                jmp for_burbuja        
        
            
            
        ;-> fin del ciclo burbuja   
        fin_burbuja:     

endm
; - - - - - - - - - - - - - -- - - - - - - - - - - - - - - - - - - - - - - - -  



; ========== ordenamiento burbuja descendente
ORDENAMIENTO_BURBUJA_DES macro vector,size_vector

    local for_burbuja_des,intercambio_des,fin_burbuja_j_des,fin_burbuja_des
    
    mov i,0d
    mov j,0d
    mov temporal,0d
    mov valor_en_posicion_j,0d   
    mov valor_en_posicion_j_masUno,0d
    mov volor_en_posicion_i,0d 
    mov siguiente_j,1d
    mov size_copia2,0d

    mov ax,0
    mov al,size_vector
    mov size_copia2,al
    dec size_copia2
    mov cx,0
    mov dx,0 
    mov bx,0
    mov ax,0
    mov cl,size_vector
    mov dl,size_copia2


    for_burbuja_des:
            
            ;-- condicion de salida
            ;-- salta si i es mayor a dx
            cmp i,cl
            jnle fin_burbuja_des
                          
            
            ;---- for interno
            for_burbuja_j_des:
                
                ;---- condicion de salida  
                cmp j,dl
                jnle fin_burbuja_j_des
                
                
                ;--- if vector[j] > vector[j+1] 
                GET_NUMBER_BINARY vector,j,valor_en_posicion_j
                GET_NUMBER_BINARY vector,siguiente_j,valor_en_posicion_j_masUno 
                
                
                mov al,valor_en_posicion_j
                mov bl,valor_en_posicion_j_masUno
                
                ;--- si el numero vector[j] < a vector[j+1]
                cmp valor_en_posicion_j,bl
                jng  intercambio_des 
                
                
                ;--- regresa 
                inc j
                inc siguiente_j
                jmp for_burbuja_j_des
                
                
                ;-- intercambio de posiciones
                intercambio_des:
                    
                    ;--- temporal = vector[j]
                    GET_NUMBER_BINARY vector,j,temporal
                    
                    ;--- vector[j] = vector[j+1] 
                    SET_VECTOR_BINARY vector,j,valor_en_posicion_j_masUno
                    
                    
                    ;--- vector[j+1] = temporal 
                    SET_VECTOR_BINARY vector,siguiente_j,temporal
                
                    
                    ;--- regresa 
                    inc j ;j++
                    inc siguiente_j ;j+1 ++
                    jmp for_burbuja_j_des               
                
                
                
            fin_burbuja_j_des:
                inc i ;i++
                mov j,0d 
                mov siguiente_j,1d
                mov temporal,0
                mov valor_en_posicion_j_masUno,0
                mov valor_en_posicion_j,0   
                jmp for_burbuja_des        
        
            
            
        ;-> fin del ciclo burbuja   
        fin_burbuja_des: 
         

endm
; - - - - - - - - - - - - - -- - - - - - - - - - - - - - - - - - - - - - - - - 



; ========== macro para escribir en archivo de reporte
WRITE_IN_FILE macro cadena,tamanio_cadena

    mov ah,40h
    mov bx,handler2
    mov cx,tamanio_cadena
    mov dx,0
    mov dx,offset cadena 
    int 21h 

endm 
; - - - - - - - - - - - - - -- - - - - - - - - - - - - - - - - - - - - - - - - 



; ========== macro para convertir un numero binario a ASCII
NUMBER_BINARY_ASCII macro numero,contador

    local DOWHILE,ESCRIBIR_ASCII,FIN_ESCRIBIR_ASCII

    ;-> limpieza 
    mov contador,0d
    mov dx,0d
    mov ax,0d

    mov al,numero 

    DOWHILE:
        
        mov dx,0d
        mov cx,10d
        div cx

        ;-> empuje a la pila y aumento numeros en pila
        push dx
        inc contador

        ;-> comparamos el resultado del cociente
        cmp ax,0
        jnle DOWHILE


    ;-> sacado de la pila 
    mov ax,0

    ESCRIBIR_ASCII:

        ;-> condicion de salida
        ;-> salta si el contador es igual a 0
        cmp contador,0
        je FIN_ESCRIBIR_ASCII


        pop dx
        mov numero_en_pila,dl 
        add numero_en_pila,30h
        dec contador

        ;-> se escribe en el archivo
        WRITE_IN_FILE numero_en_pila,1d

        ;-> repite el ciclo 
        jmp ESCRIBIR_ASCII


    FIN_ESCRIBIR_ASCII:



endm
; - - - - - - - - - - - - - -- - - - - - - - - - - - - - - - - - - - - - - - -


; ========== macro para pintar un pixel
pintar_pixel macro i,j,color

    push ax
    push bx
    push di 
    mov ax,0
    mov bx,0
    mov di,0
    mov ax,320d
    mov bx,i
    mul bx
    add ax,j
    mov di,ax
    mov [di],color
    pop di
    pop bx
    pop ax

endm
; - - - - - - - - - - - - - -- - - - - - - - - - - - - - - - - - - - - - - - -


; ========== macro para pintar el marco
pintar_marco macro izquierda,derecha,arriba,abajo,color

    local ciclo1,ciclo2

    push si
    
    mov si,0
    mov si,izquierda
    ciclo1:

        pintar_pixel arriba,si,color
        pintar_pixel abajo,si,color        
        inc si
        cmp si,derecha
        jne ciclo1

    mov si,0
    mov si,arriba
    ciclo2:
        pintar_pixel si,derecha,color
        pintar_pixel si,izquierda,color
        inc si 
        cmp si,abajo
        jne ciclo2
    
    pop si

endm 
; - - - - - - - - - - - - - -- - - - - - - - - - - - - - - - - - - - - - - - -




; ========== macro para ir a la datos
MOV_DATA macro  
    push ax
    mov ax,@data
    mov ds,ax
    pop ax
endm 
; - - - - - - - - - - - - - -- - - - - - - - - - - - - - - - - - - - - - - - -



; ========== macro para ir al modo de video
MOV_VIDEO macro  
    push ax
    mov ax,0A000h
    mov ds,ax
    pop ax 
endm 
; - - - - - - - - - - - - - -- - - - - - - - - - - - - - - - - - - - - - - - -  


; ========== 
video macro
    mov ax,0013h
    int 10h
    mov ax,0A000h
    mov ds,ax
endm 
; - - - - - - - - - - - - - -- - - - - - - - - - - - - - - - - - - - - - - - -  



; ========== 
fin_video macro
    mov ax,0003h
    int 10h
    mov ax,@data
    mov ds,ax
endm 
; - - - - - - - - - - - - - -- - - - - - - - - - - - - - - - - - - - - - - - -  
  

POSICION_TEXTO macro posX,posY
    mov ax,0
    mov ah,02h
    mov bh,00h
    mov dh,posX ;23 filas
    mov dl,posY ;118col
    int 10h
endm 

delay macro parametro
    push ax
    push bx
    mov ax,0
    mov bx,0
    mov ax,parametro
    ret2:
        dec ax
        jz finRet
        mov bx,parametro
        ret1:
            dec bx
        jnz ret1
    jmp ret2
    finRet:
    pop bx
    pop ax 
endm 

; ========== 

; - - - - - - - - - - - - - -- - - - - - - - - - - - - - - - - - - - - - - - -  
  



;--------------------------------------------------------------- programa general ----------------------------------------------------------------------
.model small
.stack
.data

    ;para imprimir un salto de liena por consola
    salto_linea db ' ',10,13,'$' 

    ; para imprimri un encabezado por consola
    txt_encabezado  db "Universidad de San Carlos de Guatemala",13,10
                    db "Facultad de Ingenieria",13,10				
                    db "Arquitectura de Computadores y Ensambladores 1",13,10
                    db "Primer Semestre 2021",13,10
                    db "Seccion A",13,10
                    db "Hector Josue Orozco Salazar",13,10
                    db "201314296",13,10,'$'


    ; par imprimir un menu por consola
    txt_menu    db  '**************************',10,13
                db  '*   MENU PRINCIPAL       *',10,13
                db  '*   1. Cargar archivo    *',10,13
                db  '*   2. Ordenar           *',10,13
                db  '*   3. Generar Reporte   *',10,13
                db  '*   4. Salir             *',10,13
                db  '*   5. Video             *',10,13
                db  '**************************',10,13,'$'


    ;---------     cargar archivo  
    txt_cargar_archivo db 'Cargando archivo',10,13,'$'
    txt_ordenar db 'ordenar',10,13,'$'
    txt_reporte db 'generar reporte',10,13,'$'




    ;------------------------ variables para la lectura del archivo xml --------
    archivo db 'entrada.xml'
    
    ;elementos para la lectura del archivo 
    handler dw ?
    mensaje_error1 db 'Error no se puedo abrir el archivo',10,13,'$' 
    mensaje_error2 db 'Error no se puedo ller el archivo'
    fragmento db 1 dup('$')
    limpiar db 1 dup('$')

      
    ;----------- impresiones par mostara al usuario  
    ruta_valida db 0
    contador db 0
    txt_ingrese_ruta    db 10,13,'Ingrese la ruta del archivo: ','$' 
    txt_error_extension db 10,13,'La ruta del aarchivo no es valida','$'
    path                db 100 dup('$')  
    separador_numero_entrada db '-' 
    contador_numeros_entrada db 0  
    
    
    ;---------- vector para guardar los numero de entrada por el archivo xml
    vector db 80 dup('$') 
    posicion_vector_numeros db 0
    tamanio_vector db 0
    contador_recorrido db 0
    msg_prueba db 'Hola mundo!!!',10,13,'$'


    ;---------- utilidades para convertir el vector a un vector binario
    posicion_vector_numeros2 db 0  
    contador_numeros_push db 0      
    aux_unidades db 0  
    vector_binario db 80 dup('$') 
    posicion_vector_binario dw 0


    ;---------- utilidades para convertir y imprimir un numero binario a decimal
    numero_vector_binario db 0
    cociente db 0
    residuio db 0
    total db 0
    numero_binario dw 0
    cantidad_numeros_vector_binario db 0 


    ;---------- utilidades para imprimir el vector binario
    n dw 0  
    msg_hola_mundo db 'hola mundo!!!',10,13,'$'
    variable db 0
    numero_en_posicion db 0
    cociente_division dw 0
    residuo_division dw 0
    unidad db 0
    decena db 0


    ;----------- utilidades para el ordenamiento burbuja
    copia_vector_binario db 80 dup('$')
    copia_vector_burbuja_descendente db 80 dup('$')
    size_copia_burbuja_des db 0
    inicio_for_copia db 0
    numero_a_copiar db 0
    variable_copia db 0
    size_copia db 0
    msg_copia db 'copia del vector',10,13,'$'
    msg_ordenamiento_burbuja db 'vector por ordenamiento burbuja',10,13,'$'
    msg_ordenamiento_burbuja_des db 'vector por ordenamiento burbuja descendente',10,13,'$'
    
    
    i db 0
    j db 0
    temporal db 0  
    size_copia2 db 0  
    valor_en_posicion_j db 0   
    valor_en_posicion_j_masUno db 0
    volor_en_posicion_i db 0 
    siguiente_j db 1


    
    ;------------ utilidades para crear un archivo para el reporte 
    archivo_reporte db 'reporte.xml',0  
    
    etiqueta_encabezado db '<Arqui>',10;8
                        db '<Encabezado',10;12
                        db '<Universidad>Universidad de San Carlos de Guatemala</Universidad>',10
                        db '<Facultad>Facultad de Ingenieria</Facultad>',10
                        db '<Escula>Ciencias y Sistemas</Escuela>',10
                        db '<Curso>',10
                        db '<Nombre>Arquitectura de Computadores y Ensambladores 1</Nombre>',10
                        db '<Seccion>Seccion A</Seccion>',10
                        db '</Curso>',10
                        db '<Ciclo>Primer Semestre 2021</Ciclo>',10,'$'
    
                      
    apertura_fecha db '<Fecha>',10,'$';8
    apertura_dia db '<Dia>','$';5
    cierre_dia db '</Dia>',10,'$';7
    apertura_mes db '<Mes>','$';5
    cierre_mes db '</Mes>',10,'$';7
    apertura_anio db '<Ano>','$';5 
    anio_2021 db '2021','$';4
    cierre_anio db '</Ano>',10,'$';7
    cierre_fecha db '</Fecha>',10,'$';9    
    apertura_hora db '<Hora>',10,'$';7    
    apertura_hora2 db '<Hora>','$';6
    cierre_hora2 db '</Hora>',10,'$';8
    apertura_minutos db '<Minutos>','$';9
    cierre_minutos db '</Minutos>',10,'$';11
    apertura_segundos db '<Segundos>','$';10
    cierre_segundos db '</Segundos>',10,'$';12
    cierre_hora db '</Hora>',10,'$';8
    
    etiqueta_alumno db  '<Alumno>',10
                    db  '<Nombre>Hector Josue Orozco Salazar</Nombre>',10
                    db  '<Carnet>201314296</Carnet>',10
                    db  '</Alumno>',10,'$' ;90
    
                       
    dia db 0
    mes db 0 
    anio dw 0 
    division_fecha db 0  
    resultado_fecha dw 0  

    hora db 0
    minutos db 0
    segundos db 0               
                       
    handler2 dw ?                                                 
    
    msg_error_creacion_archivo db 'Error: No se puede crear el archivo',10,13,'$'
    msg_error_escritura_archivo db 'Error: No se pudo escribir en el archivo',10,13,'$'
    msg_exito_reporte db 'Reporte creado con exito',10,13,'$'
    
    contador_pila db 0 
    numero_en_pila db 0



    ;---------------- utilidades para dibujar
    num db '22','$'
    titulo db 'USAC','$'
    ordenamiento db 'Burbuja','$'
    time db 'Tiempo: 00:00','$'
    velocidad db 'Velocidad: 5','$'
  


.code

    mov ax,@data
    mov ds,ax

    ;***************** Inicio del menu principal
    menu:
        ;limpia la pantalla
        LIMPIAR_PANTALLA

        ;impresionpor consola
        PRINT txt_encabezado 
        PRINT salto_linea
        PRINT txt_menu 
        
        ;entrada por consola
        mov ah,08
        int 21h


        ;opciones del menu
        cmp al,49
        je op_cargar_archivo

        cmp al,50
        je op_ordenar

        cmp al,51
        je op_generar_reporte

        cmp al,52
        je op_salir

        cmp al,53
        je dibujo

        jmp menu



    ; op para cargar un archivo
    op_cargar_archivo:

        ;imprimo un texto para que el usuario ingrese una ruta
        PRINT txt_ingrese_ruta

        mov cx,100  ; contador con el tamanio del vector para guardar el path
        mov si,0    ; limpieza del si
        

        ; inico de la lectura de la ruta del archivo de entrada
        lectura:
            cmp si,cx ; verificacion si el contrador es igual al tamanio del vector
            jge fin_lectura

            ;ingreso de caracter por consola
            mov ah,01
            int 21h

            ; verificaciond el tecla enter 
            cmp al,13d
            je fin_lectura


            ;guardar el caracter leido en el vector path
            mov path[si],al ;concateno
            inc si ; incremento
            jmp lectura ;regreso para lectura del siguiente caracter



        ; fin de la lectura de la ruta
        fin_lectura:
            mov path[si],0



        ;PRINT salto_linea ; impresion de un salto de linea
        ;PRINT path        ; imprime la ruta ingresada
        ;------ validacion de la extension ingresada por el usuario
        VALIDAR_EXTENSION ; valida la extension 
        PAUSA_PANTALLA    ; hace una pausa en pantalla
        
        PRINT salto_linea


        
        ; ==================== apertura y lectura del archivo de entrada
        mov ah,3dh
        mov al,0
        mov dx, offset path
        int 21h
        jc error1 
        mov handler,ax



        ; =================== lectura del archivo caracter por caracter 
        leer:
            mov ah,3fh
            mov bx,handler
            mov dx,offset fragmento
            mov cx,1
            int 21h

            jc errro2

            cmp ax,0 ; EOF del archivo
            jz cerrar_archivo ; cierre del archivo 
            
              
            ; caracter < <>49<L>
            cmp fragmento,60
            je separador
                     
                 
            ; mayor al rango :
            cmp fragmento,57
            jg no_es_numero 
       
             
            ; menor al rango /                 
            cmp fragmento,48
            jl no_es_numero     
                 
            
            NUMERO fragmento         
                     

         
           

        ; =========== impresion si se ha detectado un numero
        es_numero:
            PRINT fragmento ;imprime el caracter
            inc contador_numeros_entrada ; contador numero entrada
                                                     
                                                     
            ;ingreso al vector para guardar el numero
            INSERT_VECTOR vector,posicion_vector_numeros,fragmento
            inc posicion_vector_numeros 

            ;incremento el tamanio del vector
            inc tamanio_vector 
            
             
            jmp leer
             
        
        
        
        ; ============ cuando es no es un numero    
        no_es_numero:
            jmp leer  
            
       
                      
                      
          
        ; ======= verificacion del caracter < despues de leer un numero    
        separador:
            cmp contador_numeros_entrada,0
            je leer
            
            PRINT_CARACTER '-' 
            
            ;ingreso al vector para guardar el numero
            INSERT_VECTOR vector,posicion_vector_numeros,'-'
            inc posicion_vector_numeros 

            ; incremento el tamanio del vector
            inc tamanio_vector
            
            mov contador_numeros_entrada,0
            jmp leer      


                               
                               
              

        ; ================== error1 indica al usuario que hubo un erro en la apertura del archivo
        error1:   
            PRINT salto_linea
            PRINT mensaje_error1
            PAUSA_PANTALLA
            jmp menu ; regresa al menu  
            
                                   
                                   
                       

        ; =================== error 2 indica al usuario hubo error durante la lectura del archivo
        errro2: 
            PRINT salto_linea
            PRINT mensaje_error2
            PAUSA_PANTALLA 
             
                                    
                                    


        ; ===================== cierra del archivo
        cerrar_archivo:
            mov ah,3eh
            mov bx,handler
            int 21h

            ; agrego caracter de finalizacion al vector
            INSERT_VECTOR vector,posicion_vector_numeros,'$'
            inc tamanio_vector
            PAUSA_PANTALLA


            ; === prueba impresion de elementos del vectos
            PRINT salto_linea
            PRINT vector            
            PAUSA_PANTALLA 
            
            


        ; ==== conversion del vector a un vector con numeros completos y en binario
        ; ==== para que la comparacion en los ordenamientos sea mas facil
        ; asegurar que empiezen en 0
        mov contador_numeros_push,0
        mov posicion_vector_numeros2,0
        vector_a_binario:                                    
                                     
            ; obtengo el primer caracter del vector
            GET_NUMBER_VECTOR vector,posicion_vector_numeros2                
              
              
            ;saber si el vector llego al final de la cadena
            cmp bl,'$'
            je menu             
            
            
            ;saber si hay un cambio hacia otro numero
            cmp bl,'-'
            je unir_numeros
                           
                           
            ;empujo a la pila
            push bx   
            inc contador_numeros_push    ; saber cuantos push se ha hecho
            inc posicion_vector_numeros2 ; uso para buscar en tal posicion del vector de entrada
            jmp vector_a_binario         ; regres para leer el siguiente caracter


       
         ; ==== union de numeros para convertirlos en uno solo
         unir_numeros:            
         
            ;--- dos unidades
            cmp contador_numeros_push,2d
            je dos_unidades           
            
            
            ;---- una unidad
            cmp contador_numeros_push,1d 
            je una_unidad
            
            
            
         dos_unidades:
            pop bx            
            sub bl,30h            
            mov al,1d      ; 10      
            mul bl              
            
            mov aux_unidades,al
            
           
            pop bx            
            sub bl,30h            
            mov al,10d            
            mul bl             
            
            add al,aux_unidades            
                                     
            mov si,posicion_vector_binario                         
            mov vector_binario[si],al           
            
            
            ;--- reinicio de variable
            ;-> posicion en el vector binario que se va insertar
            inc posicion_vector_binario 

            ;-> reinicio del contador de cuantos push se hicieron a la pils
            mov contador_numeros_push,0

            ;-> posicion del vector de donde se esta leendo
            inc posicion_vector_numeros2

            ;-> size del vector binario donde se almacenan los numeros
            inc cantidad_numeros_vector_binario
             
            ; regreso al ciclo para ver el siguiente numero 
            jmp vector_a_binario 



        una_unidad:
            pop bx
            sub bl,30h
            mov al,1d
            mul bl 
            mov aux_unidades,al
            
            mov si,posicion_vector_binario
            mov vector_binario[si],al

            ;--- reinicio de variable
            ;-> posicion en el vector binario que se va insertar
            inc posicion_vector_binario 

            ;-> reinicio del contador de cuantos push se hicieron a la pils
            mov contador_numeros_push,0

            ;-> posicion del vector de donde se esta leendo
            inc posicion_vector_numeros2

            ;-> size del vector binario donde se almacenan los numeros
            inc cantidad_numeros_vector_binario
            
            ; regreso al ciclo para ver el siguiente numero 
            jmp vector_a_binario 

                
            
       
       
       


    ; ============ op para genera los ordenamientos 
    op_ordenar:
        PRINT txt_ordenar
        PAUSA_PANTALLA

        PRINT salto_linea

        ;-> impresion del vector binario
        PRINT_BINARY_VECTOR vector_binario,cantidad_numeros_vector_binario

        ;-> prueba para hcer una copia del vector
        PRINT salto_linea
        PRINT msg_copia 
        PAUSA_PANTALLA
        

        ;->realizacion de la copia del vector
        ;COPY_PASTE_VECTOR vector_binario,copia_vector_binario,cantidad_numeros_vector_binario
             
        PAUSA_PANTALLA     

             
        ; realizacion de una copia de un vector fuenta a otro vector destino
        ; realizacion de una copia para el ordenamiento burbuja ascendente
        COPY_PASTE_VECTOR vector_binario,copia_vector_binario,cantidad_numeros_vector_binario,size_copia  


        ; realizacion de una copia para el ordentamient burbuja descendente
        COPY_PASTE_VECTOR vector_binario,copia_vector_burbuja_descendente,cantidad_numeros_vector_binario,size_copia_burbuja_des
         
         
        ; impresion de la copia del vector que se va ordenar
        PRINT_BINARY_VECTOR copia_vector_binario,size_copia


        ;->ordenamiento burbuja
        PRINT salto_linea 
        PRINT msg_ordenamiento_burbuja  
        PRINT salto_linea
        
        
        ;-------------- metodo para usar el metodo burbuja sobre un vector
        ORDENAMIENTO_BURBUJA copia_vector,size_copia
          
          
        ;-----------------------------------
        ; impresion de la copia del vector  despues del ordenamiento burbuja ascendente
        PRINT_BINARY_VECTOR copia_vector_binario,size_copia
        PAUSA_PANTALLA


        ;-------------- titulo para ordenamiento descendente
        PRINT salto_linea 
        PRINT msg_ordenamiento_burbuja_des  
        PRINT salto_linea   
                            
                            
        
        ;-------------- aplicacion del ordenamiento burbuja descendente
        ORDENAMIENTO_BURBUJA_DES copia_vector_burbuja_descendente,size_copia_burbuja_des 
        
                      
        ; impresion del ordenamient bubuja descendente
        PRINT_BINARY_VECTOR copia_vector_burbuja_descendente,size_copia_burbuja_des
        


        ;->regreso al menu
        jmp menu 



    ;============ op para genera un reporte en el programa
    op_generar_reporte:
        PRINT txt_reporte
        PAUSA_PANTALLA


        mov ax,0 
        mov bx,0
        mov dx,0 
        mov cx,0
        inicio:              
             ;crear archivo
             mov ah,3ch
             mov cx,0
             mov dx,offset archivo_reporte 
             int 21h        
            
             ;si hay error en la creacion
             jc error_creacion_archivo
             mov handler2, ax
             
            
            ; ESCRIBIR EN EL ARCHIVO
            WRITE_IN_FILE etiqueta_encabezado,314d
             
            ;DIA MES ANIO
             mov ah,2Ah
             int 21h
             
             mov dia,dl
             mov mes,dh
             mov anio,cx 
             
             
             WRITE_IN_FILE apertura_fecha,8d
             
             ;dia
             WRITE_IN_FILE apertura_dia,5d             
             NUMBER_BINARY_ASCII dia,contador_pila                    
             WRITE_IN_FILE cierre_dia,7d
             
             ;mes
             WRITE_IN_FILE apertura_mes,5d
             NUMBER_BINARY_ASCII mes,contador_pila
             WRITE_IN_FILE cierre_mes,7d
             
             ;anio
             WRITE_IN_FILE apertura_anio,5d
             WRITE_IN_FILE anio_2021,4d
             WRITE_IN_FILE cierre_anio,7d
             
             WRITE_IN_FILE cierre_fecha,9d


            ;-- hora       
             mov ah,2CH
             int 21h
             
             mov hora,ch
             mov minutos,cl
             mov segundos,dh
             
             
             
             WRITE_IN_FILE apertura_hora,7d
             ;hora
             WRITE_IN_FILE apertura_hora2,6d
             NUMBER_BINARY_ASCII hora,contador_pila
             WRITE_IN_FILE cierre_hora2,8d 
             ;minutos
             WRITE_IN_FILE apertura_minutos,9d 
             NUMBER_BINARY_ASCII minutos,contador_pila
             WRITE_IN_FILE cierre_minutos,11d
             ;SEGUNDOS
             WRITE_IN_FILE apertura_segundos,10d
             NUMBER_BINARY_ASCII segundos,contador_pila
             WRITE_IN_FILE cierre_segundos,12d

             
             WRITE_IN_FILE etiqueta_alumno,90d
             
             
            
            
             ; si hay error en la escritura, CF=1
             jc error_escritura_reporte
            
             jmp fin_creacion_reporte  
            
                            
         error_creacion_archivo: 
             PRINT salto_linea
             PRINT msg_error_creacion_archivo  
             PAUSA_PANTALLA    
            
            
         error_escritura_reporte:
             PRINT salto_linea
             PRINT msg_error_escritura_archivo
             PAUSA_PANTALLA    
            
            
        
         fin_creacion_reporte:
             ; cierre del archivo
             mov ah,3eh
             mov bx,handler2
             int 21h
            
             PRINT msg_exito_reporte
             PAUSA_PANTALLA
             jmp menu




    ; ================ op para dibujar algo
    dibujo:

        video

        ;posicion del numero
        POSICION_TEXTO 0d,0d

        ;obtengo el valor de la variables
        MOV_DATA

        PRINT ordenamiento

        
        ;posicion del numero
        POSICION_TEXTO 0d,9d

        PRINT time 

        ;posicion del numero
        POSICION_TEXTO 0d,23d

        PRINT velocidad  

        ;modo video
        MOV_VIDEO


        ;izq, der, arr, abj, color
        ;pintado del marco
        pintar_marco 0d,319d,13d,199d,10d



        ;PINTAR_BARRA 155d,100d 
        

        ;posicion del numero
        ; posicon hasta abjo del marco
        POSICION_TEXTO 23d,58d

        ;obtengo el valor de la variables
        MOV_DATA

        ; imprime 
        PRINT num 

        ; regro al modo video 
        MOV_VIDEO

        ; espera 
        delay 4000

        ; fin del modo vido al modo normal
        fin_video


        jmp menu 



    ; ================ op para salir del programa
    op_salir:
        .exit



end