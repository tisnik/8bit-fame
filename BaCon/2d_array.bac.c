/* Created with BaCon 4.4.1 - (c) Peter van Eerten - MIT License */
#include "2d_array.bac.h"
#include "2d_array.bac.string.h"
#include "2d_array.bac.float.h"
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
#line 1 "2d_array.bac"
#line 2 "2d_array.bac"
#line 3 "2d_array.bac"
#line 4 "2d_array.bac"
#line 5 "2d_array.bac"
#line 6 "2d_array.bac"
#line 7 "2d_array.bac"
#line 9 "2d_array.bac"
#line 11 "2d_array.bac"
	for (I = 0; I <= 5; I += 1)
	{
#line 12 "2d_array.bac"
		for (J = 0; J <= 5; J += 1)
		{
#line 13 "2d_array.bac"
			M[(uint64_t) I][(uint64_t) J] = (long) (I * J);
#line 14 "2d_array.bac"
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
#line 15 "2d_array.bac"
	}
#line 17 "2d_array.bac"
#line 18 "2d_array.bac"
	for (I = 0; I <= 5; I += 1)
	{
#line 19 "2d_array.bac"
		for (J = 0; J <= 5; J += 1)
		{
#line 20 "2d_array.bac"
			fputs (STR__b2c__string_var (M[(uint64_t) I][(uint64_t) J]), stdout);
			__b2c__assign = (char *) " ";
			if (__b2c__assign != NULL)
			{
				fputs (__b2c__assign, stdout);
			}
			fflush (stdout);
#line 21 "2d_array.bac"
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
#line 22 "2d_array.bac"
		fputs ("\n", stdout);
#line 23 "2d_array.bac"
	}
	return (0);
}
