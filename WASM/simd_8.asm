
simd_8.wasm:	file format wasm 0x1

Code Disassembly:

000045 func[0] <add_f16x8>:
 000046: 20 01                      | local.get 1
 000048: 20 00                      | local.get 0
 00004a: fd 8e 01                   | i16x8.add
 00004d: 0b                         | end
00004f func[1] <add_f32x4>:
 000050: 20 00                      | local.get 0
 000052: 20 01                      | local.get 1
 000054: fd e4 01                   | f32x4.add
 000057: 0b                         | end
000059 func[2] <add_f64x2>:
 00005a: 20 00                      | local.get 0
 00005c: 20 01                      | local.get 1
 00005e: fd f0 01                   | f64x2.add
 000061: 0b                         | end
