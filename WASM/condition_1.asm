
condition_1.wasm:	file format wasm 0x1

Code Disassembly:

000042 func[0] <foo>:
 000043: 41 01                      | i32.const 1
 000045: 41 02                      | i32.const 2
 000047: 20 00                      | local.get 0
 000049: 41 0a                      | i32.const 10
 00004b: 48                         | i32.lt_s
 00004c: 1b                         | select
 00004d: 0b                         | end
