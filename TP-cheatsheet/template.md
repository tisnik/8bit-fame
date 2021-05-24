# Turbo-BASIC XL cheatsheet

changequote(`{{', `}}')

## Turbo-BASIC XL keywords

```
+---------+--------+-------------------------+
+ Keyword |  Type  | Description             |
+---------+--------+-------------------------+
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

Function `ABS` computes absolute value of a number. Both integers and floating point numbers are supported.

```basic
include({{function_abs_1.bas}})
```

```basic
include({{function_abs_2.bas}})
```

```basic
include({{function_abs_3.bas}})
```

```basic
include({{function_abs_4.bas}})
```


### `ADR`

```basic
include({{function_adr_1.bas}})
```

```basic
include({{function_adr_2.bas}})
```

```basic
include({{function_adr_3.bas}})
```


### `ASC`

```basic
include({{function_asc_1.bas}})
```

```basic
include({{function_asc_2.bas}})
```

```basic
include({{function_asc_3.bas}})
```

### `ATN`

```basic
include({{function_atn_1.bas}})
```

```basic
include({{function_atn_2.bas}})
```

```basic
include({{function_atn_3.bas}})
```

### `CHR$`

```basic
include({{function_chr$_1.bas}})
```

```basic
include({{function_chr$_2.bas}})
```

```basic
include({{function_chr$_3.bas}})
```

### `COS`


```basic
include({{function_cos_1.bas}})
```

```basic
include({{function_cos_2.bas}})
```

```basic
include({{function_cos_3.bas}})
```

### `FRE`


```basic
include({{function_fre_1.bas}})
```

```basic
include({{function_fre_2.bas}})
```

```basic
include({{function_fre_3.bas}})
```

### `SIN`


```basic
include({{function_sin_1.bas}})
```

```basic
include({{function_sin_2.bas}})
```

```basic
include({{function_sin_3.bas}})
```

```basic
include({{function_sin_cos.bas}})
```

## Loops

Four types of loops are supported by Turbo-BASIC XL:

* `FOR-NEXT` (taken from Atari BASIC with one bug fix)
* `DO-LOOP`
* `REPEAT-UNTIL`
* `WHILE-WEND`

### `FOR-NEXT`

This variant of loop construct was taken from Atari BASIC, including the bug mentioned below. Because Turbo-BASIC XL is designed to be as compatible with Atari BASIC as possible, the buggy behaviour can be switched on or turn off.

* Basic usage of this loop:

```basic
include({{for_next_basic.bas}})
```

* Default step value is set to 1, but it can be specified explicitly if needed:

```basic
include({{for_next_step.bas}})
```

* Counting downward

```basic
include({{for_next_downto.bas}})
```

* Improper usage (revealing bug in Atari BASIC)

```basic
include({{for_next_downward.bas}})
```

```basic
include({{for_next_pi.bas}})
```

### `DO-LOOP`

### `REPEAT-UNTIL`

```basic
include({{repeat_until_1.bas}})
```

```basic
include({{repeat_until_2.bas}})
```

```basic
include({{repeat_until_3.bas}})
```

```basic
include({{repeat_until_pi.bas}})
```

### `WHILE-WEND`

