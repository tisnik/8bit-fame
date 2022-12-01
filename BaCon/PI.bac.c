/* Created with BaCon 4.4.1 - (c) Peter van Eerten - MIT License */
#include "PI.bac.h"
#include "PI.bac.string.h"
#include "PI.bac.float.h"
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
#line 1 "PI.bac"
#line 2 "PI.bac"
#line 3 "PI.bac"
#line 4 "PI.bac"
#line 5 "PI.bac"
#line 6 "PI.bac"
#line 8 "PI.bac"
#line 10 "PI.bac"
	for (I = 1; I <= 10; I += 1)
	{
#line 11 "PI.bac"
#line 12 "PI.bac"
		__b2c__gosub_buffer_ptr++;
		if (__b2c__gosub_buffer_ptr >= 64)
		{
			ERROR = 31;
			if (!__b2c__catch_set)
				RUNTIMEERROR ("GOSUB", 12, "PI.bac", ERROR);
			else if (!setjmp (__b2c__jump))
				goto __B2C__PROGRAM__EXIT;
		}
		if (!setjmp (__b2c__gosub_buffer[__b2c__gosub_buffer_ptr]))
			goto PI_COMP;
		__b2c__gosub_buffer_ptr--;
		if (__b2c__gosub_buffer_ptr < -1)
			__b2c__gosub_buffer_ptr = -1;
#line 13 "PI.bac"
		__b2c__assign = (char *) "I=";
		if (__b2c__assign != NULL)
		{
			fputs (__b2c__assign, stdout);
		}
		fputs (STR__b2c__string_var (I), stdout);
		__b2c__assign = (char *) " N=";
		if (__b2c__assign != NULL)
		{
			fputs (__b2c__assign, stdout);
		}
		fputs (STR__b2c__string_var (N), stdout);
		__b2c__assign = (char *) " PI=";
		if (__b2c__assign != NULL)
		{
			fputs (__b2c__assign, stdout);
		}
		fputs (STR__b2c__string_var (PI_VAL), stdout);
		fputs ("\n", stdout);
#line 14 "PI.bac"
		N = (long) (N * 2);
#line 15 "PI.bac"
	}
#line 16 "PI.bac"
#line 17 "PI.bac"
	exit (EXIT_SUCCESS);
#line 19 "PI.bac"
#line 20 "PI.bac"
#line 21 "PI.bac"
#line 23 "PI.bac"
	PI_COMP:
	;
	__b2c__label_floatarray_PI_COMP = 0;
	__b2c__label_stringarray_PI_COMP = 0;
#line 24 "PI.bac"
	PI_VAL = (double) (4.0);
#line 25 "PI.bac"
	for (J = 3; J <= N + 2; J += 2)
	{
#line 26 "PI.bac"
		PI_VAL = (double) (PI_VAL * (J - 1) / (double) J * (J + 1) / (double) J);
#line 27 "PI.bac"
	}
#line 28 "PI.bac"
	if (__b2c__gosub_buffer_ptr >= 0)
		longjmp (__b2c__gosub_buffer[__b2c__gosub_buffer_ptr], 1);
	__B2C__PROGRAM__EXIT:
	return (0);
}
