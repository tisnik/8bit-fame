/* Created with BaCon 4.4.1 - (c) Peter van Eerten - MIT License */
#include "macros.bac.h"
#include "macros.bac.string.h"
#include "macros.bac.float.h"
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
#line 1 "macros.bac"
#line 2 "macros.bac"
#line 3 "macros.bac"
#line 4 "macros.bac"
#line 5 "macros.bac"
#line 6 "macros.bac"
#line 7 "macros.bac"
#line 11 "macros.bac"
#line 13 "macros.bac"
	for (I = 0; I <= 20; I += 1)
	{
#line 14 "macros.bac"
		A[(uint64_t) I] = (long) (INT (RANDOM (100)));
#line 15 "macros.bac"
	}
#line 17 "macros.bac"
	__b2c__gosub_buffer_ptr++;
	if (__b2c__gosub_buffer_ptr >= 64)
	{
		ERROR = 31;
		if (!__b2c__catch_set)
			RUNTIMEERROR ("GOSUB", 17, "macros.bac", ERROR);
		else if (!setjmp (__b2c__jump))
			goto __B2C__PROGRAM__EXIT;
	}
	if (!setjmp (__b2c__gosub_buffer[__b2c__gosub_buffer_ptr]))
		goto PRINT_ARRAY;
	__b2c__gosub_buffer_ptr--;
	if (__b2c__gosub_buffer_ptr < -1)
		__b2c__gosub_buffer_ptr = -1;
#line 19 "macros.bac"
	for (I = 19; I >= 0; I += -1)
	{
#line 20 "macros.bac"
		__b2c__assign = (char *) ".";
		if (__b2c__assign != NULL)
		{
			fputs (__b2c__assign, stdout);
		}
		fflush (stdout);
#line 21 "macros.bac"
		for (J = 0; J <= I; J += 1)
		{
#line 22 "macros.bac"
			if ((A[(uint64_t) J]) > A[(uint64_t) J + 1])
			{
#line 23 "macros.bac"
				X = (long) (A[(uint64_t) J]);
#line 24 "macros.bac"
				A[(uint64_t) J] = (long) (A[(uint64_t) J + 1]);
#line 25 "macros.bac"
				A[(uint64_t) J + 1] = (long) (X);
#line 26 "macros.bac"
			}
#line 27 "macros.bac"
		}
		if (__b2c__break_ctr)
		{
			__b2c__break_ctr--;
			if (!__b2c__break_ctr)
			{
				if (__b2c__break_flag == 1)
					break;
				else
					continue;
			}
			else
				break;
		}
#line 28 "macros.bac"
	}
#line 30 "macros.bac"
	__b2c__assign = (char *) "";
	if (__b2c__assign != NULL)
	{
		fputs (__b2c__assign, stdout);
	}
	fputs ("\n", stdout);
#line 31 "macros.bac"
	__b2c__assign = (char *) "SORTED:";
	if (__b2c__assign != NULL)
	{
		fputs (__b2c__assign, stdout);
	}
	fputs ("\n", stdout);
#line 33 "macros.bac"
	__b2c__gosub_buffer_ptr++;
	if (__b2c__gosub_buffer_ptr >= 64)
	{
		ERROR = 31;
		if (!__b2c__catch_set)
			RUNTIMEERROR ("GOSUB", 33, "macros.bac", ERROR);
		else if (!setjmp (__b2c__jump))
			goto __B2C__PROGRAM__EXIT;
	}
	if (!setjmp (__b2c__gosub_buffer[__b2c__gosub_buffer_ptr]))
		goto PRINT_ARRAY;
	__b2c__gosub_buffer_ptr--;
	if (__b2c__gosub_buffer_ptr < -1)
		__b2c__gosub_buffer_ptr = -1;
#line 34 "macros.bac"
	exit (EXIT_SUCCESS);
#line 36 "macros.bac"
	PRINT_ARRAY:
	;
	__b2c__label_floatarray_PRINT_ARRAY = 0;
	__b2c__label_stringarray_PRINT_ARRAY = 0;
#line 37 "macros.bac"
#line 38 "macros.bac"
	for (I = 0; I <= 20; I += 1)
	{
#line 39 "macros.bac"
		fputs (STR__b2c__string_var (I), stdout);
		__b2c__assign = (char *) " ";
		if (__b2c__assign != NULL)
		{
			fputs (__b2c__assign, stdout);
		}
		fputs (STR__b2c__string_var (A[(uint64_t) I]), stdout);
		fputs ("\n", stdout);
#line 40 "macros.bac"
	}
#line 41 "macros.bac"
	if (__b2c__gosub_buffer_ptr >= 0)
		longjmp (__b2c__gosub_buffer[__b2c__gosub_buffer_ptr], 1);
	__B2C__PROGRAM__EXIT:
	return (0);
}
