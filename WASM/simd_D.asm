
simd_D.wasm:	file format wasm 0x1

Code Disassembly:

00004d func[0] <div_i8x16>:
 00004e: 20 00                      | local.get 0
 000050: fd 15 00                   | i8x16.extract_lane_s 0
 000053: 20 01                      | local.get 1
 000055: fd 15 00                   | i8x16.extract_lane_s 0
 000058: 6d                         | i32.div_s
 000059: fd 0f                      | i8x16.splat
 00005b: 20 00                      | local.get 0
 00005d: fd 15 01                   | i8x16.extract_lane_s 1
 000060: 20 01                      | local.get 1
 000062: fd 15 01                   | i8x16.extract_lane_s 1
 000065: 6d                         | i32.div_s
 000066: fd 17 01                   | i8x16.replace_lane 1
 000069: 20 00                      | local.get 0
 00006b: fd 15 02                   | i8x16.extract_lane_s 2
 00006e: 20 01                      | local.get 1
 000070: fd 15 02                   | i8x16.extract_lane_s 2
 000073: 6d                         | i32.div_s
 000074: fd 17 02                   | i8x16.replace_lane 2
 000077: 20 00                      | local.get 0
 000079: fd 15 03                   | i8x16.extract_lane_s 3
 00007c: 20 01                      | local.get 1
 00007e: fd 15 03                   | i8x16.extract_lane_s 3
 000081: 6d                         | i32.div_s
 000082: fd 17 03                   | i8x16.replace_lane 3
 000085: 20 00                      | local.get 0
 000087: fd 15 04                   | i8x16.extract_lane_s 4
 00008a: 20 01                      | local.get 1
 00008c: fd 15 04                   | i8x16.extract_lane_s 4
 00008f: 6d                         | i32.div_s
 000090: fd 17 04                   | i8x16.replace_lane 4
 000093: 20 00                      | local.get 0
 000095: fd 15 05                   | i8x16.extract_lane_s 5
 000098: 20 01                      | local.get 1
 00009a: fd 15 05                   | i8x16.extract_lane_s 5
 00009d: 6d                         | i32.div_s
 00009e: fd 17 05                   | i8x16.replace_lane 5
 0000a1: 20 00                      | local.get 0
 0000a3: fd 15 06                   | i8x16.extract_lane_s 6
 0000a6: 20 01                      | local.get 1
 0000a8: fd 15 06                   | i8x16.extract_lane_s 6
 0000ab: 6d                         | i32.div_s
 0000ac: fd 17 06                   | i8x16.replace_lane 6
 0000af: 20 00                      | local.get 0
 0000b1: fd 15 07                   | i8x16.extract_lane_s 7
 0000b4: 20 01                      | local.get 1
 0000b6: fd 15 07                   | i8x16.extract_lane_s 7
 0000b9: 6d                         | i32.div_s
 0000ba: fd 17 07                   | i8x16.replace_lane 7
 0000bd: 20 00                      | local.get 0
 0000bf: fd 15 08                   | i8x16.extract_lane_s 8
 0000c2: 20 01                      | local.get 1
 0000c4: fd 15 08                   | i8x16.extract_lane_s 8
 0000c7: 6d                         | i32.div_s
 0000c8: fd 17 08                   | i8x16.replace_lane 8
 0000cb: 20 00                      | local.get 0
 0000cd: fd 15 09                   | i8x16.extract_lane_s 9
 0000d0: 20 01                      | local.get 1
 0000d2: fd 15 09                   | i8x16.extract_lane_s 9
 0000d5: 6d                         | i32.div_s
 0000d6: fd 17 09                   | i8x16.replace_lane 9
 0000d9: 20 00                      | local.get 0
 0000db: fd 15 0a                   | i8x16.extract_lane_s 10
 0000de: 20 01                      | local.get 1
 0000e0: fd 15 0a                   | i8x16.extract_lane_s 10
 0000e3: 6d                         | i32.div_s
 0000e4: fd 17 0a                   | i8x16.replace_lane 10
 0000e7: 20 00                      | local.get 0
 0000e9: fd 15 0b                   | i8x16.extract_lane_s 11
 0000ec: 20 01                      | local.get 1
 0000ee: fd 15 0b                   | i8x16.extract_lane_s 11
 0000f1: 6d                         | i32.div_s
 0000f2: fd 17 0b                   | i8x16.replace_lane 11
 0000f5: 20 00                      | local.get 0
 0000f7: fd 15 0c                   | i8x16.extract_lane_s 12
 0000fa: 20 01                      | local.get 1
 0000fc: fd 15 0c                   | i8x16.extract_lane_s 12
 0000ff: 6d                         | i32.div_s
 000100: fd 17 0c                   | i8x16.replace_lane 12
 000103: 20 00                      | local.get 0
 000105: fd 15 0d                   | i8x16.extract_lane_s 13
 000108: 20 01                      | local.get 1
 00010a: fd 15 0d                   | i8x16.extract_lane_s 13
 00010d: 6d                         | i32.div_s
 00010e: fd 17 0d                   | i8x16.replace_lane 13
 000111: 20 00                      | local.get 0
 000113: fd 15 0e                   | i8x16.extract_lane_s 14
 000116: 20 01                      | local.get 1
 000118: fd 15 0e                   | i8x16.extract_lane_s 14
 00011b: 6d                         | i32.div_s
 00011c: fd 17 0e                   | i8x16.replace_lane 14
 00011f: 20 00                      | local.get 0
 000121: fd 15 0f                   | i8x16.extract_lane_s 15
 000124: 20 01                      | local.get 1
 000126: fd 15 0f                   | i8x16.extract_lane_s 15
 000129: 6d                         | i32.div_s
 00012a: fd 17 0f                   | i8x16.replace_lane 15
 00012d: 0b                         | end
000130 func[1] <div_u8x16>:
 000131: 20 00                      | local.get 0
 000133: fd 16 00                   | i8x16.extract_lane_u 0
 000136: 20 01                      | local.get 1
 000138: fd 16 00                   | i8x16.extract_lane_u 0
 00013b: 6e                         | i32.div_u
 00013c: fd 0f                      | i8x16.splat
 00013e: 20 00                      | local.get 0
 000140: fd 16 01                   | i8x16.extract_lane_u 1
 000143: 20 01                      | local.get 1
 000145: fd 16 01                   | i8x16.extract_lane_u 1
 000148: 6e                         | i32.div_u
 000149: fd 17 01                   | i8x16.replace_lane 1
 00014c: 20 00                      | local.get 0
 00014e: fd 16 02                   | i8x16.extract_lane_u 2
 000151: 20 01                      | local.get 1
 000153: fd 16 02                   | i8x16.extract_lane_u 2
 000156: 6e                         | i32.div_u
 000157: fd 17 02                   | i8x16.replace_lane 2
 00015a: 20 00                      | local.get 0
 00015c: fd 16 03                   | i8x16.extract_lane_u 3
 00015f: 20 01                      | local.get 1
 000161: fd 16 03                   | i8x16.extract_lane_u 3
 000164: 6e                         | i32.div_u
 000165: fd 17 03                   | i8x16.replace_lane 3
 000168: 20 00                      | local.get 0
 00016a: fd 16 04                   | i8x16.extract_lane_u 4
 00016d: 20 01                      | local.get 1
 00016f: fd 16 04                   | i8x16.extract_lane_u 4
 000172: 6e                         | i32.div_u
 000173: fd 17 04                   | i8x16.replace_lane 4
 000176: 20 00                      | local.get 0
 000178: fd 16 05                   | i8x16.extract_lane_u 5
 00017b: 20 01                      | local.get 1
 00017d: fd 16 05                   | i8x16.extract_lane_u 5
 000180: 6e                         | i32.div_u
 000181: fd 17 05                   | i8x16.replace_lane 5
 000184: 20 00                      | local.get 0
 000186: fd 16 06                   | i8x16.extract_lane_u 6
 000189: 20 01                      | local.get 1
 00018b: fd 16 06                   | i8x16.extract_lane_u 6
 00018e: 6e                         | i32.div_u
 00018f: fd 17 06                   | i8x16.replace_lane 6
 000192: 20 00                      | local.get 0
 000194: fd 16 07                   | i8x16.extract_lane_u 7
 000197: 20 01                      | local.get 1
 000199: fd 16 07                   | i8x16.extract_lane_u 7
 00019c: 6e                         | i32.div_u
 00019d: fd 17 07                   | i8x16.replace_lane 7
 0001a0: 20 00                      | local.get 0
 0001a2: fd 16 08                   | i8x16.extract_lane_u 8
 0001a5: 20 01                      | local.get 1
 0001a7: fd 16 08                   | i8x16.extract_lane_u 8
 0001aa: 6e                         | i32.div_u
 0001ab: fd 17 08                   | i8x16.replace_lane 8
 0001ae: 20 00                      | local.get 0
 0001b0: fd 16 09                   | i8x16.extract_lane_u 9
 0001b3: 20 01                      | local.get 1
 0001b5: fd 16 09                   | i8x16.extract_lane_u 9
 0001b8: 6e                         | i32.div_u
 0001b9: fd 17 09                   | i8x16.replace_lane 9
 0001bc: 20 00                      | local.get 0
 0001be: fd 16 0a                   | i8x16.extract_lane_u 10
 0001c1: 20 01                      | local.get 1
 0001c3: fd 16 0a                   | i8x16.extract_lane_u 10
 0001c6: 6e                         | i32.div_u
 0001c7: fd 17 0a                   | i8x16.replace_lane 10
 0001ca: 20 00                      | local.get 0
 0001cc: fd 16 0b                   | i8x16.extract_lane_u 11
 0001cf: 20 01                      | local.get 1
 0001d1: fd 16 0b                   | i8x16.extract_lane_u 11
 0001d4: 6e                         | i32.div_u
 0001d5: fd 17 0b                   | i8x16.replace_lane 11
 0001d8: 20 00                      | local.get 0
 0001da: fd 16 0c                   | i8x16.extract_lane_u 12
 0001dd: 20 01                      | local.get 1
 0001df: fd 16 0c                   | i8x16.extract_lane_u 12
 0001e2: 6e                         | i32.div_u
 0001e3: fd 17 0c                   | i8x16.replace_lane 12
 0001e6: 20 00                      | local.get 0
 0001e8: fd 16 0d                   | i8x16.extract_lane_u 13
 0001eb: 20 01                      | local.get 1
 0001ed: fd 16 0d                   | i8x16.extract_lane_u 13
 0001f0: 6e                         | i32.div_u
 0001f1: fd 17 0d                   | i8x16.replace_lane 13
 0001f4: 20 00                      | local.get 0
 0001f6: fd 16 0e                   | i8x16.extract_lane_u 14
 0001f9: 20 01                      | local.get 1
 0001fb: fd 16 0e                   | i8x16.extract_lane_u 14
 0001fe: 6e                         | i32.div_u
 0001ff: fd 17 0e                   | i8x16.replace_lane 14
 000202: 20 00                      | local.get 0
 000204: fd 16 0f                   | i8x16.extract_lane_u 15
 000207: 20 01                      | local.get 1
 000209: fd 16 0f                   | i8x16.extract_lane_u 15
 00020c: 6e                         | i32.div_u
 00020d: fd 17 0f                   | i8x16.replace_lane 15
 000210: 0b                         | end
000212 func[2] <div_i16x8>:
 000213: 20 00                      | local.get 0
 000215: fd 18 00                   | i16x8.extract_lane_s 0
 000218: 20 01                      | local.get 1
 00021a: fd 18 00                   | i16x8.extract_lane_s 0
 00021d: 6d                         | i32.div_s
 00021e: fd 10                      | i16x8.splat
 000220: 20 00                      | local.get 0
 000222: fd 18 01                   | i16x8.extract_lane_s 1
 000225: 20 01                      | local.get 1
 000227: fd 18 01                   | i16x8.extract_lane_s 1
 00022a: 6d                         | i32.div_s
 00022b: fd 1a 01                   | i16x8.replace_lane 1
 00022e: 20 00                      | local.get 0
 000230: fd 18 02                   | i16x8.extract_lane_s 2
 000233: 20 01                      | local.get 1
 000235: fd 18 02                   | i16x8.extract_lane_s 2
 000238: 6d                         | i32.div_s
 000239: fd 1a 02                   | i16x8.replace_lane 2
 00023c: 20 00                      | local.get 0
 00023e: fd 18 03                   | i16x8.extract_lane_s 3
 000241: 20 01                      | local.get 1
 000243: fd 18 03                   | i16x8.extract_lane_s 3
 000246: 6d                         | i32.div_s
 000247: fd 1a 03                   | i16x8.replace_lane 3
 00024a: 20 00                      | local.get 0
 00024c: fd 18 04                   | i16x8.extract_lane_s 4
 00024f: 20 01                      | local.get 1
 000251: fd 18 04                   | i16x8.extract_lane_s 4
 000254: 6d                         | i32.div_s
 000255: fd 1a 04                   | i16x8.replace_lane 4
 000258: 20 00                      | local.get 0
 00025a: fd 18 05                   | i16x8.extract_lane_s 5
 00025d: 20 01                      | local.get 1
 00025f: fd 18 05                   | i16x8.extract_lane_s 5
 000262: 6d                         | i32.div_s
 000263: fd 1a 05                   | i16x8.replace_lane 5
 000266: 20 00                      | local.get 0
 000268: fd 18 06                   | i16x8.extract_lane_s 6
 00026b: 20 01                      | local.get 1
 00026d: fd 18 06                   | i16x8.extract_lane_s 6
 000270: 6d                         | i32.div_s
 000271: fd 1a 06                   | i16x8.replace_lane 6
 000274: 20 00                      | local.get 0
 000276: fd 18 07                   | i16x8.extract_lane_s 7
 000279: 20 01                      | local.get 1
 00027b: fd 18 07                   | i16x8.extract_lane_s 7
 00027e: 6d                         | i32.div_s
 00027f: fd 1a 07                   | i16x8.replace_lane 7
 000282: 0b                         | end
000284 func[3] <div_u16x8>:
 000285: 20 00                      | local.get 0
 000287: fd 19 00                   | i16x8.extract_lane_u 0
 00028a: 20 01                      | local.get 1
 00028c: fd 19 00                   | i16x8.extract_lane_u 0
 00028f: 6e                         | i32.div_u
 000290: fd 10                      | i16x8.splat
 000292: 20 00                      | local.get 0
 000294: fd 19 01                   | i16x8.extract_lane_u 1
 000297: 20 01                      | local.get 1
 000299: fd 19 01                   | i16x8.extract_lane_u 1
 00029c: 6e                         | i32.div_u
 00029d: fd 1a 01                   | i16x8.replace_lane 1
 0002a0: 20 00                      | local.get 0
 0002a2: fd 19 02                   | i16x8.extract_lane_u 2
 0002a5: 20 01                      | local.get 1
 0002a7: fd 19 02                   | i16x8.extract_lane_u 2
 0002aa: 6e                         | i32.div_u
 0002ab: fd 1a 02                   | i16x8.replace_lane 2
 0002ae: 20 00                      | local.get 0
 0002b0: fd 19 03                   | i16x8.extract_lane_u 3
 0002b3: 20 01                      | local.get 1
 0002b5: fd 19 03                   | i16x8.extract_lane_u 3
 0002b8: 6e                         | i32.div_u
 0002b9: fd 1a 03                   | i16x8.replace_lane 3
 0002bc: 20 00                      | local.get 0
 0002be: fd 19 04                   | i16x8.extract_lane_u 4
 0002c1: 20 01                      | local.get 1
 0002c3: fd 19 04                   | i16x8.extract_lane_u 4
 0002c6: 6e                         | i32.div_u
 0002c7: fd 1a 04                   | i16x8.replace_lane 4
 0002ca: 20 00                      | local.get 0
 0002cc: fd 19 05                   | i16x8.extract_lane_u 5
 0002cf: 20 01                      | local.get 1
 0002d1: fd 19 05                   | i16x8.extract_lane_u 5
 0002d4: 6e                         | i32.div_u
 0002d5: fd 1a 05                   | i16x8.replace_lane 5
 0002d8: 20 00                      | local.get 0
 0002da: fd 19 06                   | i16x8.extract_lane_u 6
 0002dd: 20 01                      | local.get 1
 0002df: fd 19 06                   | i16x8.extract_lane_u 6
 0002e2: 6e                         | i32.div_u
 0002e3: fd 1a 06                   | i16x8.replace_lane 6
 0002e6: 20 00                      | local.get 0
 0002e8: fd 19 07                   | i16x8.extract_lane_u 7
 0002eb: 20 01                      | local.get 1
 0002ed: fd 19 07                   | i16x8.extract_lane_u 7
 0002f0: 6e                         | i32.div_u
 0002f1: fd 1a 07                   | i16x8.replace_lane 7
 0002f4: 0b                         | end
0002f6 func[4] <div_i32x4>:
 0002f7: 20 00                      | local.get 0
 0002f9: fd 1b 00                   | i32x4.extract_lane 0
 0002fc: 20 01                      | local.get 1
 0002fe: fd 1b 00                   | i32x4.extract_lane 0
 000301: 6d                         | i32.div_s
 000302: fd 11                      | i32x4.splat
 000304: 20 00                      | local.get 0
 000306: fd 1b 01                   | i32x4.extract_lane 1
 000309: 20 01                      | local.get 1
 00030b: fd 1b 01                   | i32x4.extract_lane 1
 00030e: 6d                         | i32.div_s
 00030f: fd 1c 01                   | i32x4.replace_lane 1
 000312: 20 00                      | local.get 0
 000314: fd 1b 02                   | i32x4.extract_lane 2
 000317: 20 01                      | local.get 1
 000319: fd 1b 02                   | i32x4.extract_lane 2
 00031c: 6d                         | i32.div_s
 00031d: fd 1c 02                   | i32x4.replace_lane 2
 000320: 20 00                      | local.get 0
 000322: fd 1b 03                   | i32x4.extract_lane 3
 000325: 20 01                      | local.get 1
 000327: fd 1b 03                   | i32x4.extract_lane 3
 00032a: 6d                         | i32.div_s
 00032b: fd 1c 03                   | i32x4.replace_lane 3
 00032e: 0b                         | end
000330 func[5] <div_u32x4>:
 000331: 20 00                      | local.get 0
 000333: fd 1b 00                   | i32x4.extract_lane 0
 000336: 20 01                      | local.get 1
 000338: fd 1b 00                   | i32x4.extract_lane 0
 00033b: 6e                         | i32.div_u
 00033c: fd 11                      | i32x4.splat
 00033e: 20 00                      | local.get 0
 000340: fd 1b 01                   | i32x4.extract_lane 1
 000343: 20 01                      | local.get 1
 000345: fd 1b 01                   | i32x4.extract_lane 1
 000348: 6e                         | i32.div_u
 000349: fd 1c 01                   | i32x4.replace_lane 1
 00034c: 20 00                      | local.get 0
 00034e: fd 1b 02                   | i32x4.extract_lane 2
 000351: 20 01                      | local.get 1
 000353: fd 1b 02                   | i32x4.extract_lane 2
 000356: 6e                         | i32.div_u
 000357: fd 1c 02                   | i32x4.replace_lane 2
 00035a: 20 00                      | local.get 0
 00035c: fd 1b 03                   | i32x4.extract_lane 3
 00035f: 20 01                      | local.get 1
 000361: fd 1b 03                   | i32x4.extract_lane 3
 000364: 6e                         | i32.div_u
 000365: fd 1c 03                   | i32x4.replace_lane 3
 000368: 0b                         | end
00036a func[6] <div_i64x2>:
 00036b: 20 00                      | local.get 0
 00036d: fd 1d 00                   | i64x2.extract_lane 0
 000370: 20 01                      | local.get 1
 000372: fd 1d 00                   | i64x2.extract_lane 0
 000375: 7f                         | i64.div_s
 000376: fd 12                      | i64x2.splat
 000378: 20 00                      | local.get 0
 00037a: fd 1d 01                   | i64x2.extract_lane 1
 00037d: 20 01                      | local.get 1
 00037f: fd 1d 01                   | i64x2.extract_lane 1
 000382: 7f                         | i64.div_s
 000383: fd 1e 01                   | i64x2.replace_lane 1
 000386: 0b                         | end
000388 func[7] <div_u64x2>:
 000389: 20 00                      | local.get 0
 00038b: fd 1d 00                   | i64x2.extract_lane 0
 00038e: 20 01                      | local.get 1
 000390: fd 1d 00                   | i64x2.extract_lane 0
 000393: 80                         | i64.div_u
 000394: fd 12                      | i64x2.splat
 000396: 20 00                      | local.get 0
 000398: fd 1d 01                   | i64x2.extract_lane 1
 00039b: 20 01                      | local.get 1
 00039d: fd 1d 01                   | i64x2.extract_lane 1
 0003a0: 80                         | i64.div_u
 0003a1: fd 1e 01                   | i64x2.replace_lane 1
 0003a4: 0b                         | end
0003a6 func[8] <div_f32x4>:
 0003a7: 20 00                      | local.get 0
 0003a9: 20 01                      | local.get 1
 0003ab: fd e7 01                   | f32x4.div
 0003ae: 0b                         | end
0003b0 func[9] <div_f64x2>:
 0003b1: 20 00                      | local.get 0
 0003b3: 20 01                      | local.get 1
 0003b5: fd f3 01                   | f64x2.div
 0003b8: 0b                         | end
