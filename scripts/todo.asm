; todo.asm - a todo list in pure x86_64 assembly because we hate ourselves
; compile: nasm -f elf64 todo.asm && ld todo.o -o todo
; or with gcc: nasm -f elf64 todo.asm && gcc -no-pie todo.o -o todo

section .data
    menu_text db "=== TODO LIST ===", 10
              db "1. add todo", 10
              db "2. list todos", 10
              db "3. mark done", 10
              db "4. delete todo", 10
              db "5. quit", 10
              db "choice: ", 0
    menu_len equ $ - menu_text
    
    prompt_todo db "enter todo: ", 0
    prompt_len equ $ - prompt_todo
    
    prompt_num db "enter number: ", 0
    prompt_num_len equ $ - prompt_num
    
    empty_msg db "no todos yet!", 10, 0
    empty_len equ $ - empty_msg
    
    done_marker db " [DONE]", 0
    newline db 10
    
    todo_file db "todos.txt", 0
    
section .bss
    choice resb 2
    input_buffer resb 256
    todo_storage resb 10240  ; storage for up to 40 todos (256 bytes each)
    todo_count resb 1
    todo_done resb 40        ; done flags for each todo
    
section .text
    global _start

_start:
    ; initialize
    mov byte [todo_count], 0
    call load_todos

main_loop:
    ; print menu
    mov rax, 1
    mov rdi, 1
    mov rsi, menu_text
    mov rdx, menu_len
    syscall
    
    ; read choice
    mov rax, 0
    mov rdi, 0
    mov rsi, choice
    mov rdx, 2
    syscall
    
    ; check choice
    mov al, [choice]
    cmp al, '1'
    je add_todo
    cmp al, '2'
    je list_todos
    cmp al, '3'
    je mark_done
    cmp al, '4'
    je delete_todo
    cmp al, '5'
    je exit_program
    
    jmp main_loop

add_todo:
    ; check if we have space
    mov al, [todo_count]
    cmp al, 40
    jge main_loop  ; too many todos
    
    ; print prompt
    mov rax, 1
    mov rdi, 1
    mov rsi, prompt_todo
    mov rdx, prompt_len
    syscall
    
    ; read todo text
    mov rax, 0
    mov rdi, 0
    mov rsi, input_buffer
    mov rdx, 256
    syscall
    
    ; calculate where to store this todo
    movzx rbx, byte [todo_count]
    imul rbx, 256
    lea rdi, [todo_storage + rbx]
    
    ; copy input to storage
    mov rsi, input_buffer
    mov rcx, 256
    rep movsb
    
    ; increment count
    inc byte [todo_count]
    
    ; save to file
    call save_todos
    
    jmp main_loop

list_todos:
    ; check if empty
    mov al, [todo_count]
    cmp al, 0
    je list_empty
    
    ; print each todo
    xor rbx, rbx  ; counter
    
list_loop:
    cmp bl, [todo_count]
    jge main_loop
    
    ; print number
    mov rax, rbx
    inc rax
    add al, '0'
    mov [input_buffer], al
    mov byte [input_buffer + 1], '.'
    mov byte [input_buffer + 2], ' '
    
    mov rax, 1
    mov rdi, 1
    mov rsi, input_buffer
    mov rdx, 3
    syscall
    
    ; calculate todo location
    push rbx
    imul rbx, 256
    lea rsi, [todo_storage + rbx]
    pop rbx
    
    ; find length (up to newline or null)
    push rbx
    mov rcx, 256
    xor rax, rax
find_len:
    lodsb
    cmp al, 10
    je found_len
    cmp al, 0
    je found_len
    loop find_len
found_len:
    mov rdx, 256
    sub rdx, rcx
    pop rbx
    
    ; print todo
    push rbx
    imul rbx, 256
    lea rsi, [todo_storage + rbx]
    mov rax, 1
    mov rdi, 1
    syscall
    pop rbx
    
    ; check if done
    lea rsi, [todo_done + rbx]
    cmp byte [rsi], 1
    jne not_done
    
    ; print done marker
    mov rax, 1
    mov rdi, 1
    mov rsi, done_marker
    mov rdx, 7
    syscall
    
not_done:
    ; print newline if needed
    push rbx
    imul rbx, 256
    lea rsi, [todo_storage + rbx]
    add rsi, rdx
    dec rsi
    cmp byte [rsi], 10
    pop rbx
    je skip_newline
    
    mov rax, 1
    mov rdi, 1
    mov rsi, newline
    mov rdx, 1
    syscall
    
skip_newline:
    inc rbx
    jmp list_loop

list_empty:
    mov rax, 1
    mov rdi, 1
    mov rsi, empty_msg
    mov rdx, empty_len
    syscall
    jmp main_loop

mark_done:
    ; check if empty
    mov al, [todo_count]
    cmp al, 0
    je main_loop
    
    ; print prompt
    mov rax, 1
    mov rdi, 1
    mov rsi, prompt_num
    mov rdx, prompt_num_len
    syscall
    
    ; read number
    mov rax, 0
    mov rdi, 0
    mov rsi, input_buffer
    mov rdx, 3
    syscall
    
    ; convert to number
    movzx rax, byte [input_buffer]
    sub al, '0'
    cmp al, 1
    jl main_loop
    dec al
    cmp al, [todo_count]
    jge main_loop
    
    ; mark as done
    lea rbx, [todo_done + rax]
    mov byte [rbx], 1
    
    call save_todos
    jmp main_loop

delete_todo:
    ; check if empty
    mov al, [todo_count]
    cmp al, 0
    je main_loop
    
    ; print prompt
    mov rax, 1
    mov rdi, 1
    mov rsi, prompt_num
    mov rdx, prompt_num_len
    syscall
    
    ; read number
    mov rax, 0
    mov rdi, 0
    mov rsi, input_buffer
    mov rdx, 3
    syscall
    
    ; convert to number
    movzx rax, byte [input_buffer]
    sub al, '0'
    cmp al, 1
    jl main_loop
    dec al
    cmp al, [todo_count]
    jge main_loop
    
    ; shift todos down
    movzx rbx, al
    imul rbx, 256
    lea rdi, [todo_storage + rbx]
    lea rsi, [rdi + 256]
    
    movzx rcx, byte [todo_count]
    sub cl, al
    dec cl
    imul rcx, 256
    rep movsb
    
    ; shift done flags
    movzx rbx, al
    lea rdi, [todo_done + rbx]
    lea rsi, [rdi + 1]
    movzx rcx, byte [todo_count]
    sub cl, al
    dec cl
    rep movsb
    
    ; decrement count
    dec byte [todo_count]
    
    call save_todos
    jmp main_loop

save_todos:
    ; create/truncate file
    mov rax, 2      ; sys_open
    mov rdi, todo_file
    mov rsi, 0x241  ; O_WRONLY | O_CREAT | O_TRUNC
    mov rdx, 0644o
    syscall
    cmp rax, 0
    jl save_done
    mov r12, rax    ; save fd
    
    ; write count
    mov rax, 1
    mov rdi, r12
    lea rsi, [todo_count]
    mov rdx, 1
    syscall
    
    ; write todos
    movzx rdx, byte [todo_count]
    imul rdx, 256
    mov rax, 1
    mov rdi, r12
    mov rsi, todo_storage
    syscall
    
    ; write done flags
    mov rax, 1
    mov rdi, r12
    mov rsi, todo_done
    movzx rdx, byte [todo_count]
    syscall
    
    ; close file
    mov rax, 3
    mov rdi, r12
    syscall
    
save_done:
    ret

load_todos:
    ; open file
    mov rax, 2      ; sys_open
    mov rdi, todo_file
    mov rsi, 0      ; O_RDONLY
    syscall
    cmp rax, 0
    jl load_done
    mov r12, rax
    
    ; read count
    mov rax, 0
    mov rdi, r12
    lea rsi, [todo_count]
    mov rdx, 1
    syscall
    
    ; read todos
    movzx rdx, byte [todo_count]
    imul rdx, 256
    mov rax, 0
    mov rdi, r12
    mov rsi, todo_storage
    syscall
    
    ; read done flags
    mov rax, 0
    mov rdi, r12
    mov rsi, todo_done
    movzx rdx, byte [todo_count]
    syscall
    
    ; close file
    mov rax, 3
    mov rdi, r12
    syscall
    
load_done:
    ret

exit_program:
    call save_todos
    mov rax, 60
    xor rdi, rdi
    syscall
