#include <stdint.h>

#define CONVERT(type1, type2)                                                  \
  type2 convert_##type1##_to_##type2(type1 x) { return (type2)x; }

CONVERT(uint8_t, uint8_t)
CONVERT(uint8_t, uint16_t)
CONVERT(uint8_t, uint32_t)
CONVERT(uint8_t, uint64_t)

CONVERT(uint16_t, uint8_t)
CONVERT(uint16_t, uint16_t)
CONVERT(uint16_t, uint32_t)
CONVERT(uint16_t, uint64_t)

CONVERT(uint32_t, uint8_t)
CONVERT(uint32_t, uint16_t)
CONVERT(uint32_t, uint32_t)
CONVERT(uint32_t, uint64_t)

CONVERT(uint64_t, uint8_t)
CONVERT(uint64_t, uint16_t)
CONVERT(uint64_t, uint32_t)
CONVERT(uint64_t, uint64_t)
