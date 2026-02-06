
simd_B.wasm:	file format wasm 0x1

Code Disassembly:

000065 func[0] <neg_i8x16>:
 000066: 20 00                      | local.get 0
 000068: fd 61                      | i8x16.neg
 00006a: 0b                         | end
00006c func[1] <add_i8x16>:
 00006d: 20 01                      | local.get 1
 00006f: 20 00                      | local.get 0
 000071: fd 6e                      | i8x16.add
 000073: 0b                         | end
000075 func[2] <sub_i8x16>:
 000076: 20 00                      | local.get 0
 000078: 20 01                      | local.get 1
 00007a: fd 71                      | i8x16.sub
 00007c: 0b                         | end
00007e func[3] <neg_u8x16>:
 00007f: 20 00                      | local.get 0
 000081: fd 61                      | i8x16.neg
 000083: 0b                         | end
000085 func[4] <add_u8x16>:
 000086: 20 01                      | local.get 1
 000088: 20 00                      | local.get 0
 00008a: fd 6e                      | i8x16.add
 00008c: 0b                         | end
00008e func[5] <sub_u8x16>:
 00008f: 20 00                      | local.get 0
 000091: 20 01                      | local.get 1
 000093: fd 71                      | i8x16.sub
 000095: 0b                         | end
000097 func[6] <neg_i16x8>:
 000098: 20 00                      | local.get 0
 00009a: fd 81 01                   | i16x8.neg
 00009d: 0b                         | end
00009f func[7] <add_i16x8>:
 0000a0: 20 01                      | local.get 1
 0000a2: 20 00                      | local.get 0
 0000a4: fd 8e 01                   | i16x8.add
 0000a7: 0b                         | end
0000a9 func[8] <sub_i16x8>:
 0000aa: 20 00                      | local.get 0
 0000ac: 20 01                      | local.get 1
 0000ae: fd 91 01                   | i16x8.sub
 0000b1: 0b                         | end
0000b3 func[9] <neg_u16x8>:
 0000b4: 20 00                      | local.get 0
 0000b6: fd 81 01                   | i16x8.neg
 0000b9: 0b                         | end
0000bb func[10] <add_u16x8>:
 0000bc: 20 01                      | local.get 1
 0000be: 20 00                      | local.get 0
 0000c0: fd 8e 01                   | i16x8.add
 0000c3: 0b                         | end
0000c5 func[11] <sub_u16x8>:
 0000c6: 20 00                      | local.get 0
 0000c8: 20 01                      | local.get 1
 0000ca: fd 91 01                   | i16x8.sub
 0000cd: 0b                         | end
0000cf func[12] <neg_i32x4>:
 0000d0: 20 00                      | local.get 0
 0000d2: fd a1 01                   | i32x4.neg
 0000d5: 0b                         | end
0000d7 func[13] <add_i32x4>:
 0000d8: 20 01                      | local.get 1
 0000da: 20 00                      | local.get 0
 0000dc: fd ae 01                   | i32x4.add
 0000df: 0b                         | end
0000e1 func[14] <sub_i32x4>:
 0000e2: 20 00                      | local.get 0
 0000e4: 20 01                      | local.get 1
 0000e6: fd b1 01                   | i32x4.sub
 0000e9: 0b                         | end
0000eb func[15] <neg_u32x4>:
 0000ec: 20 00                      | local.get 0
 0000ee: fd a1 01                   | i32x4.neg
 0000f1: 0b                         | end
0000f3 func[16] <add_u32x4>:
 0000f4: 20 01                      | local.get 1
 0000f6: 20 00                      | local.get 0
 0000f8: fd ae 01                   | i32x4.add
 0000fb: 0b                         | end
0000fd func[17] <sub_u32x4>:
 0000fe: 20 00                      | local.get 0
 000100: 20 01                      | local.get 1
 000102: fd b1 01                   | i32x4.sub
 000105: 0b                         | end
000107 func[18] <neg_i64x2>:
 000108: 20 00                      | local.get 0
 00010a: fd c1 01                   | i64x2.neg
 00010d: 0b                         | end
00010f func[19] <add_i64x2>:
 000110: 20 01                      | local.get 1
 000112: 20 00                      | local.get 0
 000114: fd ce 01                   | i64x2.add
 000117: 0b                         | end
000119 func[20] <sub_i64x2>:
 00011a: 20 00                      | local.get 0
 00011c: 20 01                      | local.get 1
 00011e: fd d1 01                   | i64x2.sub
 000121: 0b                         | end
000123 func[21] <neg_u64x2>:
 000124: 20 00                      | local.get 0
 000126: fd c1 01                   | i64x2.neg
 000129: 0b                         | end
00012b func[22] <add_u64x2>:
 00012c: 20 01                      | local.get 1
 00012e: 20 00                      | local.get 0
 000130: fd ce 01                   | i64x2.add
 000133: 0b                         | end
000135 func[23] <sub_u64x2>:
 000136: 20 00                      | local.get 0
 000138: 20 01                      | local.get 1
 00013a: fd d1 01                   | i64x2.sub
 00013d: 0b                         | end
00013f func[24] <neg_f32x4>:
 000140: 20 00                      | local.get 0
 000142: fd e1 01                   | f32x4.neg
 000145: 0b                         | end
000147 func[25] <add_f32x4>:
 000148: 20 00                      | local.get 0
 00014a: 20 01                      | local.get 1
 00014c: fd e4 01                   | f32x4.add
 00014f: 0b                         | end
000151 func[26] <sub_f32x4>:
 000152: 20 00                      | local.get 0
 000154: 20 01                      | local.get 1
 000156: fd e5 01                   | f32x4.sub
 000159: 0b                         | end
00015b func[27] <neg_f64x2>:
 00015c: 20 00                      | local.get 0
 00015e: fd ed 01                   | f64x2.neg
 000161: 0b                         | end
000163 func[28] <add_f64x2>:
 000164: 20 00                      | local.get 0
 000166: 20 01                      | local.get 1
 000168: fd f0 01                   | f64x2.add
 00016b: 0b                         | end
00016d func[29] <sub_f64x2>:
 00016e: 20 00                      | local.get 0
 000170: 20 01                      | local.get 1
 000172: fd f1 01                   | f64x2.sub
 000175: 0b                         | end
