arith_3.wasm:	file format wasm 0x1

Code Disassembly:

00004d func[0] <fadd>:
 00004e: 20 00                      | local.get 0
 000050: 20 01                      | local.get 1
 000052: 92                         | f32.add
 000053: 0b                         | end
000055 func[1] <fsub>:
 000056: 20 00                      | local.get 0
 000058: 20 01                      | local.get 1
 00005a: 93                         | f32.sub
 00005b: 0b                         | end
00005d func[2] <fmul>:
 00005e: 20 00                      | local.get 0
 000060: 20 01                      | local.get 1
 000062: 94                         | f32.mul
 000063: 0b                         | end
000065 func[3] <fdiv>:
 000066: 20 00                      | local.get 0
 000068: 20 01                      | local.get 1
 00006a: 95                         | f32.div
 00006b: 0b                         | end
00006d func[4] <fsqrt>:
 00006e: 20 00                      | local.get 0
 000070: 91                         | f32.sqrt
 000071: 0b                         | end
000073 func[5] <fabs>:
 000074: 20 00                      | local.get 0
 000076: 8b                         | f32.abs
 000077: 0b                         | end
