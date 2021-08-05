# Turbo-BASIC XL cheatsheet



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
|          |          |   |                                                                |
|          |          |   |                                                                |
|          |          |   |                                                                |
|          |          |   |                                                                |
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

For positive floating point numbers, the original value is returned:

```basic
1 ------------------------------
2 REM ABS function computation
3 REM for positive float value
4 ------------------------------
10 PRINT ABS(3.14)
999 STOP 

```

It is forbidden to pass string literal to this function:

```basic
1 ------------------------------
2 REM ABS function computation
3 REM for string literal.
4 ------------------------------
10 PRINT ABS("FOO")
999 STOP 

```

Interpreter will detect this issue and insert `ERROR` flag onto the line:

```basic
1 ------------------------------
2 REM ABS function computation
3 REM for string literal.
4 REM Interpreter error detection.
5 ------------------------------
10 ERROR-   PRINT ABS("FOO"<
999 STOP 

```

It is also forbidden to pass string variable to this function:

```basic
1 ------------------------------
2 REM ABS function computation
3 REM for string variable.
4 ------------------------------
10 DIM A$(10)
11 A$="FOO"
20 PRINT ABS(A$)
999 STOP 

```

Again interpreter is able to detect such issue and insert `ERROR` flag onto the
appropriate line:

```basic
1 ------------------------------
2 REM ABS function computation
3 REM for string variable.
4 REM Interpreter error detection.
5 ------------------------------
10 DIM A$(10)
11 A$="FOO"
20 ERROR-   PRINT ABS(A$<
999 STOP 

```

Plot of `ABS` function can be displayed by the following example that uses
standard graphics mode 8:

```basic
1 ------------------------------
2 REM ABS function plot (graph)
3 REM in graphics mode 8
4 ------------------------------
10 EXEC SET_GRAPHICS
20 EXEC DRAW_AXIS
40 REM PLOT FUNCTION
50 FOR X=0 TO 319
60   Y=79-ABS(X-160)
70   IF Y<0 OR Y>159 THEN GOTO 90
80   PLOT X,Y
90 NEXT X
999 STOP 
1000 ------------------------------
1010 REM SET GRAPHICS MODE
1020 ------------------------------
1030 PROC SET_GRAPHICS
1040   GRAPHICS 8
1050   COLOR 1
1060 ENDPROC 
2000 ------------------------------
2010 REM DRAW AXIS
2020 ------------------------------
2030 PROC DRAW_AXIS
2040   PLOT 160,0:DRAWTO 160,159
2050   PLOT 0,80:DRAWTO 319,80
2060   TEXT 0,82,"-160"
2070   TEXT 290,82,"160"
2080   TEXT 162,0,"80"
2090   TEXT 162,150,"-80"
2100   TEXT 162,82,"0,0"
2200 ENDPROC 
2300 ------------------------------

```


### `ADR`

Function `ADR` returns address of a string stored in memory. Can be used to
store subroutines written in machine code and encoded into string.

In the following example, the memory is allocated for a string, string is
initialized and then its address is printed:

```basic
1 ------------------------------
2 REM ADR function computation
3 REM for pre-allocated string
4 ------------------------------
10 DIM A$(10)
20 A$="FOO"
30 PRINT ADR(A$)
999 STOP 

```

Strings allocated in sequence are usually stored in consecutive memory blocks
as can be tested by this example:

```basic
1 ------------------------------
2 REM ADR function computation
3 REM for pre-allocated strings
4 ------------------------------
10 DIM A$(10),B$(10),C$(10)
20 PRINT ADR(A$)
30 PRINT ADR(B$)
40 PRINT ADR(C$)
999 STOP 

```

It is possible to get an address for in-place string literal (which make sense
for storing machine code, for example):

```basic
1 ------------------------------
2 REM ADR function computation
3 REM for string literals
4 ------------------------------
10 PRINT ADR("FOO")
20 PRINT ADR("BAR")
30 PRINT ADR("BAZ")
999 STOP 

```


### `ASC`

```basic
1 ------------------------------
2 REM ASC function computation
3 REM for string literal with
4 REM one character
5 ------------------------------
10 PRINT ASC("A")
999 STOP 

```

```basic
1 ------------------------------
2 REM ASC function computation
3 REM for string literal with
4 REM multiple characters
5 ------------------------------
10 PRINT ASC("ABC")
999 STOP 

```

```basic
1 ------------------------------
2 REM ASC function computation
3 REM for emptry string literal
4 ------------------------------
10 PRINT ASC("")
999 STOP 

```

### `ATN`

```basic
1 ------------------------------
2 REM ATN function computation
3 REM for selected input values
4 REM in DEG mode
5 ------------------------------
10 DEG 
20 RESTORE 100
30 FOR I=1 TO 7
40   READ X
50   PRINT X,ATN(X)
60 NEXT I
100 DATA -1E20, -1, -0.5
110 DATA 0
120 DATA 0.5, 1, 1E20
999 STOP 

```

```basic
1 ------------------------------
2 REM ATN function computation
3 REM for selected input values
4 REM in RAD mode
5 ------------------------------
10 RAD 
20 RESTORE 100
30 FOR I=1 TO 7
40   READ X
50   PRINT X,ATN(X)
60 NEXT I
100 DATA -1E20, -1, -0.5
110 DATA 0
120 DATA 0.5, 1, 1E20
999 STOP 

```

```basic
1 ------------------------------
2 REM ATN function plot
4 REM in DEG mode
5 ------------------------------
10 DEG 
20 GRAPHICS 8
30 COLOR 1
40 PLOT 160,0:DRAWTO 160,159
50 PLOT 0,80:DRAWTO 319,80
60 FOR X=0 TO 319
70   Y=79-0.8*ATN((X-160)/2)
80   PLOT X,Y
90 NEXT X
999 STOP 

```

### `CHR$`

```basic
1 ------------------------------
2 REM CHR$ function computation
3 REM for selected integer input
4 REM value
5 ------------------------------
10 PRINT CHR$(42)
999 STOP

```

```basic
1 ------------------------------
2 REM CHR$ function computation
3 REM for selected integer input
4 REM value which is larger than
5 REM 255
6 ------------------------------
10 PRINT CHR$(1234)
999 STOP

```

```basic
1 ------------------------------
2 REM CHR$ function computation
3 REM for selected floating
4 REM input value
5 ------------------------------
10 PRINT CHR$(42.3)
999 STOP

```

### `COS`


```basic
10 DEG 
20 PRINT COS(0)
30 PRINT COS(30)
40 PRINT COS(45)
50 PRINT COS(60)
60 PRINT COS(90)
999 STOP

```

```basic
1 ------------------------------
2 REM COS function computation
3 REM for selected input values
4 REM in RAD mode
5 ------------------------------
10 RAD 
20 PRINT COS(0)
30 PRINT COS(30)
40 PRINT COS(45)
50 PRINT COS(60)
60 PRINT COS(90)
999 STOP

```

```basic
1 ------------------------------
2 REM COS function plot for DEG
3 REM mode (positive X values)
4 ------------------------------
10 DEG 
20 GRAPHICS 8
30 COLOR 1
40 PLOT 0,0:DRAWTO 0,159
50 PLOT 0,80:DRAWTO 319,80
60 FOR X=0 TO 319
70   Y=79-60*COS(X*360/320)
80   PLOT X,Y
90 NEXT X
999 STOP 

```

### `FRE`


```basic
1 ------------------------------
2 REM FRE function with formal
3 REM parameter set to zero
4 REM value (as usual)
5 ------------------------------
10 PRINT FRE(0)
999 STOP

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

