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
+          |            |   |                                 |
+----------+------------+---+---------------------------------+
```

## Functions

### List of Turbo-BASIC XL functions

```
+----------+------------+---+---------------------------------+
+ Function | Type       |new| Description                     |
+----------+------------+---+---------------------------------+
+ ABS      | arithmetic |no | absolute value of a number      |
+ ADR      | address    |no | address in memory of a varialbe |
+          |            |no |                                 |
+          |            |   |                                 |
+          |            |   |                                 |
+          |            |   |                                 |
+          |            |   |                                 |
+          |            |   |                                 |
+----------+------------+---+---------------------------------+
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

