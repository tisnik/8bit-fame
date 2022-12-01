/* Created with BaCon 4.4.1 - (c) Peter van Eerten - MIT License */
#include "records.bac.h"
#include "records.bac.string.h"
#include "records.bac.float.h"
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
#line 1 "records.bac"
#line 2 "records.bac"
#line 3 "records.bac"
#line 4 "records.bac"
#line 5 "records.bac"
#line 6 "records.bac"
#line 7 "records.bac"
#line 9 "records.bac"
#line 10 "records.bac"
#line 11 "records.bac"
#line 12 "records.bac"
#line 13 "records.bac"

#line 15 "records.bac"
	users[(uint64_t) 0].id = (long) (0);
#line 16 "records.bac"
	users[(uint64_t) 0].name__b2c__string_var = __b2c_Swap_String (&users[(uint64_t) 0].name__b2c__string_var, "Linus");
#line 17 "records.bac"
	users[(uint64_t) 0].surname__b2c__string_var = __b2c_Swap_String (&users[(uint64_t) 0].surname__b2c__string_var, "Torvalds");
#line 19 "records.bac"
	users[(uint64_t) 1].id = (long) (1);
#line 20 "records.bac"
	users[(uint64_t) 1].name__b2c__string_var = __b2c_Swap_String (&users[(uint64_t) 1].name__b2c__string_var, "Ken");
#line 21 "records.bac"
	users[(uint64_t) 1].surname__b2c__string_var = __b2c_Swap_String (&users[(uint64_t) 1].surname__b2c__string_var, "Iverson");
#line 23 "records.bac"
	users[(uint64_t) 2].id = (long) (2);
#line 24 "records.bac"
	users[(uint64_t) 2].name__b2c__string_var = __b2c_Swap_String (&users[(uint64_t) 2].name__b2c__string_var, "Rob");
#line 25 "records.bac"
	users[(uint64_t) 2].surname__b2c__string_var = __b2c_Swap_String (&users[(uint64_t) 2].surname__b2c__string_var, "Pike");
#line 27 "records.bac"
	for (i = 0; i <= 2; i += 1)
	{
#line 28 "records.bac"
		fputs (STR__b2c__string_var (users[(uint64_t) i].id), stdout);
		__b2c__assign = (char *) " ";
		if (__b2c__assign != NULL)
		{
			fputs (__b2c__assign, stdout);
		}
		__b2c__assign = (char *) users[(uint64_t) i].name__b2c__string_var;
		if (__b2c__assign != NULL)
		{
			fputs (__b2c__assign, stdout);
		}
		__b2c__assign = (char *) " ";
		if (__b2c__assign != NULL)
		{
			fputs (__b2c__assign, stdout);
		}
		__b2c__assign = (char *) users[(uint64_t) i].surname__b2c__string_var;
		if (__b2c__assign != NULL)
		{
			fputs (__b2c__assign, stdout);
		}
		fputs ("\n", stdout);
#line 29 "records.bac"
	}
	return (0);
}
