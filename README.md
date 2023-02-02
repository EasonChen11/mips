# MIPS textbook

[![hackmd-github-sync-badge](https://hackmd.io/8n2JdqOVR6iX5pJkUD-d-g/badge)](https://hackmd.io/8n2JdqOVR6iX5pJkUD-d-g)

https://github.com/EasonChen11/mips
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


| 指令 | 格式          | mean                               |
| ---- | ------------- | ---------------------------------- |
| li   | li rd ,number | rd 直接存入number                  |
| lw   | lw rd ,adress | 把address(地址)內所存的值存入rd    |
| lwc1 | lw rd ,adress | 因為float 和double記憶體在c1       |
| ldc1 | lw rd ,adress | load double to c1                  |
| mflo | mflo rd       | rd=lo                              |
| mfhi     |  mfhi rd             |   rd=hi                                 |
| la   | la rd ,adress | 把address(地址)存入rd ->直接存地址 |


### 運算
| 指令 | 格式                    | mean                                                                                                                                              |
| ---- | ----------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------- |
| add  | $t0,    $t1,    $t2     | $t0 = $t1 + $t2;   add as signed (2's complement) integers                                                                                        |
| sub  | sub $t2,    $t3,    $t4 | $t2 = $t3 - $t4                                                                                                                                   |
| addi | $t2,    $t3, 5          | $t2 = $t3 + 5;   "add immediate" (no sub immediate)                                                                                               |
| addu | $t1,    $t6,    $t7     | $t1 = $t6 + $t7;   add as unsigned integers                                                                                                       |
| subu | $t1,    $t6,    $t7     | $t1 = $t6 + $t7;   subtract as unsigned integers                                                                                                  |
| div  | div $t5,    $t6         | Lo = $t5 / $t6   (integer quotient商)    hi=    $t5 %    $t6(integer remainder餘數) [(mflo,mfhi)](#%E5%B8%B8%E7%94%A8%E6%8C%87%E4%BB%A4%E9%9B%86) |
|      | div $a0,    $t5,    $t6 | $a0=    $t5+    $t6                                                                                                                               |
|      | div $a0, $t0, number    | $a0=    $t0/    number                                                                                                                            |
| mul  | mul $a0,    $t0,    $t1 | $a0=    $t0    +    $t1                                                                                                                           |
| sll  | sll rd ,rt,sa           | rd = rt shifted left by distance sa                                                                                                               |
| move | $t2,    $t3             | $t2 = $t3                                                                                                                                         |
:::info
不同型態的vale對應的運算不同，ex.double add use add.d
:::

### bool
| 指令 | 格式            | mean                                                       |
| ---- | --------------- | ---------------------------------------------------------- |
| j    | label           | jump to label                                              |
| beq  | $t0,    $t1,target  | branch to target if  $t0 = $t1                             |
| blt  | $t0,    $t1,target  | branch to target if  $t0 < $t1                             |
| ble  | $t0,    $t1,target  | branch to target if  $t0 <= $t1                            |
| bgt  | $t0,    $t1,target  | branch to target if  $t0 > $t1                             |
| bge  | $t0,    $t1,target  | branch to target if  $t0 >= $t1                            |
| bne  | $t0,    $t1,target  | branch to target if  $t0 != $t1                            |


![](https://i.imgur.com/X63w1xc.png)
		

## $v0 指令集syscall
| Service       | Code in $v0 | Arguments                                                                  | Result                    |
| ------------- | ----------- | -------------------------------------------------------------------------- | ------------------------- |
| print integer | 1           | <font color="#f00">$a0</font> = integer to print                           |                           |
| print float   | 2           | <font color="#f00">$f12</font> = float to print                            |                           |
| print double  | 3           | <font color="#f00">$f12</font> = double to print                           |                           |
| print string  | 4           | <font color="#f00">$a0</font> = address of null-terminated string to print |                           |
| read integer  | 5           |                                                                            | $v0 contains integer read |
| read float    | 6           |                                                                            | $f0 contains float read   |
| read double   | 7           |                                                                            | $f0 contains double read  |

## 暫存器比較


| 暫存器     | 功能                                                                                                   | 備註                           |
| ---------- | ------------------------------------------------------------------------------------------------------ | ------------------------------ |
| $v0        | 系統功能 [v0功能](#v0-%E6%8C%87%E4%BB%A4%E9%9B%86syscall) |                                |
| $a0 ~ $a3  |                                                                                                        |                                |
| $t0 ~ $t9  |                                                                                                        |                                |
| $s0 ~ $s7  |                                                                                                        |                                |
| $f0 ~ $f31 | 暫存flat or double                                                                                     | 存入時語法為 lwc1 ...  or ldc1 同lw語法 |

## call function
### function name
```assembly=
label:    ...
```
兩個必須指令
$jal$ and $jr$
```assembly=
jal label    #跳轉到label並且記錄此刻的位置，記錄在$ra
...
lebel:
    ...
    jr $ra    #跳轉到$ra的位置
```
$jal$ 讓我們呼叫函式後可以回到進程
>j 指令只能移動到指定的label

$jr$ 回到指定位置($ra) 繼續進程