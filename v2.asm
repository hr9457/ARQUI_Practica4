; ----------- macro para limpiar la pantalla 
LIMPIAR_PANTALLA macro
	mov ah,00h
	mov al,03h
	int 10h
endm


; -------- macro para poner una espera en pantalla
PAUSA_PANTALLA macro
    mov ah,08
	int 21h
endm


PRINT macro cadena
    mov ah,09h
    lea dx,cadena
    int 21h 
endm


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

    archivo db 'C:\Users\joshu\Desktop\practica4entrada.xml' 
    archivo2 db 'C:\prueba\entrada.xml' 
    handler dw ?
    mensaje_error1 db 'Error no se puedo abrir el archivo',10,13,'$' 
    mensaje_error2 db 'Error no se puedo ller el archivo'
    fragmento db 5 dup('$')
    limpiar db 5 dup('$') 
    
    
    txt_ingreso_ruta db 10,13,'Ingrese la ruta del archivo: ','$' 
    path db 100 dup(' ')


.code

    mov ax,@data
    mov ds,ax

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
        
    
        ;abrir el archivo
        mov ah,3dh
        mov al,0 
        ;mov dx,offset archivo 
        mov dx,offset archivo2
        int 21h
        jc  error1
        mov handler,ax


    leer:
        mov ah,3fh
        mov bx,handler
        mov dx,offset fragmento
        mov cx,1
        int 21h         
        jc error2
        cmp ax,0 ; si ax = 0 significa EOF
        jz fin ; final del archivo

        PRINT fragmento


    ; limpia la cadena donde se esta guardando lo que se esta llendo de la cadaena y continua
    limpiarCadena: 
        mov si,offset limpiar
        mov di,offset fragmento
        mov cx,2
        rep movsb
        jmp leer ; regreso a la lectura del archivo donde se quedo   
           
    
        
    fin:
        ; cerrar el archivo
        mov ah,3eh
        mov bx,handler
        int 21h 
        
        ;pausa dramatica
        PAUSA_PANTALLA
        
        jmp menu             
         
        
    error1:
        PRINT mensaje_error1        
        ;pausa
        PAUSA_PANTALLA
        
        ; regreso al menu
        jmp menu  
        
        
    error2:
        PRINT mensaje_error2        
        ;pausa
        PAUSA_PANTALLA       
        
        ;regreso al menu
        jmp menu 



    ; opo para genera los ordenamientos 
    op_ordenar:
        PRINT txt_ordenar
        PAUSA_PANTALLA

        jmp menu



    ; op para genera un reporte en el programa
    op_generar_reporte:
        PRINT txt_reporte
        PAUSA_PANTALLA

        jmp menu



    ; op para salir del programa
    op_salir:
        .exit



end