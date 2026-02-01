#include <stdint.h>

#define ADD(type) type add_##type(type x, type y) {return x+y;}

ADD(int8_t)
ADD(int16_t)
ADD(int32_t)
ADD(int64_t)

ADD(uint8_t)
ADD(uint16_t)
ADD(uint32_t)
ADD(uint64_t)

ADD(float)
ADD(double)
