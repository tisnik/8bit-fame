
condition_2.wasm:	file format wasm 0x1

Code Disassembly:

000042 func[0] <foo>:
 000043: 20 00                      | local.get 0
 000045: 41 01                      | i32.const 1
 000047: 6a                         | i32.add
 000048: 20 00                      | local.get 0
 00004a: 41 03                      | i32.const 3
 00004c: 6c                         | i32.mul
 00004d: 20 00                      | local.get 0
 00004f: 41 0a                      | i32.const 10
 000051: 48                         | i32.lt_s
 000052: 1b                         | select
 000053: 0b                         | end
