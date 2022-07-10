  DIM = 5
.data
  vet0: .word 13, 32, 93, 67, 56
  vet1: .word 1, 47, 76, 12, 83
  res: .space DIM
  newline: .asciiz "\n"
.text
.globl main
.ent main
main:
addi $sp $sp -4
sw $ra 0($sp)

la $a0 vet0
la $a1 vet1
li $a3 DIM
la $a2 res

jal hamming

li $t0 0
la $t1 res
loopE:
 beq $t0 DIM endMain
 lbu $a0 0($t1)
 li $v0 1
 syscall
 
 la $a0 newline
 li $v0 4
 syscall

 addiu $t1 $t1 1
 addiu $t0 $t0 1
 j loopE

endMain:
lw $ra 0($sp)
addiu $sp $sp 4
jr $ra

.end main



.ent hamming
hamming:
addi $sp $sp -32
sw $ra 28($sp)
sw $s6 24($sp)
sw $s5 20($sp)
sw $s4 16($sp)
sw $s3 12($sp)
sw $s2 8($sp)
sw $s1 4($sp)
sw $s0 0($sp)

move $s0 $a0 #vet1 
move $s1 $a1 #vet2
move $s2 $a3 #DIM
move $s6 $a2 #ris

li $s3 0 #i

loop:
  beq $s3 $s2 endHamming
  
  lw $s4 0($s0)
  lw $s5 0($s1)
  xor $a0 $s4 $s5
  jal contaUno
  sb $v0 0($s6)
  
  addiu $s6 $s6 1 
  addiu $s0 $s0 4
  addiu $s1 $s1 4
  addiu $s3 $s3 1
  j loop 

endHamming:
lw $ra 28($sp)
lw $s6 24($sp)
lw $s5 20($sp)
lw $s4 16($sp)
lw $s3 12($sp)
lw $s2 8($sp)
lw $s1 4($sp)
lw $s0 0($sp)
addi $sp $sp 32
jr $ra

  

.end hamming


.ent contaUno
contaUno:
  move $t1 $a0 #byte
  li $t0 0 #cont
  li $t3 0 #i
  
 loopCont:
  beq $t3 8 endCont
  andi $t2 $t1 1
  add $t0 $t0 $t2
  
  srl $t1 $t1 1  
  addi $t3 $t3 1
  j loopCont
  
 endCont:
  move $v0 $t0
  jr $ra
.end contaUno