/* Created with BaCon 4.4.1 - (c) Peter van Eerten - MIT License */
#include "1d_array.bac.h"
#include "1d_array.bac.string.h"
#include "1d_array.bac.float.h"
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
#line 1 "1d_array.bac"
#line 2 "1d_array.bac"
#line 3 "1d_array.bac"
#line 4 "1d_array.bac"
#line 5 "1d_array.bac"
#line 6 "1d_array.bac"
#line 7 "1d_array.bac"
#line 9 "1d_array.bac"
#line 11 "1d_array.bac"
	for (I = 0; I <= 10; I += 1)
	{
#line 12 "1d_array.bac"
		A[(uint64_t) I] = (long) (10 * I);
#line 13 "1d_array.bac"
	}
#line 15 "1d_array.bac"
#line 16 "1d_array.bac"
	for (I = 0; I <= 10; I += 1)
	{
#line 17 "1d_array.bac"
		fputs (STR__b2c__string_var (A[(uint64_t) I]), stdout);
		fputs ("\n", stdout);
#line 18 "1d_array.bac"
	}
	return (0);
}
