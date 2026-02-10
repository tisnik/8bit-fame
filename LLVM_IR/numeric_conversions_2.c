#include <stdint.h>

#define CONVERT(type1, type2)                                                  \
  type2 convert_##type1##_to_##type2(type1 x) { return (type2)x; }

CONVERT(int8_t, int8_t)
CONVERT(int8_t, int16_t)
CONVERT(int8_t, int32_t)
CONVERT(int8_t, int64_t)

CONVERT(int16_t, int8_t)
CONVERT(int16_t, int16_t)
CONVERT(int16_t, int32_t)
CONVERT(int16_t, int64_t)

CONVERT(int32_t, int8_t)
CONVERT(int32_t, int16_t)
CONVERT(int32_t, int32_t)
CONVERT(int32_t, int64_t)

CONVERT(int64_t, int8_t)
CONVERT(int64_t, int16_t)
CONVERT(int64_t, int32_t)
CONVERT(int64_t, int64_t)
