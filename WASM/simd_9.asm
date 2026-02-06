
simd_9.wasm:	file format wasm 0x1

Code Disassembly:

00004c func[0] <neg>:
 00004d: 20 00                      | local.get 0
 00004f: fd a1 01                   | i32x4.neg
 000052: 0b                         | end
000054 func[1] <add>:
 000055: 20 01                      | local.get 1
 000057: 20 00                      | local.get 0
 000059: fd ae 01                   | i32x4.add
 00005c: 0b                         | end
00005e func[2] <sub>:
 00005f: 20 00                      | local.get 0
 000061: 20 01                      | local.get 1
 000063: fd b1 01                   | i32x4.sub
 000066: 0b                         | end
000068 func[3] <mul>:
 000069: 20 01                      | local.get 1
 00006b: 20 00                      | local.get 0
 00006d: fd b5 01                   | i32x4.mul
 000070: 0b                         | end
000072 func[4] <div>:
 000073: 20 00                      | local.get 0
 000075: fd 1b 00                   | i32x4.extract_lane 0
 000078: 20 01                      | local.get 1
 00007a: fd 1b 00                   | i32x4.extract_lane 0
 00007d: 6e                         | i32.div_u
 00007e: fd 11                      | i32x4.splat
 000080: 20 00                      | local.get 0
 000082: fd 1b 01                   | i32x4.extract_lane 1
 000085: 20 01                      | local.get 1
 000087: fd 1b 01                   | i32x4.extract_lane 1
 00008a: 6e                         | i32.div_u
 00008b: fd 1c 01                   | i32x4.replace_lane 1
 00008e: 20 00                      | local.get 0
 000090: fd 1b 02                   | i32x4.extract_lane 2
 000093: 20 01                      | local.get 1
 000095: fd 1b 02                   | i32x4.extract_lane 2
 000098: 6e                         | i32.div_u
 000099: fd 1c 02                   | i32x4.replace_lane 2
 00009c: 20 00                      | local.get 0
 00009e: fd 1b 03                   | i32x4.extract_lane 3
 0000a1: 20 01                      | local.get 1
 0000a3: fd 1b 03                   | i32x4.extract_lane 3
 0000a6: 6e                         | i32.div_u
 0000a7: fd 1c 03                   | i32x4.replace_lane 3
 0000aa: 0b                         | end
