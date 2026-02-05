
loop_3.wasm:	file format wasm 0x1

Code Disassembly:

000042 func[0] <loop>:
 000043: 01 7f                      | local[1] type=i32
 000045: 41 0a                      | i32.const 10
 000047: 21 01                      | local.set 1
 000049: 03 40                      | loop
 00004b: 20 00                      |   local.get 0
 00004d: 41 2a                      |   i32.const 42
 00004f: 6c                         |   i32.mul
 000050: 21 00                      |   local.set 0
 000052: 20 01                      |   local.get 1
 000054: 41 7f                      |   i32.const 4294967295
 000056: 6a                         |   i32.add
 000057: 22 01                      |   local.tee 1
 000059: 0d 00                      |   br_if 0
 00005b: 0b                         | end
 00005c: 20 00                      | local.get 0
 00005e: 0b                         | end
