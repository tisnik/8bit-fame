
conversions_2.wasm:	file format wasm 0x1

Code Disassembly:

00004b func[0] <char_from_int>:
 00004c: 20 00                      | local.get 0
 00004e: c0                         | i32.extend8_s
 00004f: 0b                         | end
000051 func[1] <short_from_int>:
 000052: 20 00                      | local.get 0
 000054: c1                         | i32.extend16_s
 000055: 0b                         | end
000057 func[2] <char_from_long>:
 000058: 20 00                      | local.get 0
 00005a: a7                         | i32.wrap_i64
 00005b: c0                         | i32.extend8_s
 00005c: 0b                         | end
00005e func[3] <short_from_long>:
 00005f: 20 00                      | local.get 0
 000061: a7                         | i32.wrap_i64
 000062: c1                         | i32.extend16_s
 000063: 0b                         | end
000065 func[4] <int_from_long>:
 000066: 20 00                      | local.get 0
 000068: a7                         | i32.wrap_i64
 000069: 0b                         | end
