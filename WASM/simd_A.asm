
simd_A.wasm:	file format wasm 0x1

Code Disassembly:

000079 func[0] <neg_i8x16>:
 00007a: 20 00                      | local.get 0
 00007c: fd 61                      | i8x16.neg
 00007e: 0b                         | end
000080 func[1] <add_i8x16>:
 000081: 20 01                      | local.get 1
 000083: 20 00                      | local.get 0
 000085: fd 6e                      | i8x16.add
 000087: 0b                         | end
000089 func[2] <sub_i8x16>:
 00008a: 20 00                      | local.get 0
 00008c: 20 01                      | local.get 1
 00008e: fd 71                      | i8x16.sub
 000090: 0b                         | end
000093 func[3] <mul_i8x16>:
 000094: 20 01                      | local.get 1
 000096: fd 16 00                   | i8x16.extract_lane_u 0
 000099: 20 00                      | local.get 0
 00009b: fd 16 00                   | i8x16.extract_lane_u 0
 00009e: 6c                         | i32.mul
 00009f: fd 0f                      | i8x16.splat
 0000a1: 20 01                      | local.get 1
 0000a3: fd 16 01                   | i8x16.extract_lane_u 1
 0000a6: 20 00                      | local.get 0
 0000a8: fd 16 01                   | i8x16.extract_lane_u 1
 0000ab: 6c                         | i32.mul
 0000ac: fd 17 01                   | i8x16.replace_lane 1
 0000af: 20 01                      | local.get 1
 0000b1: fd 16 02                   | i8x16.extract_lane_u 2
 0000b4: 20 00                      | local.get 0
 0000b6: fd 16 02                   | i8x16.extract_lane_u 2
 0000b9: 6c                         | i32.mul
 0000ba: fd 17 02                   | i8x16.replace_lane 2
 0000bd: 20 01                      | local.get 1
 0000bf: fd 16 03                   | i8x16.extract_lane_u 3
 0000c2: 20 00                      | local.get 0
 0000c4: fd 16 03                   | i8x16.extract_lane_u 3
 0000c7: 6c                         | i32.mul
 0000c8: fd 17 03                   | i8x16.replace_lane 3
 0000cb: 20 01                      | local.get 1
 0000cd: fd 16 04                   | i8x16.extract_lane_u 4
 0000d0: 20 00                      | local.get 0
 0000d2: fd 16 04                   | i8x16.extract_lane_u 4
 0000d5: 6c                         | i32.mul
 0000d6: fd 17 04                   | i8x16.replace_lane 4
 0000d9: 20 01                      | local.get 1
 0000db: fd 16 05                   | i8x16.extract_lane_u 5
 0000de: 20 00                      | local.get 0
 0000e0: fd 16 05                   | i8x16.extract_lane_u 5
 0000e3: 6c                         | i32.mul
 0000e4: fd 17 05                   | i8x16.replace_lane 5
 0000e7: 20 01                      | local.get 1
 0000e9: fd 16 06                   | i8x16.extract_lane_u 6
 0000ec: 20 00                      | local.get 0
 0000ee: fd 16 06                   | i8x16.extract_lane_u 6
 0000f1: 6c                         | i32.mul
 0000f2: fd 17 06                   | i8x16.replace_lane 6
 0000f5: 20 01                      | local.get 1
 0000f7: fd 16 07                   | i8x16.extract_lane_u 7
 0000fa: 20 00                      | local.get 0
 0000fc: fd 16 07                   | i8x16.extract_lane_u 7
 0000ff: 6c                         | i32.mul
 000100: fd 17 07                   | i8x16.replace_lane 7
 000103: 20 01                      | local.get 1
 000105: fd 16 08                   | i8x16.extract_lane_u 8
 000108: 20 00                      | local.get 0
 00010a: fd 16 08                   | i8x16.extract_lane_u 8
 00010d: 6c                         | i32.mul
 00010e: fd 17 08                   | i8x16.replace_lane 8
 000111: 20 01                      | local.get 1
 000113: fd 16 09                   | i8x16.extract_lane_u 9
 000116: 20 00                      | local.get 0
 000118: fd 16 09                   | i8x16.extract_lane_u 9
 00011b: 6c                         | i32.mul
 00011c: fd 17 09                   | i8x16.replace_lane 9
 00011f: 20 01                      | local.get 1
 000121: fd 16 0a                   | i8x16.extract_lane_u 10
 000124: 20 00                      | local.get 0
 000126: fd 16 0a                   | i8x16.extract_lane_u 10
 000129: 6c                         | i32.mul
 00012a: fd 17 0a                   | i8x16.replace_lane 10
 00012d: 20 01                      | local.get 1
 00012f: fd 16 0b                   | i8x16.extract_lane_u 11
 000132: 20 00                      | local.get 0
 000134: fd 16 0b                   | i8x16.extract_lane_u 11
 000137: 6c                         | i32.mul
 000138: fd 17 0b                   | i8x16.replace_lane 11
 00013b: 20 01                      | local.get 1
 00013d: fd 16 0c                   | i8x16.extract_lane_u 12
 000140: 20 00                      | local.get 0
 000142: fd 16 0c                   | i8x16.extract_lane_u 12
 000145: 6c                         | i32.mul
 000146: fd 17 0c                   | i8x16.replace_lane 12
 000149: 20 01                      | local.get 1
 00014b: fd 16 0d                   | i8x16.extract_lane_u 13
 00014e: 20 00                      | local.get 0
 000150: fd 16 0d                   | i8x16.extract_lane_u 13
 000153: 6c                         | i32.mul
 000154: fd 17 0d                   | i8x16.replace_lane 13
 000157: 20 01                      | local.get 1
 000159: fd 16 0e                   | i8x16.extract_lane_u 14
 00015c: 20 00                      | local.get 0
 00015e: fd 16 0e                   | i8x16.extract_lane_u 14
 000161: 6c                         | i32.mul
 000162: fd 17 0e                   | i8x16.replace_lane 14
 000165: 20 01                      | local.get 1
 000167: fd 16 0f                   | i8x16.extract_lane_u 15
 00016a: 20 00                      | local.get 0
 00016c: fd 16 0f                   | i8x16.extract_lane_u 15
 00016f: 6c                         | i32.mul
 000170: fd 17 0f                   | i8x16.replace_lane 15
 000173: 0b                         | end
000176 func[4] <div_i8x16>:
 000177: 20 00                      | local.get 0
 000179: fd 15 00                   | i8x16.extract_lane_s 0
 00017c: 20 01                      | local.get 1
 00017e: fd 15 00                   | i8x16.extract_lane_s 0
 000181: 6d                         | i32.div_s
 000182: fd 0f                      | i8x16.splat
 000184: 20 00                      | local.get 0
 000186: fd 15 01                   | i8x16.extract_lane_s 1
 000189: 20 01                      | local.get 1
 00018b: fd 15 01                   | i8x16.extract_lane_s 1
 00018e: 6d                         | i32.div_s
 00018f: fd 17 01                   | i8x16.replace_lane 1
 000192: 20 00                      | local.get 0
 000194: fd 15 02                   | i8x16.extract_lane_s 2
 000197: 20 01                      | local.get 1
 000199: fd 15 02                   | i8x16.extract_lane_s 2
 00019c: 6d                         | i32.div_s
 00019d: fd 17 02                   | i8x16.replace_lane 2
 0001a0: 20 00                      | local.get 0
 0001a2: fd 15 03                   | i8x16.extract_lane_s 3
 0001a5: 20 01                      | local.get 1
 0001a7: fd 15 03                   | i8x16.extract_lane_s 3
 0001aa: 6d                         | i32.div_s
 0001ab: fd 17 03                   | i8x16.replace_lane 3
 0001ae: 20 00                      | local.get 0
 0001b0: fd 15 04                   | i8x16.extract_lane_s 4
 0001b3: 20 01                      | local.get 1
 0001b5: fd 15 04                   | i8x16.extract_lane_s 4
 0001b8: 6d                         | i32.div_s
 0001b9: fd 17 04                   | i8x16.replace_lane 4
 0001bc: 20 00                      | local.get 0
 0001be: fd 15 05                   | i8x16.extract_lane_s 5
 0001c1: 20 01                      | local.get 1
 0001c3: fd 15 05                   | i8x16.extract_lane_s 5
 0001c6: 6d                         | i32.div_s
 0001c7: fd 17 05                   | i8x16.replace_lane 5
 0001ca: 20 00                      | local.get 0
 0001cc: fd 15 06                   | i8x16.extract_lane_s 6
 0001cf: 20 01                      | local.get 1
 0001d1: fd 15 06                   | i8x16.extract_lane_s 6
 0001d4: 6d                         | i32.div_s
 0001d5: fd 17 06                   | i8x16.replace_lane 6
 0001d8: 20 00                      | local.get 0
 0001da: fd 15 07                   | i8x16.extract_lane_s 7
 0001dd: 20 01                      | local.get 1
 0001df: fd 15 07                   | i8x16.extract_lane_s 7
 0001e2: 6d                         | i32.div_s
 0001e3: fd 17 07                   | i8x16.replace_lane 7
 0001e6: 20 00                      | local.get 0
 0001e8: fd 15 08                   | i8x16.extract_lane_s 8
 0001eb: 20 01                      | local.get 1
 0001ed: fd 15 08                   | i8x16.extract_lane_s 8
 0001f0: 6d                         | i32.div_s
 0001f1: fd 17 08                   | i8x16.replace_lane 8
 0001f4: 20 00                      | local.get 0
 0001f6: fd 15 09                   | i8x16.extract_lane_s 9
 0001f9: 20 01                      | local.get 1
 0001fb: fd 15 09                   | i8x16.extract_lane_s 9
 0001fe: 6d                         | i32.div_s
 0001ff: fd 17 09                   | i8x16.replace_lane 9
 000202: 20 00                      | local.get 0
 000204: fd 15 0a                   | i8x16.extract_lane_s 10
 000207: 20 01                      | local.get 1
 000209: fd 15 0a                   | i8x16.extract_lane_s 10
 00020c: 6d                         | i32.div_s
 00020d: fd 17 0a                   | i8x16.replace_lane 10
 000210: 20 00                      | local.get 0
 000212: fd 15 0b                   | i8x16.extract_lane_s 11
 000215: 20 01                      | local.get 1
 000217: fd 15 0b                   | i8x16.extract_lane_s 11
 00021a: 6d                         | i32.div_s
 00021b: fd 17 0b                   | i8x16.replace_lane 11
 00021e: 20 00                      | local.get 0
 000220: fd 15 0c                   | i8x16.extract_lane_s 12
 000223: 20 01                      | local.get 1
 000225: fd 15 0c                   | i8x16.extract_lane_s 12
 000228: 6d                         | i32.div_s
 000229: fd 17 0c                   | i8x16.replace_lane 12
 00022c: 20 00                      | local.get 0
 00022e: fd 15 0d                   | i8x16.extract_lane_s 13
 000231: 20 01                      | local.get 1
 000233: fd 15 0d                   | i8x16.extract_lane_s 13
 000236: 6d                         | i32.div_s
 000237: fd 17 0d                   | i8x16.replace_lane 13
 00023a: 20 00                      | local.get 0
 00023c: fd 15 0e                   | i8x16.extract_lane_s 14
 00023f: 20 01                      | local.get 1
 000241: fd 15 0e                   | i8x16.extract_lane_s 14
 000244: 6d                         | i32.div_s
 000245: fd 17 0e                   | i8x16.replace_lane 14
 000248: 20 00                      | local.get 0
 00024a: fd 15 0f                   | i8x16.extract_lane_s 15
 00024d: 20 01                      | local.get 1
 00024f: fd 15 0f                   | i8x16.extract_lane_s 15
 000252: 6d                         | i32.div_s
 000253: fd 17 0f                   | i8x16.replace_lane 15
 000256: 0b                         | end
000258 func[5] <neg_u8x16>:
 000259: 20 00                      | local.get 0
 00025b: fd 61                      | i8x16.neg
 00025d: 0b                         | end
00025f func[6] <add_u8x16>:
 000260: 20 01                      | local.get 1
 000262: 20 00                      | local.get 0
 000264: fd 6e                      | i8x16.add
 000266: 0b                         | end
000268 func[7] <sub_u8x16>:
 000269: 20 00                      | local.get 0
 00026b: 20 01                      | local.get 1
 00026d: fd 71                      | i8x16.sub
 00026f: 0b                         | end
000272 func[8] <mul_u8x16>:
 000273: 20 01                      | local.get 1
 000275: fd 16 00                   | i8x16.extract_lane_u 0
 000278: 20 00                      | local.get 0
 00027a: fd 16 00                   | i8x16.extract_lane_u 0
 00027d: 6c                         | i32.mul
 00027e: fd 0f                      | i8x16.splat
 000280: 20 01                      | local.get 1
 000282: fd 16 01                   | i8x16.extract_lane_u 1
 000285: 20 00                      | local.get 0
 000287: fd 16 01                   | i8x16.extract_lane_u 1
 00028a: 6c                         | i32.mul
 00028b: fd 17 01                   | i8x16.replace_lane 1
 00028e: 20 01                      | local.get 1
 000290: fd 16 02                   | i8x16.extract_lane_u 2
 000293: 20 00                      | local.get 0
 000295: fd 16 02                   | i8x16.extract_lane_u 2
 000298: 6c                         | i32.mul
 000299: fd 17 02                   | i8x16.replace_lane 2
 00029c: 20 01                      | local.get 1
 00029e: fd 16 03                   | i8x16.extract_lane_u 3
 0002a1: 20 00                      | local.get 0
 0002a3: fd 16 03                   | i8x16.extract_lane_u 3
 0002a6: 6c                         | i32.mul
 0002a7: fd 17 03                   | i8x16.replace_lane 3
 0002aa: 20 01                      | local.get 1
 0002ac: fd 16 04                   | i8x16.extract_lane_u 4
 0002af: 20 00                      | local.get 0
 0002b1: fd 16 04                   | i8x16.extract_lane_u 4
 0002b4: 6c                         | i32.mul
 0002b5: fd 17 04                   | i8x16.replace_lane 4
 0002b8: 20 01                      | local.get 1
 0002ba: fd 16 05                   | i8x16.extract_lane_u 5
 0002bd: 20 00                      | local.get 0
 0002bf: fd 16 05                   | i8x16.extract_lane_u 5
 0002c2: 6c                         | i32.mul
 0002c3: fd 17 05                   | i8x16.replace_lane 5
 0002c6: 20 01                      | local.get 1
 0002c8: fd 16 06                   | i8x16.extract_lane_u 6
 0002cb: 20 00                      | local.get 0
 0002cd: fd 16 06                   | i8x16.extract_lane_u 6
 0002d0: 6c                         | i32.mul
 0002d1: fd 17 06                   | i8x16.replace_lane 6
 0002d4: 20 01                      | local.get 1
 0002d6: fd 16 07                   | i8x16.extract_lane_u 7
 0002d9: 20 00                      | local.get 0
 0002db: fd 16 07                   | i8x16.extract_lane_u 7
 0002de: 6c                         | i32.mul
 0002df: fd 17 07                   | i8x16.replace_lane 7
 0002e2: 20 01                      | local.get 1
 0002e4: fd 16 08                   | i8x16.extract_lane_u 8
 0002e7: 20 00                      | local.get 0
 0002e9: fd 16 08                   | i8x16.extract_lane_u 8
 0002ec: 6c                         | i32.mul
 0002ed: fd 17 08                   | i8x16.replace_lane 8
 0002f0: 20 01                      | local.get 1
 0002f2: fd 16 09                   | i8x16.extract_lane_u 9
 0002f5: 20 00                      | local.get 0
 0002f7: fd 16 09                   | i8x16.extract_lane_u 9
 0002fa: 6c                         | i32.mul
 0002fb: fd 17 09                   | i8x16.replace_lane 9
 0002fe: 20 01                      | local.get 1
 000300: fd 16 0a                   | i8x16.extract_lane_u 10
 000303: 20 00                      | local.get 0
 000305: fd 16 0a                   | i8x16.extract_lane_u 10
 000308: 6c                         | i32.mul
 000309: fd 17 0a                   | i8x16.replace_lane 10
 00030c: 20 01                      | local.get 1
 00030e: fd 16 0b                   | i8x16.extract_lane_u 11
 000311: 20 00                      | local.get 0
 000313: fd 16 0b                   | i8x16.extract_lane_u 11
 000316: 6c                         | i32.mul
 000317: fd 17 0b                   | i8x16.replace_lane 11
 00031a: 20 01                      | local.get 1
 00031c: fd 16 0c                   | i8x16.extract_lane_u 12
 00031f: 20 00                      | local.get 0
 000321: fd 16 0c                   | i8x16.extract_lane_u 12
 000324: 6c                         | i32.mul
 000325: fd 17 0c                   | i8x16.replace_lane 12
 000328: 20 01                      | local.get 1
 00032a: fd 16 0d                   | i8x16.extract_lane_u 13
 00032d: 20 00                      | local.get 0
 00032f: fd 16 0d                   | i8x16.extract_lane_u 13
 000332: 6c                         | i32.mul
 000333: fd 17 0d                   | i8x16.replace_lane 13
 000336: 20 01                      | local.get 1
 000338: fd 16 0e                   | i8x16.extract_lane_u 14
 00033b: 20 00                      | local.get 0
 00033d: fd 16 0e                   | i8x16.extract_lane_u 14
 000340: 6c                         | i32.mul
 000341: fd 17 0e                   | i8x16.replace_lane 14
 000344: 20 01                      | local.get 1
 000346: fd 16 0f                   | i8x16.extract_lane_u 15
 000349: 20 00                      | local.get 0
 00034b: fd 16 0f                   | i8x16.extract_lane_u 15
 00034e: 6c                         | i32.mul
 00034f: fd 17 0f                   | i8x16.replace_lane 15
 000352: 0b                         | end
000355 func[9] <div_u8x16>:
 000356: 20 00                      | local.get 0
 000358: fd 16 00                   | i8x16.extract_lane_u 0
 00035b: 20 01                      | local.get 1
 00035d: fd 16 00                   | i8x16.extract_lane_u 0
 000360: 6e                         | i32.div_u
 000361: fd 0f                      | i8x16.splat
 000363: 20 00                      | local.get 0
 000365: fd 16 01                   | i8x16.extract_lane_u 1
 000368: 20 01                      | local.get 1
 00036a: fd 16 01                   | i8x16.extract_lane_u 1
 00036d: 6e                         | i32.div_u
 00036e: fd 17 01                   | i8x16.replace_lane 1
 000371: 20 00                      | local.get 0
 000373: fd 16 02                   | i8x16.extract_lane_u 2
 000376: 20 01                      | local.get 1
 000378: fd 16 02                   | i8x16.extract_lane_u 2
 00037b: 6e                         | i32.div_u
 00037c: fd 17 02                   | i8x16.replace_lane 2
 00037f: 20 00                      | local.get 0
 000381: fd 16 03                   | i8x16.extract_lane_u 3
 000384: 20 01                      | local.get 1
 000386: fd 16 03                   | i8x16.extract_lane_u 3
 000389: 6e                         | i32.div_u
 00038a: fd 17 03                   | i8x16.replace_lane 3
 00038d: 20 00                      | local.get 0
 00038f: fd 16 04                   | i8x16.extract_lane_u 4
 000392: 20 01                      | local.get 1
 000394: fd 16 04                   | i8x16.extract_lane_u 4
 000397: 6e                         | i32.div_u
 000398: fd 17 04                   | i8x16.replace_lane 4
 00039b: 20 00                      | local.get 0
 00039d: fd 16 05                   | i8x16.extract_lane_u 5
 0003a0: 20 01                      | local.get 1
 0003a2: fd 16 05                   | i8x16.extract_lane_u 5
 0003a5: 6e                         | i32.div_u
 0003a6: fd 17 05                   | i8x16.replace_lane 5
 0003a9: 20 00                      | local.get 0
 0003ab: fd 16 06                   | i8x16.extract_lane_u 6
 0003ae: 20 01                      | local.get 1
 0003b0: fd 16 06                   | i8x16.extract_lane_u 6
 0003b3: 6e                         | i32.div_u
 0003b4: fd 17 06                   | i8x16.replace_lane 6
 0003b7: 20 00                      | local.get 0
 0003b9: fd 16 07                   | i8x16.extract_lane_u 7
 0003bc: 20 01                      | local.get 1
 0003be: fd 16 07                   | i8x16.extract_lane_u 7
 0003c1: 6e                         | i32.div_u
 0003c2: fd 17 07                   | i8x16.replace_lane 7
 0003c5: 20 00                      | local.get 0
 0003c7: fd 16 08                   | i8x16.extract_lane_u 8
 0003ca: 20 01                      | local.get 1
 0003cc: fd 16 08                   | i8x16.extract_lane_u 8
 0003cf: 6e                         | i32.div_u
 0003d0: fd 17 08                   | i8x16.replace_lane 8
 0003d3: 20 00                      | local.get 0
 0003d5: fd 16 09                   | i8x16.extract_lane_u 9
 0003d8: 20 01                      | local.get 1
 0003da: fd 16 09                   | i8x16.extract_lane_u 9
 0003dd: 6e                         | i32.div_u
 0003de: fd 17 09                   | i8x16.replace_lane 9
 0003e1: 20 00                      | local.get 0
 0003e3: fd 16 0a                   | i8x16.extract_lane_u 10
 0003e6: 20 01                      | local.get 1
 0003e8: fd 16 0a                   | i8x16.extract_lane_u 10
 0003eb: 6e                         | i32.div_u
 0003ec: fd 17 0a                   | i8x16.replace_lane 10
 0003ef: 20 00                      | local.get 0
 0003f1: fd 16 0b                   | i8x16.extract_lane_u 11
 0003f4: 20 01                      | local.get 1
 0003f6: fd 16 0b                   | i8x16.extract_lane_u 11
 0003f9: 6e                         | i32.div_u
 0003fa: fd 17 0b                   | i8x16.replace_lane 11
 0003fd: 20 00                      | local.get 0
 0003ff: fd 16 0c                   | i8x16.extract_lane_u 12
 000402: 20 01                      | local.get 1
 000404: fd 16 0c                   | i8x16.extract_lane_u 12
 000407: 6e                         | i32.div_u
 000408: fd 17 0c                   | i8x16.replace_lane 12
 00040b: 20 00                      | local.get 0
 00040d: fd 16 0d                   | i8x16.extract_lane_u 13
 000410: 20 01                      | local.get 1
 000412: fd 16 0d                   | i8x16.extract_lane_u 13
 000415: 6e                         | i32.div_u
 000416: fd 17 0d                   | i8x16.replace_lane 13
 000419: 20 00                      | local.get 0
 00041b: fd 16 0e                   | i8x16.extract_lane_u 14
 00041e: 20 01                      | local.get 1
 000420: fd 16 0e                   | i8x16.extract_lane_u 14
 000423: 6e                         | i32.div_u
 000424: fd 17 0e                   | i8x16.replace_lane 14
 000427: 20 00                      | local.get 0
 000429: fd 16 0f                   | i8x16.extract_lane_u 15
 00042c: 20 01                      | local.get 1
 00042e: fd 16 0f                   | i8x16.extract_lane_u 15
 000431: 6e                         | i32.div_u
 000432: fd 17 0f                   | i8x16.replace_lane 15
 000435: 0b                         | end
000437 func[10] <neg_i16x8>:
 000438: 20 00                      | local.get 0
 00043a: fd 81 01                   | i16x8.neg
 00043d: 0b                         | end
00043f func[11] <add_i16x8>:
 000440: 20 01                      | local.get 1
 000442: 20 00                      | local.get 0
 000444: fd 8e 01                   | i16x8.add
 000447: 0b                         | end
000449 func[12] <sub_i16x8>:
 00044a: 20 00                      | local.get 0
 00044c: 20 01                      | local.get 1
 00044e: fd 91 01                   | i16x8.sub
 000451: 0b                         | end
000453 func[13] <mul_i16x8>:
 000454: 20 01                      | local.get 1
 000456: 20 00                      | local.get 0
 000458: fd 95 01                   | i16x8.mul
 00045b: 0b                         | end
00045d func[14] <div_i16x8>:
 00045e: 20 00                      | local.get 0
 000460: fd 18 00                   | i16x8.extract_lane_s 0
 000463: 20 01                      | local.get 1
 000465: fd 18 00                   | i16x8.extract_lane_s 0
 000468: 6d                         | i32.div_s
 000469: fd 10                      | i16x8.splat
 00046b: 20 00                      | local.get 0
 00046d: fd 18 01                   | i16x8.extract_lane_s 1
 000470: 20 01                      | local.get 1
 000472: fd 18 01                   | i16x8.extract_lane_s 1
 000475: 6d                         | i32.div_s
 000476: fd 1a 01                   | i16x8.replace_lane 1
 000479: 20 00                      | local.get 0
 00047b: fd 18 02                   | i16x8.extract_lane_s 2
 00047e: 20 01                      | local.get 1
 000480: fd 18 02                   | i16x8.extract_lane_s 2
 000483: 6d                         | i32.div_s
 000484: fd 1a 02                   | i16x8.replace_lane 2
 000487: 20 00                      | local.get 0
 000489: fd 18 03                   | i16x8.extract_lane_s 3
 00048c: 20 01                      | local.get 1
 00048e: fd 18 03                   | i16x8.extract_lane_s 3
 000491: 6d                         | i32.div_s
 000492: fd 1a 03                   | i16x8.replace_lane 3
 000495: 20 00                      | local.get 0
 000497: fd 18 04                   | i16x8.extract_lane_s 4
 00049a: 20 01                      | local.get 1
 00049c: fd 18 04                   | i16x8.extract_lane_s 4
 00049f: 6d                         | i32.div_s
 0004a0: fd 1a 04                   | i16x8.replace_lane 4
 0004a3: 20 00                      | local.get 0
 0004a5: fd 18 05                   | i16x8.extract_lane_s 5
 0004a8: 20 01                      | local.get 1
 0004aa: fd 18 05                   | i16x8.extract_lane_s 5
 0004ad: 6d                         | i32.div_s
 0004ae: fd 1a 05                   | i16x8.replace_lane 5
 0004b1: 20 00                      | local.get 0
 0004b3: fd 18 06                   | i16x8.extract_lane_s 6
 0004b6: 20 01                      | local.get 1
 0004b8: fd 18 06                   | i16x8.extract_lane_s 6
 0004bb: 6d                         | i32.div_s
 0004bc: fd 1a 06                   | i16x8.replace_lane 6
 0004bf: 20 00                      | local.get 0
 0004c1: fd 18 07                   | i16x8.extract_lane_s 7
 0004c4: 20 01                      | local.get 1
 0004c6: fd 18 07                   | i16x8.extract_lane_s 7
 0004c9: 6d                         | i32.div_s
 0004ca: fd 1a 07                   | i16x8.replace_lane 7
 0004cd: 0b                         | end
0004cf func[15] <neg_u16x8>:
 0004d0: 20 00                      | local.get 0
 0004d2: fd 81 01                   | i16x8.neg
 0004d5: 0b                         | end
0004d7 func[16] <add_u16x8>:
 0004d8: 20 01                      | local.get 1
 0004da: 20 00                      | local.get 0
 0004dc: fd 8e 01                   | i16x8.add
 0004df: 0b                         | end
0004e1 func[17] <sub_u16x8>:
 0004e2: 20 00                      | local.get 0
 0004e4: 20 01                      | local.get 1
 0004e6: fd 91 01                   | i16x8.sub
 0004e9: 0b                         | end
0004eb func[18] <mul_u16x8>:
 0004ec: 20 01                      | local.get 1
 0004ee: 20 00                      | local.get 0
 0004f0: fd 95 01                   | i16x8.mul
 0004f3: 0b                         | end
0004f5 func[19] <div_u16x8>:
 0004f6: 20 00                      | local.get 0
 0004f8: fd 19 00                   | i16x8.extract_lane_u 0
 0004fb: 20 01                      | local.get 1
 0004fd: fd 19 00                   | i16x8.extract_lane_u 0
 000500: 6e                         | i32.div_u
 000501: fd 10                      | i16x8.splat
 000503: 20 00                      | local.get 0
 000505: fd 19 01                   | i16x8.extract_lane_u 1
 000508: 20 01                      | local.get 1
 00050a: fd 19 01                   | i16x8.extract_lane_u 1
 00050d: 6e                         | i32.div_u
 00050e: fd 1a 01                   | i16x8.replace_lane 1
 000511: 20 00                      | local.get 0
 000513: fd 19 02                   | i16x8.extract_lane_u 2
 000516: 20 01                      | local.get 1
 000518: fd 19 02                   | i16x8.extract_lane_u 2
 00051b: 6e                         | i32.div_u
 00051c: fd 1a 02                   | i16x8.replace_lane 2
 00051f: 20 00                      | local.get 0
 000521: fd 19 03                   | i16x8.extract_lane_u 3
 000524: 20 01                      | local.get 1
 000526: fd 19 03                   | i16x8.extract_lane_u 3
 000529: 6e                         | i32.div_u
 00052a: fd 1a 03                   | i16x8.replace_lane 3
 00052d: 20 00                      | local.get 0
 00052f: fd 19 04                   | i16x8.extract_lane_u 4
 000532: 20 01                      | local.get 1
 000534: fd 19 04                   | i16x8.extract_lane_u 4
 000537: 6e                         | i32.div_u
 000538: fd 1a 04                   | i16x8.replace_lane 4
 00053b: 20 00                      | local.get 0
 00053d: fd 19 05                   | i16x8.extract_lane_u 5
 000540: 20 01                      | local.get 1
 000542: fd 19 05                   | i16x8.extract_lane_u 5
 000545: 6e                         | i32.div_u
 000546: fd 1a 05                   | i16x8.replace_lane 5
 000549: 20 00                      | local.get 0
 00054b: fd 19 06                   | i16x8.extract_lane_u 6
 00054e: 20 01                      | local.get 1
 000550: fd 19 06                   | i16x8.extract_lane_u 6
 000553: 6e                         | i32.div_u
 000554: fd 1a 06                   | i16x8.replace_lane 6
 000557: 20 00                      | local.get 0
 000559: fd 19 07                   | i16x8.extract_lane_u 7
 00055c: 20 01                      | local.get 1
 00055e: fd 19 07                   | i16x8.extract_lane_u 7
 000561: 6e                         | i32.div_u
 000562: fd 1a 07                   | i16x8.replace_lane 7
 000565: 0b                         | end
000567 func[20] <neg_i32x4>:
 000568: 20 00                      | local.get 0
 00056a: fd a1 01                   | i32x4.neg
 00056d: 0b                         | end
00056f func[21] <add_i32x4>:
 000570: 20 01                      | local.get 1
 000572: 20 00                      | local.get 0
 000574: fd ae 01                   | i32x4.add
 000577: 0b                         | end
000579 func[22] <sub_i32x4>:
 00057a: 20 00                      | local.get 0
 00057c: 20 01                      | local.get 1
 00057e: fd b1 01                   | i32x4.sub
 000581: 0b                         | end
000583 func[23] <mul_i32x4>:
 000584: 20 01                      | local.get 1
 000586: 20 00                      | local.get 0
 000588: fd b5 01                   | i32x4.mul
 00058b: 0b                         | end
00058d func[24] <div_i32x4>:
 00058e: 20 00                      | local.get 0
 000590: fd 1b 00                   | i32x4.extract_lane 0
 000593: 20 01                      | local.get 1
 000595: fd 1b 00                   | i32x4.extract_lane 0
 000598: 6d                         | i32.div_s
 000599: fd 11                      | i32x4.splat
 00059b: 20 00                      | local.get 0
 00059d: fd 1b 01                   | i32x4.extract_lane 1
 0005a0: 20 01                      | local.get 1
 0005a2: fd 1b 01                   | i32x4.extract_lane 1
 0005a5: 6d                         | i32.div_s
 0005a6: fd 1c 01                   | i32x4.replace_lane 1
 0005a9: 20 00                      | local.get 0
 0005ab: fd 1b 02                   | i32x4.extract_lane 2
 0005ae: 20 01                      | local.get 1
 0005b0: fd 1b 02                   | i32x4.extract_lane 2
 0005b3: 6d                         | i32.div_s
 0005b4: fd 1c 02                   | i32x4.replace_lane 2
 0005b7: 20 00                      | local.get 0
 0005b9: fd 1b 03                   | i32x4.extract_lane 3
 0005bc: 20 01                      | local.get 1
 0005be: fd 1b 03                   | i32x4.extract_lane 3
 0005c1: 6d                         | i32.div_s
 0005c2: fd 1c 03                   | i32x4.replace_lane 3
 0005c5: 0b                         | end
0005c7 func[25] <neg_u32x4>:
 0005c8: 20 00                      | local.get 0
 0005ca: fd a1 01                   | i32x4.neg
 0005cd: 0b                         | end
0005cf func[26] <add_u32x4>:
 0005d0: 20 01                      | local.get 1
 0005d2: 20 00                      | local.get 0
 0005d4: fd ae 01                   | i32x4.add
 0005d7: 0b                         | end
0005d9 func[27] <sub_u32x4>:
 0005da: 20 00                      | local.get 0
 0005dc: 20 01                      | local.get 1
 0005de: fd b1 01                   | i32x4.sub
 0005e1: 0b                         | end
0005e3 func[28] <mul_u32x4>:
 0005e4: 20 01                      | local.get 1
 0005e6: 20 00                      | local.get 0
 0005e8: fd b5 01                   | i32x4.mul
 0005eb: 0b                         | end
0005ed func[29] <div_u32x4>:
 0005ee: 20 00                      | local.get 0
 0005f0: fd 1b 00                   | i32x4.extract_lane 0
 0005f3: 20 01                      | local.get 1
 0005f5: fd 1b 00                   | i32x4.extract_lane 0
 0005f8: 6e                         | i32.div_u
 0005f9: fd 11                      | i32x4.splat
 0005fb: 20 00                      | local.get 0
 0005fd: fd 1b 01                   | i32x4.extract_lane 1
 000600: 20 01                      | local.get 1
 000602: fd 1b 01                   | i32x4.extract_lane 1
 000605: 6e                         | i32.div_u
 000606: fd 1c 01                   | i32x4.replace_lane 1
 000609: 20 00                      | local.get 0
 00060b: fd 1b 02                   | i32x4.extract_lane 2
 00060e: 20 01                      | local.get 1
 000610: fd 1b 02                   | i32x4.extract_lane 2
 000613: 6e                         | i32.div_u
 000614: fd 1c 02                   | i32x4.replace_lane 2
 000617: 20 00                      | local.get 0
 000619: fd 1b 03                   | i32x4.extract_lane 3
 00061c: 20 01                      | local.get 1
 00061e: fd 1b 03                   | i32x4.extract_lane 3
 000621: 6e                         | i32.div_u
 000622: fd 1c 03                   | i32x4.replace_lane 3
 000625: 0b                         | end
000627 func[30] <neg_i64x2>:
 000628: 20 00                      | local.get 0
 00062a: fd c1 01                   | i64x2.neg
 00062d: 0b                         | end
00062f func[31] <add_i64x2>:
 000630: 20 01                      | local.get 1
 000632: 20 00                      | local.get 0
 000634: fd ce 01                   | i64x2.add
 000637: 0b                         | end
000639 func[32] <sub_i64x2>:
 00063a: 20 00                      | local.get 0
 00063c: 20 01                      | local.get 1
 00063e: fd d1 01                   | i64x2.sub
 000641: 0b                         | end
000643 func[33] <mul_i64x2>:
 000644: 20 01                      | local.get 1
 000646: 20 00                      | local.get 0
 000648: fd d5 01                   | i64x2.mul
 00064b: 0b                         | end
00064d func[34] <div_i64x2>:
 00064e: 20 00                      | local.get 0
 000650: fd 1d 00                   | i64x2.extract_lane 0
 000653: 20 01                      | local.get 1
 000655: fd 1d 00                   | i64x2.extract_lane 0
 000658: 7f                         | i64.div_s
 000659: fd 12                      | i64x2.splat
 00065b: 20 00                      | local.get 0
 00065d: fd 1d 01                   | i64x2.extract_lane 1
 000660: 20 01                      | local.get 1
 000662: fd 1d 01                   | i64x2.extract_lane 1
 000665: 7f                         | i64.div_s
 000666: fd 1e 01                   | i64x2.replace_lane 1
 000669: 0b                         | end
00066b func[35] <neg_u64x2>:
 00066c: 20 00                      | local.get 0
 00066e: fd c1 01                   | i64x2.neg
 000671: 0b                         | end
000673 func[36] <add_u64x2>:
 000674: 20 01                      | local.get 1
 000676: 20 00                      | local.get 0
 000678: fd ce 01                   | i64x2.add
 00067b: 0b                         | end
00067d func[37] <sub_u64x2>:
 00067e: 20 00                      | local.get 0
 000680: 20 01                      | local.get 1
 000682: fd d1 01                   | i64x2.sub
 000685: 0b                         | end
000687 func[38] <mul_u64x2>:
 000688: 20 01                      | local.get 1
 00068a: 20 00                      | local.get 0
 00068c: fd d5 01                   | i64x2.mul
 00068f: 0b                         | end
000691 func[39] <div_u64x2>:
 000692: 20 00                      | local.get 0
 000694: fd 1d 00                   | i64x2.extract_lane 0
 000697: 20 01                      | local.get 1
 000699: fd 1d 00                   | i64x2.extract_lane 0
 00069c: 80                         | i64.div_u
 00069d: fd 12                      | i64x2.splat
 00069f: 20 00                      | local.get 0
 0006a1: fd 1d 01                   | i64x2.extract_lane 1
 0006a4: 20 01                      | local.get 1
 0006a6: fd 1d 01                   | i64x2.extract_lane 1
 0006a9: 80                         | i64.div_u
 0006aa: fd 1e 01                   | i64x2.replace_lane 1
 0006ad: 0b                         | end
0006af func[40] <neg_f32x4>:
 0006b0: 20 00                      | local.get 0
 0006b2: fd e1 01                   | f32x4.neg
 0006b5: 0b                         | end
0006b7 func[41] <add_f32x4>:
 0006b8: 20 00                      | local.get 0
 0006ba: 20 01                      | local.get 1
 0006bc: fd e4 01                   | f32x4.add
 0006bf: 0b                         | end
0006c1 func[42] <sub_f32x4>:
 0006c2: 20 00                      | local.get 0
 0006c4: 20 01                      | local.get 1
 0006c6: fd e5 01                   | f32x4.sub
 0006c9: 0b                         | end
0006cb func[43] <mul_f32x4>:
 0006cc: 20 00                      | local.get 0
 0006ce: 20 01                      | local.get 1
 0006d0: fd e6 01                   | f32x4.mul
 0006d3: 0b                         | end
0006d5 func[44] <div_f32x4>:
 0006d6: 20 00                      | local.get 0
 0006d8: 20 01                      | local.get 1
 0006da: fd e7 01                   | f32x4.div
 0006dd: 0b                         | end
0006df func[45] <neg_f64x2>:
 0006e0: 20 00                      | local.get 0
 0006e2: fd ed 01                   | f64x2.neg
 0006e5: 0b                         | end
0006e7 func[46] <add_f64x2>:
 0006e8: 20 00                      | local.get 0
 0006ea: 20 01                      | local.get 1
 0006ec: fd f0 01                   | f64x2.add
 0006ef: 0b                         | end
0006f1 func[47] <sub_f64x2>:
 0006f2: 20 00                      | local.get 0
 0006f4: 20 01                      | local.get 1
 0006f6: fd f1 01                   | f64x2.sub
 0006f9: 0b                         | end
0006fb func[48] <mul_f64x2>:
 0006fc: 20 00                      | local.get 0
 0006fe: 20 01                      | local.get 1
 000700: fd f2 01                   | f64x2.mul
 000703: 0b                         | end
000705 func[49] <div_f64x2>:
 000706: 20 00                      | local.get 0
 000708: 20 01                      | local.get 1
 00070a: fd f3 01                   | f64x2.div
 00070d: 0b                         | end
