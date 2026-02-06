
simd_E.wasm:	file format wasm 0x1

Code Disassembly:

00004a func[0] <dot_float>:
 00004b: 20 00                      | local.get 0
 00004d: fd 1f 03                   | f32x4.extract_lane 3
 000050: 20 01                      | local.get 1
 000052: fd 1f 03                   | f32x4.extract_lane 3
 000055: 94                         | f32.mul
 000056: 20 00                      | local.get 0
 000058: fd 1f 02                   | f32x4.extract_lane 2
 00005b: 20 01                      | local.get 1
 00005d: fd 1f 02                   | f32x4.extract_lane 2
 000060: 94                         | f32.mul
 000061: 20 00                      | local.get 0
 000063: fd 1f 00                   | f32x4.extract_lane 0
 000066: 20 01                      | local.get 1
 000068: fd 1f 00                   | f32x4.extract_lane 0
 00006b: 94                         | f32.mul
 00006c: 20 00                      | local.get 0
 00006e: 20 01                      | local.get 1
 000070: fd e6 01                   | f32x4.mul
 000073: fd 1f 01                   | f32x4.extract_lane 1
 000076: 92                         | f32.add
 000077: 92                         | f32.add
 000078: 92                         | f32.add
 000079: 0b                         | end
00007b func[1] <dot_double>:
 00007c: 20 00                      | local.get 0
 00007e: fd 21 00                   | f64x2.extract_lane 0
 000081: 20 01                      | local.get 1
 000083: fd 21 00                   | f64x2.extract_lane 0
 000086: a2                         | f64.mul
 000087: 20 00                      | local.get 0
 000089: 20 01                      | local.get 1
 00008b: fd f2 01                   | f64x2.mul
 00008e: fd 21 01                   | f64x2.extract_lane 1
 000091: a0                         | f64.add
 000092: 0b                         | end
