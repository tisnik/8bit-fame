
loop_1.wasm:	file format wasm 0x1

Code Disassembly:

00004e func[1] <loop>:
 00004f: 01 7f                      | local[0] type=i32
 000051: 41 0a                      | i32.const 10
 000053: 21 00                      | local.set 0
 000055: 03 40                      | loop
 000057: 10 80 80 80 80 00          |   call 0 <env.foo>
 00005d: 1a                         |   drop
 00005e: 20 00                      |   local.get 0
 000060: 41 7f                      |   i32.const 4294967295
 000062: 6a                         |   i32.add
 000063: 22 00                      |   local.tee 0
 000065: 0d 00                      |   br_if 0
 000067: 0b                         | end
 000068: 0b                         | end
