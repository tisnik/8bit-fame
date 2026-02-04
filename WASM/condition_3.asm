
condition_3.wasm:	file format wasm 0x1

Code Disassembly:

000042 func[0] <foo>:
 000043: 20 00                      | local.get 0
 000045: 43 00 00 80 3f             | f32.const 0x1p+0
 00004a: 92                         | f32.add
 00004b: 20 00                      | local.get 0
 00004d: 43 00 00 40 40             | f32.const 0x1.8p+1
 000052: 94                         | f32.mul
 000053: 20 00                      | local.get 0
 000055: 43 00 00 20 41             | f32.const 0x1.4p+3
 00005a: 5d                         | f32.lt
 00005b: 1b                         | select
 00005c: 0b                         | end
