
conversions_5.wasm:	file format wasm 0x1

Code Disassembly:

000058 func[0] <float_from_int>:
 000059: 20 00                      | local.get 0
 00005b: b2                         | f32.convert_i32_s
 00005c: 0b                         | end
00005e func[1] <double_from_int>:
 00005f: 20 00                      | local.get 0
 000061: b7                         | f64.convert_i32_s
 000062: 0b                         | end
000064 func[2] <float_from_long>:
 000065: 20 00                      | local.get 0
 000067: b4                         | f32.convert_i64_s
 000068: 0b                         | end
00006a func[3] <double_from_long>:
 00006b: 20 00                      | local.get 0
 00006d: b9                         | f64.convert_i64_s
 00006e: 0b                         | end
000070 func[4] <float_from_unsigned_int>:
 000071: 20 00                      | local.get 0
 000073: b3                         | f32.convert_i32_u
 000074: 0b                         | end
000076 func[5] <double_from_unsigned_int>:
 000077: 20 00                      | local.get 0
 000079: b8                         | f64.convert_i32_u
 00007a: 0b                         | end
00007c func[6] <float_from_unsigned_long>:
 00007d: 20 00                      | local.get 0
 00007f: b5                         | f32.convert_i64_u
 000080: 0b                         | end
000082 func[7] <double_from_unsigned_long>:
 000083: 20 00                      | local.get 0
 000085: ba                         | f64.convert_i64_u
 000086: 0b                         | end
