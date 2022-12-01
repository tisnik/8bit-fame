/* Created with BaCon 4.4.1 - (c) Peter van Eerten - MIT License */
#include "bubble_sort.bac.h"
#include "bubble_sort.bac.string.h"
#include "bubble_sort.bac.float.h"
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
#line 1 "bubble_sort.bac"
#line 2 "bubble_sort.bac"
#line 3 "bubble_sort.bac"
#line 4 "bubble_sort.bac"
#line 5 "bubble_sort.bac"
#line 6 "bubble_sort.bac"
#line 10 "bubble_sort.bac"
#line 12 "bubble_sort.bac"
	for (I = 0; I <= 20; I += 1)
	{
#line 13 "bubble_sort.bac"
		A[(uint64_t) I] = (long) (INT (RANDOM (100)));
#line 14 "bubble_sort.bac"
	}
#line 16 "bubble_sort.bac"
	__b2c__gosub_buffer_ptr++;
	if (__b2c__gosub_buffer_ptr >= 64)
	{
		ERROR = 31;
		if (!__b2c__catch_set)
			RUNTIMEERROR ("GOSUB", 16, "bubble_sort.bac", ERROR);
		else if (!setjmp (__b2c__jump))
			goto __B2C__PROGRAM__EXIT;
	}
	if (!setjmp (__b2c__gosub_buffer[__b2c__gosub_buffer_ptr]))
		goto PRINT_ARRAY;
	__b2c__gosub_buffer_ptr--;
	if (__b2c__gosub_buffer_ptr < -1)
		__b2c__gosub_buffer_ptr = -1;
#line 18 "bubble_sort.bac"
	for (I = 19; I >= 0; I += -1)
	{
#line 19 "bubble_sort.bac"
		__b2c__assign = (char *) ".";
		if (__b2c__assign != NULL)
		{
			fputs (__b2c__assign, stdout);
		}
		fflush (stdout);
#line 20 "bubble_sort.bac"
		for (J = 0; J <= I; J += 1)
		{
#line 21 "bubble_sort.bac"
			if ((A[(uint64_t) J]) > A[(uint64_t) J + 1])
			{
#line 22 "bubble_sort.bac"
				X = (long) (A[(uint64_t) J]);
#line 23 "bubble_sort.bac"
				A[(uint64_t) J] = (long) (A[(uint64_t) J + 1]);
#line 24 "bubble_sort.bac"
				A[(uint64_t) J + 1] = (long) (X);
#line 25 "bubble_sort.bac"
			}
#line 26 "bubble_sort.bac"
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
#line 27 "bubble_sort.bac"
	}
#line 29 "bubble_sort.bac"
	__b2c__assign = (char *) "";
	if (__b2c__assign != NULL)
	{
		fputs (__b2c__assign, stdout);
	}
	fputs ("\n", stdout);
#line 30 "bubble_sort.bac"
	__b2c__assign = (char *) "SORTED:";
	if (__b2c__assign != NULL)
	{
		fputs (__b2c__assign, stdout);
	}
	fputs ("\n", stdout);
#line 32 "bubble_sort.bac"
	__b2c__gosub_buffer_ptr++;
	if (__b2c__gosub_buffer_ptr >= 64)
	{
		ERROR = 31;
		if (!__b2c__catch_set)
			RUNTIMEERROR ("GOSUB", 32, "bubble_sort.bac", ERROR);
		else if (!setjmp (__b2c__jump))
			goto __B2C__PROGRAM__EXIT;
	}
	if (!setjmp (__b2c__gosub_buffer[__b2c__gosub_buffer_ptr]))
		goto PRINT_ARRAY;
	__b2c__gosub_buffer_ptr--;
	if (__b2c__gosub_buffer_ptr < -1)
		__b2c__gosub_buffer_ptr = -1;
#line 33 "bubble_sort.bac"
	exit (EXIT_SUCCESS);
#line 35 "bubble_sort.bac"
	PRINT_ARRAY:
	;
	__b2c__label_floatarray_PRINT_ARRAY = 0;
	__b2c__label_stringarray_PRINT_ARRAY = 0;
#line 36 "bubble_sort.bac"
#line 37 "bubble_sort.bac"
	for (I = 0; I <= 20; I += 1)
	{
#line 38 "bubble_sort.bac"
		fputs (STR__b2c__string_var (I), stdout);
		__b2c__assign = (char *) " ";
		if (__b2c__assign != NULL)
		{
			fputs (__b2c__assign, stdout);
		}
		fputs (STR__b2c__string_var (A[(uint64_t) I]), stdout);
		fputs ("\n", stdout);
#line 39 "bubble_sort.bac"
	}
#line 40 "bubble_sort.bac"
	if (__b2c__gosub_buffer_ptr >= 0)
		longjmp (__b2c__gosub_buffer[__b2c__gosub_buffer_ptr], 1);
	__B2C__PROGRAM__EXIT:
	return (0);
}
