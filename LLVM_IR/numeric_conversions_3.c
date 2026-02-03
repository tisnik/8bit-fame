#include <stdint.h>

#define CONVERT(type1, type2) type2 convert_##type1##_to_##type2(type1 x) {return (type2)x;}

CONVERT(float, float)
CONVERT(float, double)
CONVERT(double, float)
CONVERT(double, double)

CONVERT(int32_t, float)
CONVERT(int32_t, double)
CONVERT(int64_t, float)
CONVERT(int64_t, double)

CONVERT(float, int32_t)
CONVERT(double, int32_t)
CONVERT(float, int64_t)
CONVERT(double, int64_t)
