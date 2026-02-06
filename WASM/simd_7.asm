
simd_7.wasm:	file format wasm 0x1

Code Disassembly:

00004a func[0] <add_i8x16>:
 00004b: 20 01                      | local.get 1
 00004d: 20 00                      | local.get 0
 00004f: fd 6e                      | i8x16.add
 000051: 0b                         | end
000053 func[1] <add_u8x16>:
 000054: 20 01                      | local.get 1
 000056: 20 00                      | local.get 0
 000058: fd 6e                      | i8x16.add
 00005a: 0b                         | end
00005c func[2] <add_i16x8>:
 00005d: 20 01                      | local.get 1
 00005f: 20 00                      | local.get 0
 000061: fd 8e 01                   | i16x8.add
 000064: 0b                         | end
000066 func[3] <add_u16x8>:
 000067: 20 01                      | local.get 1
 000069: 20 00                      | local.get 0
 00006b: fd 8e 01                   | i16x8.add
 00006e: 0b                         | end
000070 func[4] <add_i32x4>:
 000071: 20 01                      | local.get 1
 000073: 20 00                      | local.get 0
 000075: fd ae 01                   | i32x4.add
 000078: 0b                         | end
00007a func[5] <add_u32x4>:
 00007b: 20 01                      | local.get 1
 00007d: 20 00                      | local.get 0
 00007f: fd ae 01                   | i32x4.add
 000082: 0b                         | end
000084 func[6] <add_i64x2>:
 000085: 20 01                      | local.get 1
 000087: 20 00                      | local.get 0
 000089: fd ae 01                   | i32x4.add
 00008c: 0b                         | end
00008e func[7] <add_u64x2>:
 00008f: 20 01                      | local.get 1
 000091: 20 00                      | local.get 0
 000093: fd ae 01                   | i32x4.add
 000096: 0b                         | end
