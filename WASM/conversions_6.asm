
conversions_6.wasm:	file format wasm 0x1

Code Disassembly:

000054 func[0] <int_from_float>:
 000055: 02 40                      | block
 000057: 20 00                      |   local.get 0
 000059: 8b                         |   f32.abs
 00005a: 43 00 00 00 4f             |   f32.const 0x1p+31
 00005f: 5d                         |   f32.lt
 000060: 45                         |   i32.eqz
 000061: 0d 00                      |   br_if 0
 000063: 20 00                      |   local.get 0
 000065: a8                         |   i32.trunc_f32_s
 000066: 0f                         |   return
 000067: 0b                         | end
 000068: 41 80 80 80 80 78          | i32.const 2147483648
 00006e: 0b                         | end
000070 func[1] <long_from_float>:
 000071: 02 40                      | block
 000073: 20 00                      |   local.get 0
 000075: 8b                         |   f32.abs
 000076: 43 00 00 00 5f             |   f32.const 0x1p+63
 00007b: 5d                         |   f32.lt
 00007c: 45                         |   i32.eqz
 00007d: 0d 00                      |   br_if 0
 00007f: 20 00                      |   local.get 0
 000081: ae                         |   i64.trunc_f32_s
 000082: 0f                         |   return
 000083: 0b                         | end
 000084: 42 80 80 80 80 80 80 80 80 | i64.const -9223372036854775808
 00008d: 80 7f                      | 
 00008f: 0b                         | end
000091 func[2] <int_from_double>:
 000092: 02 40                      | block
 000094: 20 00                      |   local.get 0
 000096: 99                         |   f64.abs
 000097: 44 00 00 00 00 00 00 e0 41 |   f64.const 0x1p+31
 0000a0: 63                         |   f64.lt
 0000a1: 45                         |   i32.eqz
 0000a2: 0d 00                      |   br_if 0
 0000a4: 20 00                      |   local.get 0
 0000a6: aa                         |   i32.trunc_f64_s
 0000a7: 0f                         |   return
 0000a8: 0b                         | end
 0000a9: 41 80 80 80 80 78          | i32.const 2147483648
 0000af: 0b                         | end
0000b1 func[3] <long_from_double>:
 0000b2: 02 40                      | block
 0000b4: 20 00                      |   local.get 0
 0000b6: 99                         |   f64.abs
 0000b7: 44 00 00 00 00 00 00 e0 43 |   f64.const 0x1p+63
 0000c0: 63                         |   f64.lt
 0000c1: 45                         |   i32.eqz
 0000c2: 0d 00                      |   br_if 0
 0000c4: 20 00                      |   local.get 0
 0000c6: b0                         |   i64.trunc_f64_s
 0000c7: 0f                         |   return
 0000c8: 0b                         | end
 0000c9: 42 80 80 80 80 80 80 80 80 | i64.const -9223372036854775808
 0000d2: 80 7f                      | 
 0000d4: 0b                         | end
