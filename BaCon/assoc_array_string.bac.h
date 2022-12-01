/* Created with BaCon 4.4.1 - (c) Peter van Eerten - MIT License */
#include "assoc_array_string.bac.generic.h"
#include "assoc_array_string.bac.functions.h"
#line 1 "assoc_array_string.bac"
STRING __b2c__assoc_map__b2c__string_var_eval;
__b2c__htable *__b2c__assoc_map__b2c__string_var, *__b2c__assoc_map__b2c__string_var_orig;
STRING __b2c__assoc_map__b2c__string_var_func (const char *key)
{
	void *result;

	result = __b2c__hash_find_value (__b2c__assoc_map__b2c__string_var, key);
	if (result == NULL)
	{
		return (EmptyString);
	}
	return ((STRING) result);
}

#define map__b2c__string_var(...) __b2c__assoc_map__b2c__string_var_func(__b2c__KEYCOLLECT(__VA_ARGS__))
#line 3 "assoc_array_string.bac"
#line 4 "assoc_array_string.bac"
#line 5 "assoc_array_string.bac"
#line 7 "assoc_array_string.bac"
#line 8 "assoc_array_string.bac"
#line 9 "assoc_array_string.bac"
#line 10 "assoc_array_string.bac"
