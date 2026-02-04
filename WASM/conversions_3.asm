
conversions_3.wasm:	file format wasm 0x1

Code Disassembly:

00004b func[0] <char_from_int>:
 00004c: 20 00                      | local.get 0
 00004e: 41 ff 01                   | i32.const 255
 000051: 71                         | i32.and
 000052: 0b                         | end
000054 func[1] <short_from_int>:
 000055: 20 00                      | local.get 0
 000057: 41 ff ff 03                | i32.const 65535
 00005b: 71                         | i32.and
 00005c: 0b                         | end
00005e func[2] <char_from_long>:
 00005f: 20 00                      | local.get 0
 000061: a7                         | i32.wrap_i64
 000062: 41 ff 01                   | i32.const 255
 000065: 71                         | i32.and
 000066: 0b                         | end
000068 func[3] <short_from_long>:
 000069: 20 00                      | local.get 0
 00006b: a7                         | i32.wrap_i64
 00006c: 41 ff ff 03                | i32.const 65535
 000070: 71                         | i32.and
 000071: 0b                         | end
000073 func[4] <int_from_long>:
 000074: 20 00                      | local.get 0
 000076: a7                         | i32.wrap_i64
 000077: 0b                         | end
