
simd_C.wasm:	file format wasm 0x1

Code Disassembly:

00004d func[0] <mul_i8x16>:
 00004e: 20 01                      | local.get 1
 000050: fd 16 00                   | i8x16.extract_lane_u 0
 000053: 20 00                      | local.get 0
 000055: fd 16 00                   | i8x16.extract_lane_u 0
 000058: 6c                         | i32.mul
 000059: fd 0f                      | i8x16.splat
 00005b: 20 01                      | local.get 1
 00005d: fd 16 01                   | i8x16.extract_lane_u 1
 000060: 20 00                      | local.get 0
 000062: fd 16 01                   | i8x16.extract_lane_u 1
 000065: 6c                         | i32.mul
 000066: fd 17 01                   | i8x16.replace_lane 1
 000069: 20 01                      | local.get 1
 00006b: fd 16 02                   | i8x16.extract_lane_u 2
 00006e: 20 00                      | local.get 0
 000070: fd 16 02                   | i8x16.extract_lane_u 2
 000073: 6c                         | i32.mul
 000074: fd 17 02                   | i8x16.replace_lane 2
 000077: 20 01                      | local.get 1
 000079: fd 16 03                   | i8x16.extract_lane_u 3
 00007c: 20 00                      | local.get 0
 00007e: fd 16 03                   | i8x16.extract_lane_u 3
 000081: 6c                         | i32.mul
 000082: fd 17 03                   | i8x16.replace_lane 3
 000085: 20 01                      | local.get 1
 000087: fd 16 04                   | i8x16.extract_lane_u 4
 00008a: 20 00                      | local.get 0
 00008c: fd 16 04                   | i8x16.extract_lane_u 4
 00008f: 6c                         | i32.mul
 000090: fd 17 04                   | i8x16.replace_lane 4
 000093: 20 01                      | local.get 1
 000095: fd 16 05                   | i8x16.extract_lane_u 5
 000098: 20 00                      | local.get 0
 00009a: fd 16 05                   | i8x16.extract_lane_u 5
 00009d: 6c                         | i32.mul
 00009e: fd 17 05                   | i8x16.replace_lane 5
 0000a1: 20 01                      | local.get 1
 0000a3: fd 16 06                   | i8x16.extract_lane_u 6
 0000a6: 20 00                      | local.get 0
 0000a8: fd 16 06                   | i8x16.extract_lane_u 6
 0000ab: 6c                         | i32.mul
 0000ac: fd 17 06                   | i8x16.replace_lane 6
 0000af: 20 01                      | local.get 1
 0000b1: fd 16 07                   | i8x16.extract_lane_u 7
 0000b4: 20 00                      | local.get 0
 0000b6: fd 16 07                   | i8x16.extract_lane_u 7
 0000b9: 6c                         | i32.mul
 0000ba: fd 17 07                   | i8x16.replace_lane 7
 0000bd: 20 01                      | local.get 1
 0000bf: fd 16 08                   | i8x16.extract_lane_u 8
 0000c2: 20 00                      | local.get 0
 0000c4: fd 16 08                   | i8x16.extract_lane_u 8
 0000c7: 6c                         | i32.mul
 0000c8: fd 17 08                   | i8x16.replace_lane 8
 0000cb: 20 01                      | local.get 1
 0000cd: fd 16 09                   | i8x16.extract_lane_u 9
 0000d0: 20 00                      | local.get 0
 0000d2: fd 16 09                   | i8x16.extract_lane_u 9
 0000d5: 6c                         | i32.mul
 0000d6: fd 17 09                   | i8x16.replace_lane 9
 0000d9: 20 01                      | local.get 1
 0000db: fd 16 0a                   | i8x16.extract_lane_u 10
 0000de: 20 00                      | local.get 0
 0000e0: fd 16 0a                   | i8x16.extract_lane_u 10
 0000e3: 6c                         | i32.mul
 0000e4: fd 17 0a                   | i8x16.replace_lane 10
 0000e7: 20 01                      | local.get 1
 0000e9: fd 16 0b                   | i8x16.extract_lane_u 11
 0000ec: 20 00                      | local.get 0
 0000ee: fd 16 0b                   | i8x16.extract_lane_u 11
 0000f1: 6c                         | i32.mul
 0000f2: fd 17 0b                   | i8x16.replace_lane 11
 0000f5: 20 01                      | local.get 1
 0000f7: fd 16 0c                   | i8x16.extract_lane_u 12
 0000fa: 20 00                      | local.get 0
 0000fc: fd 16 0c                   | i8x16.extract_lane_u 12
 0000ff: 6c                         | i32.mul
 000100: fd 17 0c                   | i8x16.replace_lane 12
 000103: 20 01                      | local.get 1
 000105: fd 16 0d                   | i8x16.extract_lane_u 13
 000108: 20 00                      | local.get 0
 00010a: fd 16 0d                   | i8x16.extract_lane_u 13
 00010d: 6c                         | i32.mul
 00010e: fd 17 0d                   | i8x16.replace_lane 13
 000111: 20 01                      | local.get 1
 000113: fd 16 0e                   | i8x16.extract_lane_u 14
 000116: 20 00                      | local.get 0
 000118: fd 16 0e                   | i8x16.extract_lane_u 14
 00011b: 6c                         | i32.mul
 00011c: fd 17 0e                   | i8x16.replace_lane 14
 00011f: 20 01                      | local.get 1
 000121: fd 16 0f                   | i8x16.extract_lane_u 15
 000124: 20 00                      | local.get 0
 000126: fd 16 0f                   | i8x16.extract_lane_u 15
 000129: 6c                         | i32.mul
 00012a: fd 17 0f                   | i8x16.replace_lane 15
 00012d: 0b                         | end
000130 func[1] <mul_u8x16>:
 000131: 20 01                      | local.get 1
 000133: fd 16 00                   | i8x16.extract_lane_u 0
 000136: 20 00                      | local.get 0
 000138: fd 16 00                   | i8x16.extract_lane_u 0
 00013b: 6c                         | i32.mul
 00013c: fd 0f                      | i8x16.splat
 00013e: 20 01                      | local.get 1
 000140: fd 16 01                   | i8x16.extract_lane_u 1
 000143: 20 00                      | local.get 0
 000145: fd 16 01                   | i8x16.extract_lane_u 1
 000148: 6c                         | i32.mul
 000149: fd 17 01                   | i8x16.replace_lane 1
 00014c: 20 01                      | local.get 1
 00014e: fd 16 02                   | i8x16.extract_lane_u 2
 000151: 20 00                      | local.get 0
 000153: fd 16 02                   | i8x16.extract_lane_u 2
 000156: 6c                         | i32.mul
 000157: fd 17 02                   | i8x16.replace_lane 2
 00015a: 20 01                      | local.get 1
 00015c: fd 16 03                   | i8x16.extract_lane_u 3
 00015f: 20 00                      | local.get 0
 000161: fd 16 03                   | i8x16.extract_lane_u 3
 000164: 6c                         | i32.mul
 000165: fd 17 03                   | i8x16.replace_lane 3
 000168: 20 01                      | local.get 1
 00016a: fd 16 04                   | i8x16.extract_lane_u 4
 00016d: 20 00                      | local.get 0
 00016f: fd 16 04                   | i8x16.extract_lane_u 4
 000172: 6c                         | i32.mul
 000173: fd 17 04                   | i8x16.replace_lane 4
 000176: 20 01                      | local.get 1
 000178: fd 16 05                   | i8x16.extract_lane_u 5
 00017b: 20 00                      | local.get 0
 00017d: fd 16 05                   | i8x16.extract_lane_u 5
 000180: 6c                         | i32.mul
 000181: fd 17 05                   | i8x16.replace_lane 5
 000184: 20 01                      | local.get 1
 000186: fd 16 06                   | i8x16.extract_lane_u 6
 000189: 20 00                      | local.get 0
 00018b: fd 16 06                   | i8x16.extract_lane_u 6
 00018e: 6c                         | i32.mul
 00018f: fd 17 06                   | i8x16.replace_lane 6
 000192: 20 01                      | local.get 1
 000194: fd 16 07                   | i8x16.extract_lane_u 7
 000197: 20 00                      | local.get 0
 000199: fd 16 07                   | i8x16.extract_lane_u 7
 00019c: 6c                         | i32.mul
 00019d: fd 17 07                   | i8x16.replace_lane 7
 0001a0: 20 01                      | local.get 1
 0001a2: fd 16 08                   | i8x16.extract_lane_u 8
 0001a5: 20 00                      | local.get 0
 0001a7: fd 16 08                   | i8x16.extract_lane_u 8
 0001aa: 6c                         | i32.mul
 0001ab: fd 17 08                   | i8x16.replace_lane 8
 0001ae: 20 01                      | local.get 1
 0001b0: fd 16 09                   | i8x16.extract_lane_u 9
 0001b3: 20 00                      | local.get 0
 0001b5: fd 16 09                   | i8x16.extract_lane_u 9
 0001b8: 6c                         | i32.mul
 0001b9: fd 17 09                   | i8x16.replace_lane 9
 0001bc: 20 01                      | local.get 1
 0001be: fd 16 0a                   | i8x16.extract_lane_u 10
 0001c1: 20 00                      | local.get 0
 0001c3: fd 16 0a                   | i8x16.extract_lane_u 10
 0001c6: 6c                         | i32.mul
 0001c7: fd 17 0a                   | i8x16.replace_lane 10
 0001ca: 20 01                      | local.get 1
 0001cc: fd 16 0b                   | i8x16.extract_lane_u 11
 0001cf: 20 00                      | local.get 0
 0001d1: fd 16 0b                   | i8x16.extract_lane_u 11
 0001d4: 6c                         | i32.mul
 0001d5: fd 17 0b                   | i8x16.replace_lane 11
 0001d8: 20 01                      | local.get 1
 0001da: fd 16 0c                   | i8x16.extract_lane_u 12
 0001dd: 20 00                      | local.get 0
 0001df: fd 16 0c                   | i8x16.extract_lane_u 12
 0001e2: 6c                         | i32.mul
 0001e3: fd 17 0c                   | i8x16.replace_lane 12
 0001e6: 20 01                      | local.get 1
 0001e8: fd 16 0d                   | i8x16.extract_lane_u 13
 0001eb: 20 00                      | local.get 0
 0001ed: fd 16 0d                   | i8x16.extract_lane_u 13
 0001f0: 6c                         | i32.mul
 0001f1: fd 17 0d                   | i8x16.replace_lane 13
 0001f4: 20 01                      | local.get 1
 0001f6: fd 16 0e                   | i8x16.extract_lane_u 14
 0001f9: 20 00                      | local.get 0
 0001fb: fd 16 0e                   | i8x16.extract_lane_u 14
 0001fe: 6c                         | i32.mul
 0001ff: fd 17 0e                   | i8x16.replace_lane 14
 000202: 20 01                      | local.get 1
 000204: fd 16 0f                   | i8x16.extract_lane_u 15
 000207: 20 00                      | local.get 0
 000209: fd 16 0f                   | i8x16.extract_lane_u 15
 00020c: 6c                         | i32.mul
 00020d: fd 17 0f                   | i8x16.replace_lane 15
 000210: 0b                         | end
000212 func[2] <mul_i16x8>:
 000213: 20 01                      | local.get 1
 000215: 20 00                      | local.get 0
 000217: fd 95 01                   | i16x8.mul
 00021a: 0b                         | end
00021c func[3] <mul_u16x8>:
 00021d: 20 01                      | local.get 1
 00021f: 20 00                      | local.get 0
 000221: fd 95 01                   | i16x8.mul
 000224: 0b                         | end
000226 func[4] <mul_i32x4>:
 000227: 20 01                      | local.get 1
 000229: 20 00                      | local.get 0
 00022b: fd b5 01                   | i32x4.mul
 00022e: 0b                         | end
000230 func[5] <mul_u32x4>:
 000231: 20 01                      | local.get 1
 000233: 20 00                      | local.get 0
 000235: fd b5 01                   | i32x4.mul
 000238: 0b                         | end
00023a func[6] <mul_i64x2>:
 00023b: 20 01                      | local.get 1
 00023d: 20 00                      | local.get 0
 00023f: fd d5 01                   | i64x2.mul
 000242: 0b                         | end
000244 func[7] <mul_u64x2>:
 000245: 20 01                      | local.get 1
 000247: 20 00                      | local.get 0
 000249: fd d5 01                   | i64x2.mul
 00024c: 0b                         | end
00024e func[8] <mul_f32x4>:
 00024f: 20 00                      | local.get 0
 000251: 20 01                      | local.get 1
 000253: fd e6 01                   | f32x4.mul
 000256: 0b                         | end
000258 func[9] <mul_f64x2>:
 000259: 20 00                      | local.get 0
 00025b: 20 01                      | local.get 1
 00025d: fd f2 01                   | f64x2.mul
 000260: 0b                         | end
