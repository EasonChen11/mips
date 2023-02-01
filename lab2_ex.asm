#程序通常包含.data section 和.text section
.data #作為記憶體配置

#前面的result可以視為變數，後面的Result f= 則以 編碼作為字串儲存
result:.asciiz"\nResult f = (i<j)?g+h:g-h = " #$s0
g:.asciiz "g = 10" #$s1
h:.asciiz "h = 5"  #$s2

inputi: .asciiz "Input i= " #$s3
inputj: .asciiz "Input j= " #$s4

.text #作為程式碼
.globl main
main:
	#$a0-$a3=引數(argument)暫存器
	#$v0-$v1=數值(value)暫存器
	#$t0-t9=整數(integer)暫存器
	
	addi $s1,$s1,10  # g=10
	addi $s2,$s2,5   #h=5
	
	#------------------------ Print "Input i= ----------------------------
	li $v0,4	          # load syscall code (4 : print string) 
	la $a0,inputi 	# load address of string to be printed into $a0 
	syscall	 	# print str 
	li $v0,5		# load syscall code (5 : read int)
	syscall		# read int 
	add $t3,$zero,$v0
	#------------------------ Print "Input j= ----------------------------
	li $v0,4
	la $a0,inputj
	syscall
	li $v0,5
	syscall
	add $t4,$zero,$v0
	
	
	#------------------------ f = (i<j) ? g+h:g-h ----------------------------
	slt $t1,$t3,$t4   	#slt rd rs rt       if (rs<rt) rd=1;else rd=0
	beq $t1,$zero,Else
	add $s0,$s1,$s2
	j Exit
	
	Else:sub $s0,$s1,$s2
	

	
#------------------------ Print "Input g,h ----------------------------
Exit:
	li $v0,4
	la $a0,g
	syscall
	li $v0,4
	la $a0,h
	syscall
	
#------------------------ Print  result ----------------------------
	li $v0,4
	la $a0,result
	syscall
	li $v0,1
	add $a0,$zero,$s0
	syscall
	
#------------------------ system call for quit ----------------------
li $v0,10
syscall

