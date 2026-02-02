arith_4.wasm:	file format wasm 0x1

Code Disassembly:

00004d func[0] <fadd>:
 00004e: 20 00                      | local.get 0
 000050: 20 01                      | local.get 1
 000052: a0                         | f64.add
 000053: 0b                         | end
000055 func[1] <fsub>:
 000056: 20 00                      | local.get 0
 000058: 20 01                      | local.get 1
 00005a: a1                         | f64.sub
 00005b: 0b                         | end
00005d func[2] <fmul>:
 00005e: 20 00                      | local.get 0
 000060: 20 01                      | local.get 1
 000062: a2                         | f64.mul
 000063: 0b                         | end
000065 func[3] <fdiv>:
 000066: 20 00                      | local.get 0
 000068: 20 01                      | local.get 1
 00006a: a3                         | f64.div
 00006b: 0b                         | end
00006d func[4] <fsqrt>:
 00006e: 20 00                      | local.get 0
 000070: 9f                         | f64.sqrt
 000071: 0b                         | end
000073 func[5] <fabs_>:
 000074: 20 00                      | local.get 0
 000076: 99                         | f64.abs
 000077: 0b                         | end
