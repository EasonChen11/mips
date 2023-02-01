# MIPS textbook
## 基礎配置
程序通常包含.data section 和.text section
```assembly=
.data #作為記憶體配置
.text #作為程式碼
```
#為註解

## 變數宣告
```assembly=
name: .type content
```


| 指令(type) | content |
| -------- | -------- | 
| .word     | 32bits(integer) |
|.asciiz |string|
|.ascii|character|

## 常用指令集


| 指令 | 格式            | mean                                                       |
| ---- | --------------- | ---------------------------------------------------------- |
| li   | li rd ,number   | rd 直接存入number                                          |
| lw   | lw rd ,adress   | 把address(地址)內所存的值存入rd                            |
| la   | la rd ,adress   | 把address(地址)存入rd ->直接存地址                         |


### 運算
| 指令 | 格式            | mean                                                       |
| ---- | --------------- | ---------------------------------------------------------- |
| add  | $t0,$t1,$t2     | $t0 = $t1 + $t2;   add as signed (2's complement) integers |
| sub  | sub $t2,$t3,$t4 | $t2 = $t3 - $t4                                            |
| addi | $t2,$t3, 5      | $t2 = $t3 + 5;   "add immediate" (no sub immediate)        |
| addu | $t1,$t6,$t7     | $t1 = $t6 + $t7;   add as unsigned integers                |
| subu | $t1,$t6,$t7     | $t1 = $t6 + $t7;   subtract as unsigned integers           |
| div  | $t5,$t6         | Lo = $t5 / $t6   (integer quotient)                        |
| move | $t2,$t3         | $t2 = $t3                                                  |


### bool
| 指令 | 格式            | mean                                                       |
| ---- | --------------- | ---------------------------------------------------------- |
| j    | label           | jump to label                                              |
| beq  | $t0,$t1,target  | branch to target if  $t0 = $t1                             |
| blt  | $t0,$t1,target  | branch to target if  $t0 < $t1                             |
| ble  | $t0,$t1,target  | branch to target if  $t0 <= $t1                            |
| bgt  | $t0,$t1,target  | branch to target if  $t0 > $t1                             |
| bge  | $t0,$t1,target  | branch to target if  $t0 >= $t1                            |
| bne  | $t0,$t1,target  | branch to target if  $t0 <> $t1                            |


![](https://i.imgur.com/X63w1xc.png)
		

## $v0 指令集syscall
| Service       | Code in $v0 | Arguments                                        | Result                    |
| ------------- | ----------- | ------------------------------------------------ | ------------------------- |
| print integer | 1           | $a0 = integer to print                           |                           |
| print float   | 2           | $f12 = float to print                            |                           |
| print double  | 3           | $f12 = double to print                           |                           |
| print string  | 4           | $a0 = address of null-terminated string to print |                           |
| read integer  | 5           |                                                  | $v0 contains integer read |
| read float    | 6           |                                                  | $f0 contains float read   |
| read double   | 7           |                                                  | $f0 contains double read  |
