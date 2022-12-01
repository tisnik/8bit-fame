/* Created with BaCon 4.4.1 - (c) Peter van Eerten - MIT License */
#include "record.bac.h"
#include "record.bac.string.h"
#include "record.bac.float.h"
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
#line 1 "record.bac"
#line 2 "record.bac"
#line 3 "record.bac"
#line 4 "record.bac"
#line 5 "record.bac"
#line 6 "record.bac"
#line 7 "record.bac"
#line 9 "record.bac"
#line 10 "record.bac"
#line 11 "record.bac"
#line 12 "record.bac"
#line 13 "record.bac"
	user.name__b2c__string_var = NULL;
	user.surname__b2c__string_var = NULL;
#line 15 "record.bac"
	user.id = (long) (42);
#line 16 "record.bac"
	user.name__b2c__string_var = __b2c_Swap_String (&user.name__b2c__string_var, "Linus");
#line 17 "record.bac"
	user.surname__b2c__string_var = __b2c_Swap_String (&user.surname__b2c__string_var, "Torvalds");
#line 19 "record.bac"
	fputs (STR__b2c__string_var (user.id), stdout);
	__b2c__assign = (char *) " ";
	if (__b2c__assign != NULL)
	{
		fputs (__b2c__assign, stdout);
	}
	__b2c__assign = (char *) user.name__b2c__string_var;
	if (__b2c__assign != NULL)
	{
		fputs (__b2c__assign, stdout);
	}
	__b2c__assign = (char *) " ";
	if (__b2c__assign != NULL)
	{
		fputs (__b2c__assign, stdout);
	}
	__b2c__assign = (char *) user.surname__b2c__string_var;
	if (__b2c__assign != NULL)
	{
		fputs (__b2c__assign, stdout);
	}
	fputs ("\n", stdout);
	return (0);
}
