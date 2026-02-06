
simd_F.wasm:	file format wasm 0x1

Code Disassembly:

000043 func[0] <vector_sqrt_f32x4>:
 000044: 20 00                      | local.get 0
 000046: fd e3 01                   | f32x4.sqrt
 000049: 0b                         | end
00004b func[1] <vector_sqrt_f64x2>:
 00004c: 20 00                      | local.get 0
 00004e: fd ef 01                   | f64x2.sqrt
 000051: 0b                         | end
