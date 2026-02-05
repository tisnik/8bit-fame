
loop_2.wasm:	file format wasm 0x1

Code Disassembly:

00004f func[1] <loop>:
 000050: 01 7f                      | local[1] type=i32
 000052: 41 00                      | i32.const 0
 000054: 21 00                      | local.set 0
 000056: 03 40                      | loop
 000058: 20 00                      |   local.get 0
 00005a: 10 80 80 80 80 00          |   call 0 <env.foo>
 000060: 1a                         |   drop
 000061: 20 00                      |   local.get 0
 000063: 41 01                      |   i32.const 1
 000065: 6a                         |   i32.add
 000066: 22 00                      |   local.tee 0
 000068: 41 0a                      |   i32.const 10
 00006a: 47                         |   i32.ne
 00006b: 0d 00                      |   br_if 0
 00006d: 0b                         | end
 00006e: 0b                         | end
