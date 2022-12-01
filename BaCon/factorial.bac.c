/* Created with BaCon 4.4.1 - (c) Peter van Eerten - MIT License */
#include "factorial.bac.h"
#include "factorial.bac.string.h"
#include "factorial.bac.float.h"
/****************************/
/* Main program starts here */
/****************************/
int main (int argc, char **argv)
{
	setvbuf (stdout, NULL, _IOLBF, 0);
	if (argc > 0)
	{
		__b2c__me_var__b2c__string_var = strdup (argv[0]);
	}
	if (argc == 2 && !strcmp (argv[1], "-bacon"))
	{
		fprintf (stderr, "Converted by %s.\n", COMPILED_BY_WHICH_BACON__b2c__string_var);
		exit (EXIT_SUCCESS);
	}
/* Setup the reserved variable 'ARGUMENT' */
	__b2c__argument (&ARGUMENT__b2c__string_var, argc, argv);
/* By default seed random generator */
	srandom ((unsigned int) time (NULL));
/* Determine current moment and keep it for timer function */
	__b2c__timer (1);
/* Setup error signal handling */
	signal (SIGILL, __b2c__catch_signal);
	signal (SIGABRT, __b2c__catch_signal);
	signal (SIGFPE, __b2c__catch_signal);
	signal (SIGSEGV, __b2c__catch_signal);
/* Rest of the program */
#line 1 "factorial.bac"
#line 2 "factorial.bac"
#line 3 "factorial.bac"
#line 4 "factorial.bac"
#line 5 "factorial.bac"
#line 6 "factorial.bac"
#line 7 "factorial.bac"
#line 9 "factorial.bac"
	for (N = 0; N <= 20; N += 1)
	{
#line 10 "factorial.bac"
		__b2c__gosub_buffer_ptr++;
		if (__b2c__gosub_buffer_ptr >= 64)
		{
			ERROR = 31;
			if (!__b2c__catch_set)
				RUNTIMEERROR ("GOSUB", 10, "factorial.bac", ERROR);
			else if (!setjmp (__b2c__jump))
				goto __B2C__PROGRAM__EXIT;
		}
		if (!setjmp (__b2c__gosub_buffer[__b2c__gosub_buffer_ptr]))
			goto FACTORIAL;
		__b2c__gosub_buffer_ptr--;
		if (__b2c__gosub_buffer_ptr < -1)
			__b2c__gosub_buffer_ptr = -1;
#line 11 "factorial.bac"
		fputs (STR__b2c__string_var (N), stdout);
		__b2c__assign = (char *) " ";
		if (__b2c__assign != NULL)
		{
			fputs (__b2c__assign, stdout);
		}
		fputs (STR__b2c__string_var (FACT), stdout);
		fputs ("\n", stdout);
#line 12 "factorial.bac"
	}
#line 13 "factorial.bac"
	exit (EXIT_SUCCESS);
#line 15 "factorial.bac"
#line 16 "factorial.bac"
	FACTORIAL:
	;
	__b2c__label_floatarray_FACTORIAL = 0;
	__b2c__label_stringarray_FACTORIAL = 0;
#line 17 "factorial.bac"
	FACT = (long) (1);
#line 18 "factorial.bac"
	for (I = N; I >= 1; I += -1)
	{
#line 19 "factorial.bac"
		FACT = (long) (FACT * I);
#line 20 "factorial.bac"
	}
#line 21 "factorial.bac"
	if (__b2c__gosub_buffer_ptr >= 0)
		longjmp (__b2c__gosub_buffer[__b2c__gosub_buffer_ptr], 1);
	__B2C__PROGRAM__EXIT:
	return (0);
}
