/* Created with BaCon 4.4.1 - (c) Peter van Eerten - MIT License */
#include "GCD.bac.h"
#include "GCD.bac.string.h"
#include "GCD.bac.float.h"
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
#line 1 "GCD.bac"
#line 2 "GCD.bac"
#line 3 "GCD.bac"
#line 4 "GCD.bac"
#line 5 "GCD.bac"
#line 6 "GCD.bac"
#line 7 "GCD.bac"
#line 8 "GCD.bac"
#line 10 "GCD.bac"
	__b2c__assign = (char *) "X=";
	if (__b2c__assign != NULL)
	{
		fputs (__b2c__assign, stdout);
	}
	fflush (stdout);
#line 11 "GCD.bac"
	__b2c__input (&__b2c__assign, "\n");
	X = atol (__b2c__assign);
	free (__b2c__assign);
	__b2c__assign = NULL;
#line 12 "GCD.bac"
	__b2c__assign = (char *) "Y=";
	if (__b2c__assign != NULL)
	{
		fputs (__b2c__assign, stdout);
	}
	fflush (stdout);
#line 13 "GCD.bac"
	__b2c__input (&__b2c__assign, "\n");
	Y = atol (__b2c__assign);
	free (__b2c__assign);
	__b2c__assign = NULL;
#line 15 "GCD.bac"
	LOOP:
	;
	__b2c__label_floatarray_LOOP = 0;
	__b2c__label_stringarray_LOOP = 0;
#line 17 "GCD.bac"
	if ((X) == Y)
	{
#line 18 "GCD.bac"
		__b2c__assign = (char *) "GCD: ";
		if (__b2c__assign != NULL)
		{
			fputs (__b2c__assign, stdout);
		}
		fputs (STR__b2c__string_var (X), stdout);
		fputs ("\n", stdout);
#line 19 "GCD.bac"
		kill (getpid (), SIGSTOP);
#line 20 "GCD.bac"
	}
#line 22 "GCD.bac"
	if ((X) > Y)
	{
#line 23 "GCD.bac"
		X = (long) (X - Y);
#line 24 "GCD.bac"
		goto LOOP;
#line 25 "GCD.bac"
	}
#line 27 "GCD.bac"
	if ((X) < Y)
	{
#line 28 "GCD.bac"
		Y = (long) (Y - X);
#line 29 "GCD.bac"
		goto LOOP;
#line 30 "GCD.bac"
	}
	return (0);
}
