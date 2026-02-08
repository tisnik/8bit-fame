
conversions_7.wasm:	file format wasm 0x1

Code Disassembly:

000054 func[0] <unsigned_int_from_float>:
 000055: 02 40                      | block
 000057: 20 00                      |   local.get 0
 000059: 43 00 00 80 4f             |   f32.const 0x1p+32
 00005e: 5d                         |   f32.lt
 00005f: 20 00                      |   local.get 0
 000061: 43 00 00 00 00             |   f32.const 0x0p+0
 000066: 60                         |   f32.ge
 000067: 71                         |   i32.and
 000068: 45                         |   i32.eqz
 000069: 0d 00                      |   br_if 0
 00006b: 20 00                      |   local.get 0
 00006d: a9                         |   i32.trunc_f32_u
 00006e: 0f                         |   return
 00006f: 0b                         | end
 000070: 41 00                      | i32.const 0
 000072: 0b                         | end
000074 func[1] <unsigned_long_from_float>:
 000075: 02 40                      | block
 000077: 20 00                      |   local.get 0
 000079: 43 00 00 80 5f             |   f32.const 0x1p+64
 00007e: 5d                         |   f32.lt
 00007f: 20 00                      |   local.get 0
 000081: 43 00 00 00 00             |   f32.const 0x0p+0
 000086: 60                         |   f32.ge
 000087: 71                         |   i32.and
 000088: 45                         |   i32.eqz
 000089: 0d 00                      |   br_if 0
 00008b: 20 00                      |   local.get 0
 00008d: af                         |   i64.trunc_f32_u
 00008e: 0f                         |   return
 00008f: 0b                         | end
 000090: 42 00                      | i64.const 0
 000092: 0b                         | end
000094 func[2] <unsigned_int_from_double>:
 000095: 02 40                      | block
 000097: 20 00                      |   local.get 0
 000099: 44 00 00 00 00 00 00 f0 41 |   f64.const 0x1p+32
 0000a2: 63                         |   f64.lt
 0000a3: 20 00                      |   local.get 0
 0000a5: 44 00 00 00 00 00 00 00 00 |   f64.const 0x0p+0
 0000ae: 66                         |   f64.ge
 0000af: 71                         |   i32.and
 0000b0: 45                         |   i32.eqz
 0000b1: 0d 00                      |   br_if 0
 0000b3: 20 00                      |   local.get 0
 0000b5: ab                         |   i32.trunc_f64_u
 0000b6: 0f                         |   return
 0000b7: 0b                         | end
 0000b8: 41 00                      | i32.const 0
 0000ba: 0b                         | end
0000bc func[3] <unsigned_long_from_double>:
 0000bd: 02 40                      | block
 0000bf: 20 00                      |   local.get 0
 0000c1: 44 00 00 00 00 00 00 f0 43 |   f64.const 0x1p+64
 0000ca: 63                         |   f64.lt
 0000cb: 20 00                      |   local.get 0
 0000cd: 44 00 00 00 00 00 00 00 00 |   f64.const 0x0p+0
 0000d6: 66                         |   f64.ge
 0000d7: 71                         |   i32.and
 0000d8: 45                         |   i32.eqz
 0000d9: 0d 00                      |   br_if 0
 0000db: 20 00                      |   local.get 0
 0000dd: b1                         |   i64.trunc_f64_u
 0000de: 0f                         |   return
 0000df: 0b                         | end
 0000e0: 42 00                      | i64.const 0
 0000e2: 0b                         | end
