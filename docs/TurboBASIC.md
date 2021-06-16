# Turbo-BASIC XL cheatsheet



## Turbo-BASIC XL keywords

```
+---------+--------+-------------------------+
+ Keyword |  Type  | Description             |
+---------+--------+-------------------------+
+         |        |                         |
+         |        |                         |
+         |        |                         |
+         |        |                         |
+         |        |                         |
+         |        |                         |
+         |        |                         |
+---------+--------+-------------------------+
```

## Operators

### List of Turbo-BASIC XL operators

```
+----------+------------+---+---------------------------------+
+ Operator | Type       |new| Description                     |
+----------+------------+---+---------------------------------+
| AND      | logical    |no | logical conjunction             |
| OR       | logical    |no | logical disjunction             |
| NOT      | logical    |no | logical negation                |
|          |            |   |                                 |
|          |            |   |                                 |
|          |            |   |                                 |
|          |            |   |                                 |
+----------+------------+---+---------------------------------+
```

## Functions

### List of Turbo-BASIC XL functions

```
+----------+--------------+---+----------------------------------------------------------+
+ Function | Type         |new| Description                                              |
+----------+--------------+---+----------------------------------------------------------+
| ABS      | arithmetic   |no | absolute value of a number                               |
| ADR      | system       |no | address in memory of a string                            |
| ASC      | conversion   |no | ATASCII value of character                               |
| ATN      | goniometric  |no | arctangent of a number                                   |
| CLOG     | logarithmic  |no | common logarithm of a number                             |
| COS      | goniometric  |no | cosine of a number                                       |
| EXP      | logarithmic  |no | exponential function                                     |
| FRE      | system       |no | amount of free memory in bytes                           |
| INT      | arithmetic   |no | computes floor of a number                               |
| LEN      | string       |no | returns the length of a string                           |
| LOG      | logarithmic  |no | natural logarithm of a number                            |
| PADDLE   | input device |no | position of a paddle controller                          |
| PEEK     | system       |no | the value at an address in memory                        |
| PTRIG    | input device |no | indicates whether a paddle trigger is pressed or not     |
| RND      | system       |no | a pseudorandom number                                    |
| SGN      | arithmetic   |no | signum of a number                                       |
| SIN      | goniometric  |no | sine of a number                                         |
| SQR      | arithmetic   |no | square root of a number                                  |
| STICK    | input device |no | a joystick position                                      |
| STRIG    | input device |no | indicates whether a joystick trigger is pressed or not   |
| STR$     | string       |no | converts a number to string form                         |
| USR      | system       |no | calls a machine code routine, optionally with parameters |
| VAL      | string       |no | returns the numeric value of a string                    |
+----------+--------------+---+----------------------------------------------------------+
```

### `ABS`

Function `ABS` computes absolute value of a number. Both integers and floating
point numbers are supported by this function.

For negative numbers it returns the number distance from zero:

```basic
1 ------------------------------
2 REM ABS function computation
3 REM for negative integer value
4 ------------------------------
10 PRINT ABS(-10)
999 STOP 

```

For positive numbers, the original value is returned:

```basic
1 ------------------------------
2 REM ABS function computation
3 REM for positive integer value
4 ------------------------------
10 PRINT ABS(10)
999 STOP 

```

As mentioned above, it is possible to call this function with floating point
number:

```basic
1 ------------------------------
2 REM ABS function computation
3 REM for negative float value
4 ------------------------------
10 PRINT ABS(-3.14)
999 STOP 

```

### `ASC`

```basic
10 PRINT ASC("A")

```

```basic
10 PRINT ASC("ABC")

```

```basic
10 PRINT ASC("")

```

### `CHR$`

```basic
10 PRINT CHR$(42)

```

```basic
10 PRINT CHR$(1234)

```

```basic
10 PRINT CHR$(42.3)

```

### `FRE`


```basic
10 PRINT FRE(0)

```

```basic
10 PRINT FRE(42)

```

```basic
10 PRINT FRE(3.1415)

```

## Loops

Four types of loops are supported by Turbo-BASIC XL:

* `FOR-NEXT` (taken from Atari BASIC with one bug fix)
* `DO-LOOP`
* `REPEAT-UNTIL`
* `WHILE-WEND`

