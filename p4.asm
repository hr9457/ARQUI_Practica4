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
    and bx,0          ; borrador lo que tenga bx para usarlo
    mov bl,posicion
    mov si,bx         ; contador se mueve a si
    mov bl,caracter   ; muevo el caracter
    mov vector[si],bl ;guardo el caracter en la posicion que resive
endm
; - - - - - - - - - - - - - -- - - - - - - - - - - - - - - - - - - - - - - - -



; ========== macro para guardar numero dentro de un vector  
GET_NUMBER_VECTOR macro vector,posicion   
    and bx,0          ; borrador lo que tenga bx para usarlo
    mov bl,posicion
    mov si,bx         ; contador se mueve a si
    mov bl,vector[si] ; obtiene el caracter del vector en posicion si y guarda en bl
endm
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
            
              
            ; caracter <
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
            inc contador_numeros_push
            inc posicion_vector_numeros2
            jmp vector_a_binario

       
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
            mov al,1d            
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
            inc posicion_vector_binario 

            mov contador_numeros_push,0
             
            inc posicion_vector_numeros2
             
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
            inc posicion_vector_binario 

            mov contador_numeros_push,0
             
            inc posicion_vector_numeros2
            
            ; regreso al ciclo para ver el siguiente numero 
            jmp vector_a_binario 

                
            
       
       
       


    ; ============ op para genera los ordenamientos 
    op_ordenar:
        PRINT txt_ordenar
        PAUSA_PANTALLA

        jmp menu






    ;============ op para genera un reporte en el programa
    op_generar_reporte:
        PRINT txt_reporte
        PAUSA_PANTALLA

        jmp menu





    ; ================ op para salir del programa
    op_salir:
        .exit



end