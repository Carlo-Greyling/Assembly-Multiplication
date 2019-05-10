SYS_EXIT  equ 1
SYS_READ  equ 3
SYS_WRITE equ 4
STDIN     equ 0
STDOUT    equ 1

segment .data											;Data section. Used for declaring constants or initialized data

   msg1 db "Enter a digit ", 0xA,0xD 
   len1 equ $- msg1 

   msg2 db "Please enter a second digit", 0xA,0xD 
   len2 equ $- msg2 

   msg3 db "The total is: "
   len3 equ $- msg3

segment .bss											;Bss section. Used for declaring variables

   num1 resb 2 
   num2 resb 2 
   res resb 1    

section	.text											;Section that contains actual program code
   global _start    									;Tells the Kernel where to start executing the program
	
_start:             									;Indicates the linker entry point
   mov eax, SYS_WRITE         							;Transfer the value of SYS_WRITE (equ = 4) into the eax register
   mov ebx, STDOUT         
   mov ecx, msg1         
   mov edx, len1 
   int 0x80 											;Calls the Kernel               

   mov eax, SYS_READ 
   mov ebx, STDIN  
   mov ecx, num1 
   mov edx, 2
   int 0x80            

   mov eax, SYS_WRITE        
   mov ebx, STDOUT         
   mov ecx, msg2          
   mov edx, len2         
   int 0x80

   mov eax, SYS_READ  
   mov ebx, STDIN  
   mov ecx, num2 
   mov edx, 2
   int 0x80        

   mov eax, SYS_WRITE         
   mov ebx, STDOUT         
   mov ecx, msg3          
   mov edx, len3         
   int 0x80

   ; moving the first number to eax register and second number to ebx
   ; and subtracting ascii '0' to convert it into a decimal number
	
   mov eax, [num1]
   sub eax, '0'
	
   mov ebx, [num2]
   sub ebx, '0'

   ; add eax and ebx
   mul ebx
   ; add '0' to to convert the sum from decimal to ASCII
   add eax, '0'

   ; storing the sum in memory location res
   mov [res], eax

   ; print the sum 
   mov eax, SYS_WRITE        
   mov ebx, STDOUT
   mov ecx, res         
   mov edx, 1        
   int 0x80

exit:    
   
   mov eax, SYS_EXIT   	;System call variable, exits system
   xor ebx, ebx 
   int 0x80				;call Kernel