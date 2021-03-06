# Turbo-BASIC XL cheatsheet

changequote(`{{', `}}')

## Turbo-BASIC XL keywords

```
+----------+----------+---+----------------------------------------------------------------+
| Keyword  |  Type    |new| Description                                                    |
+----------+----------+---+----------------------------------------------------------------+
| BYE      | control  |no | switch to built-in Self Test program                           |
| CLOAD    | I/O      |no | loads tokenized program from cassette tape (see CSAVE, LOAD)   |
| CLOSE    | I/O      |no | closes a given I/O channel with flush (see OPEN, PUT, GET)     |
| CLR      | memory   |no | clears variables from memory and stack as well                 |
| COLOR    | graphics |no | select/chooses logical color value for drawing                 |
| CONT     | control  |no | continues program execution after STOP statement               |
| CSAVE    | I/O      |no | saves tokenized program into cassette tape (see CLOAD, SAVE)   |
| DATA     | memory   |no | used to store data as list of values (numeric, string)         |
| DEG      | control  |no | switches internal state to enable degrees for trig.functions   |
| DIM      | memory   |no | defines and allocates an array or matrix                       |
| DOS      | control  |no | switch to DOS (Disk Operating System) if available             |
| DRAWTO   | graphics |no | draws a line from current position (PLOT) to given coordinates |
| END      | control  |no | finishes execution of the program and closes open I/O channels |
| ENTER    | I/O      |no | loads and merges into memory a plain text program (in ATASCII) |
| FOR      | control  |no | beginning of a for loop (see TO, STEP, and NEXT)               |
| GET      | I/O      |no | reads one byte from a given I/O channel (see PUT)              |
| GOSUB    | control  |no | jumps to a subroutine, put current line number onto stack      |
| GOTO     | control  |no | jumps to given program line (can be stored in variable)        |
| GO TO    | control  |no | dtto                                                           |
| GRAPHICS | graphics |no | sets the specified graphics node, clear screen for modes < 16  |
| IF       | control  |no | evaluate the condition and executes next commands if true      |
| INPUT    | I/O      |no | read stream from specified I/O channel, converts to num/string |
| LET      | control  |no | assigns a value to a named variable. Fully optional on Atari.  |
| LIST     | I/O      |no | lists the program to screen, printer, or any other device      |
| LOAD     | I/O      |no | loads a tokenized program from specified device (see SAVE)     |
| LOCATE   | graphics |no | read color or character code from specified coordinates        |
| LPRINT   | I/O      |no | prints program source code onto a printer (see PRINT)          |
| NEW      | control  |no | erase program source code, erase all variables too             |
| NEXT     | control  |no | next iteration of a for loop for specified variable (see FOR)  |
| NOTE     | I/O      |no | returns the current position on a given I/O channel (see POINT)|
| ON       | control  |no | used together with GOTO statement to perform computed jump     |
| OPEN     | I/O      |no | initializes and open I/O channel (see CLOSE, PUT, GET)         |
| PLOT     | graphics |no | draws a point (pixel) at given coordinates (see DRAWTO)        |
| POINT    | I/O      |no | sets the current position on a given I/O channel (see NOTE)    |
| POKE     | memory   |no | writes one byte of data into memory location (see DPOKE, PEEK) |
| POP      | control  |no | removes return address from the stack (see GOSUB, RETURN)      |
| POSITION | graphics |no | sets the position of the graphics cursor (see PLOT, DRAWTO)    |
| PRINT    | I/O      |no | writes text to an I/O channel or onto screen if not specified  |
| PUT      | I/O      |no | writer one byte from a given I/O channel (see GET)             |
| RAD      | control  |no | switches internal state to enable radians for trig.functions   |
| READ     | memory   |no | reads data from DATA statement, increment internal DATA ptr.   |
| REM      | comment  |no | used to create a comment in a program (rest of line is ignored)|
| RESTORE  | memory   |no | sets the position where to read data from a DATA statement     |
| RETURN   | control  |no | ends a subroutine, return to statement following GOSUB         |
| RUN      | control  |no | starts execution of a program; can be started from device too  |
| SAVE     | I/O      |no | writes a tokenized program to device (see LOAD)                |
| SETCOLOR | graphics |no | maps a logical color to physical color: hue + level (see COLOR)|
| SOUND    | sound    |no | starts or stops playing a tone on a sound channel (see END)    |
| STATUS   | I/O      |no | returns the status of an I/O channel                           |
| STEP     | control  |no | increment of control variable in a FOR loop (see FOR, TO, NEXT)|
| STOP     | control  |no | stops the program, allowing later resumption (see CONT)        |
| THEN     | control  |no | statement to execute if condition is true in IF (see IF)       |
| TO       | control  |no | limiting condition in a FOR statement (see FOR, NEXT, STEP)    |
| TRAP     | control  |no | when error is encountered, jump to given source line (see GOTO)|
| XIO      | I/O      |no | call the general-purpose I/O routine identified by its number  |
+----------+----------+---+----------------------------------------------------------------+
| BLOAD    | I/O DOS  |yes| loads binary file (with machine instructions)                  |
| BRUN     | I/O DOS  |yes| loads and run binary file (with machine instructions)          |
| DELETE   | DOS      |yes| deletes (erases) file from disk                                |
| DIR      | DOS      |yes| lists files on disk (disk directory)                           |
| RENAME   | DOS      |yes| renames a file                                                 |
| LOCK     | DOS      |yes| lock a file so it can not be changed nor erased                |
| UNLOCK   | DOS      |yes| unlock a file, opposite of LOCK command                        |
| DPOKE    | memory   |yes| writes two bytes of data into two consecutive memory locations |
|          |          |   |                                                                |
+----------+----------+---+----------------------------------------------------------------+
```

## Operators

### List of Turbo-BASIC XL operators

```
+----------+------------+---+---------------------------------+
+ Operator | Type       |new| Description                     |
+----------+------------+---+---------------------------------+
| +        | arithmetic |no | addition                        |
| -        | arithmetic |no | subtraction                     |
| *        | arithmetic |no | multiplication                  |
| /        | arithmetic |no | division                        |
| ^        | arithmetic |no | exponentiation                  |
|          |            |   |                                 |
| AND      | logical    |no | logical conjunction             |
| OR       | logical    |no | logical disjunction             |
| NOT      | logical    |no | logical negation                |
+----------+------------+---+---------------------------------+
```

### Operator `+`

```basic
include({{operator_plus_1.bas}})
```

```basic
include({{operator_plus_2.bas}})
```

```basic
include({{operator_plus_3.bas}})
```

```basic
include({{operator_plus_err_1.bas}})
```


### Operator `-`

```basic
include({{operator_minus_1.bas}})
```

```basic
include({{operator_minus_2.bas}})
```

```basic
include({{operator_minus_3.bas}})
```

```basic
include({{operator_minus_err_1.bas}})
```



## Functions

### List of Turbo-BASIC XL functions

```
+----------+--------------+---+----------------------------------------------------------------+
+ Function | Type         |new| Description                                                    |
+----------+--------------+---+----------------------------------------------------------------+
| ABS      | arithmetic   |no | absolute value of a number                                     |
| ADR      | system       |no | address in memory of a string                                  |
| ASC      | conversion   |no | ATASCII value of character                                     |
| ATN      | goniometric  |no | arctangent of a number                                         |
| CLOG     | logarithmic  |no | common logarithm of a number                                   |
| CHR$     | string       |no | convert an ATASCII value to corresponding character (see VAL)  |
| COS      | goniometric  |no | cosine of a number                                             |
| EXP      | logarithmic  |no | exponential function                                           |
| FRE      | system       |no | amount of free memory in bytes                                 |
| INT      | arithmetic   |no | computes floor of a number                                     |
| LEN      | string       |no | returns the length of a string                                 |
| LOG      | logarithmic  |no | natural logarithm of a number                                  |
| PADDLE   | input device |no | position of a paddle controller                                |
| PEEK     | system       |no | returns the value at an address in memory (one byte)           |
| PTRIG    | input device |no | indicates whether a paddle trigger is pressed or not           |
| RND      | system       |no | a pseudorandom number                                          |
| SGN      | arithmetic   |no | signum of a number                                             |
| SIN      | goniometric  |no | sine of a number                                               |
| SQR      | arithmetic   |no | square root of a number                                        |
| STICK    | input device |no | a joystick position                                            |
| STRIG    | input device |no | indicates whether a joystick trigger is pressed or not         |
| STR$     | string       |no | converts a number to string form                               |
| USR      | system       |no | calls a machine code routine, optionally with parameters       |
| VAL      | string       |no | returns the numeric value of a string                          |
|          |              |   |                                                                |
| DPEEK    | memory       |yes| reads two bytes of data from two consecutive memory locations  |
+----------+--------------+---+----------------------------------------------------------------+
```

### `ABS`

Function `ABS` computes absolute value of a number. Both integers and floating
point numbers are supported by this function.

For negative numbers it returns the number distance from zero:

```basic
include({{function_abs_1.bas}})
```

For positive numbers, the original value is returned:

```basic
include({{function_abs_2.bas}})
```

As mentioned above, it is possible to call this function with floating point
number:

```basic
include({{function_abs_3.bas}})
```

For positive floating point numbers, the original value is returned:

```basic
include({{function_abs_4.bas}})
```

It is forbidden to pass string literal to this function:

```basic
include({{function_abs_err_1.bas}})
```

Interpreter will detect this issue and insert `ERROR` flag onto the line:

```basic
include({{function_abs_err_2.bas}})
```

It is also forbidden to pass string variable to this function:

```basic
include({{function_abs_err_3.bas}})
```

Again interpreter is able to detect such issue and insert `ERROR` flag onto the
appropriate line:

```basic
include({{function_abs_err_4.bas}})
```

Plot of `ABS` function can be displayed by the following example that uses
standard graphics mode 8:

```basic
include({{function_abs_plot.bas}})
```

Plot of `ABS` function with storing the image into BMP format:

The generated image converted into PNG:

![images/ABS.png](images/ABS.png)

---
**NOTE**

Image with the plotted function having resolution 320x192 pixels with 1 bit per
pixel is stored into the standard BMP format onto the file "H:ABS.BMP" (i.e. is
is useable in emulators).

---

```basic
include({{function_abs_plot_bmp.bas}})
```



### `ADR`

Function `ADR` returns address of a string stored in memory. Can be used to
store subroutines written in machine code and encoded into string.

In the following example, the memory is allocated for a string, string is
initialized and then its address is printed:

```basic
include({{function_adr_1.bas}})
```

Strings allocated in sequence are usually stored in consecutive memory blocks
as can be tested by this example:

```basic
include({{function_adr_2.bas}})
```

It is possible to get an address for in-place string literal (which make sense
for storing machine code, for example):

```basic
include({{function_adr_3.bas}})
```


### `ASC`

Function `ASC` returns ATASCII value of input character. Because Turbo-BASIC XL
does not distinguish between characters and strings, it is needed to pass
string parameter to this function. It means it is possible to pass a multi
character string or an empty string as well into `ASC`. These three
possibilities are shown in following examples.

Normal usage of `ASC` function is based on passing a string containing with
just one character. In this case, ATASCII value of such character is returned:

```basic
include({{function_asc_1.bas}})
```
It is also possible to call this function with longer string. In this case, the
ATASCII value of the first character from the string is returned:

```basic
include({{function_asc_2.bas}})
```

When empty string is passed, value 44 is returned (ATASCII value for comma):

```basic
include({{function_asc_3.bas}})
```

TODO: check why this happens.



### `ATN`

Function `ATN` computes arctangent of a given input number. It is possible to
select `DEG` mode for getting results in degress, or `RAD` mode for getting
results in radians.

`ATN` function computation for selected input values in `DEG` mode:

```basic
include({{function_atn_1.bas}})
```

`ATN` function computation for selected input values in `RAD` mode:

```basic
include({{function_atn_2.bas}})
```

Display of `ATN` function (simplest variant):

```basic
include({{function_atn_3.bas}})
```

Plot of `ATN` function can be displayed by the following example that uses
standard graphics mode 8, display axis etc.:

```basic
include({{function_atn_plot.bas}})
```

Plot of `ATN` function with storing the image into BMP format:

The generated image converted into PNG:

![images/ATN.png](images/ATN.png)

---
**NOTE**

Image with the plotted function having resolution 320x192 pixels with 1 bit per
pixel is stored into the standard BMP format onto the file "H:ABS.BMP" (i.e. is
is useable in emulators).

---

```basic
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

* Controlling FOR-NEXT loop behaviour by `*F -` option

```basic
include({{for_illegal_f_minus.bas}})
```

* Controlling FOR-NEXT loop behaviour by `*F +` option

```basic
include({{for_illegal_f_plus.bas}})
```

* Pi computation based on usage of nested FOR-NEXT loops:

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

