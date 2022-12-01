/* Created with BaCon 4.4.1 - (c) Peter van Eerten - MIT License */
#include "assoc_array_string.bac.h"
#include "assoc_array_string.bac.string.h"
#include "assoc_array_string.bac.float.h"
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
#line 1 "assoc_array_string.bac"
	__b2c__assoc_map__b2c__string_var = __b2c__hash_new ();
#line 3 "assoc_array_string.bac"
	__b2c__hash_add_str (__b2c__assoc_map__b2c__string_var, "FOO", "foo");
#line 4 "assoc_array_string.bac"
	__b2c__hash_add_str (__b2c__assoc_map__b2c__string_var, "BAR", "bar");
#line 5 "assoc_array_string.bac"
	__b2c__hash_add_str (__b2c__assoc_map__b2c__string_var, "", "baz");
#line 7 "assoc_array_string.bac"
	__b2c__assign = (char *) map__b2c__string_var ("foo");
	if (__b2c__assign != NULL)
	{
		fputs (__b2c__assign, stdout);
	}
	fputs ("\n", stdout);
#line 8 "assoc_array_string.bac"
	__b2c__assign = (char *) map__b2c__string_var ("bar");
	if (__b2c__assign != NULL)
	{
		fputs (__b2c__assign, stdout);
	}
	fputs ("\n", stdout);
#line 9 "assoc_array_string.bac"
	__b2c__assign = (char *) map__b2c__string_var ("baz");
	if (__b2c__assign != NULL)
	{
		fputs (__b2c__assign, stdout);
	}
	fputs ("\n", stdout);
#line 10 "assoc_array_string.bac"
	__b2c__assign = (char *) map__b2c__string_var ("xyzzy");
	if (__b2c__assign != NULL)
	{
		fputs (__b2c__assign, stdout);
	}
	fputs ("\n", stdout);
	return (0);
}
