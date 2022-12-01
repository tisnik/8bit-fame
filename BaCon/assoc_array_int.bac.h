/* Created with BaCon 4.4.1 - (c) Peter van Eerten - MIT License */
#include "assoc_array_int.bac.generic.h"
#include "assoc_array_int.bac.functions.h"
#line 1 "assoc_array_int.bac"
int __b2c__assoc_map_eval;
__b2c__htable *__b2c__assoc_map, *__b2c__assoc_map_orig;
int __b2c__assoc_map_func (const char *key)
{
	void *result;

	result = __b2c__hash_find_value (__b2c__assoc_map, key);
	if (result == NULL)
	{
		return (0);
	}
	return (*(int *) result);
}

#define map(...) __b2c__assoc_map_func(__b2c__KEYCOLLECT(__VA_ARGS__))
#line 3 "assoc_array_int.bac"
#line 4 "assoc_array_int.bac"
#line 5 "assoc_array_int.bac"
#line 7 "assoc_array_int.bac"
#line 8 "assoc_array_int.bac"
#line 9 "assoc_array_int.bac"
#line 10 "assoc_array_int.bac"
