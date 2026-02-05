
loop_4.wasm:	file format wasm 0x1

Code Disassembly:

000050 func[1] <nested_loops>:
 000051: 03 7f                      | local[1..3] type=i32
 000053: 41 01                      | i32.const 1
 000055: 21 00                      | local.set 0
 000057: 03 40                      | loop
 000059: 41 0a                      |   i32.const 10
 00005b: 21 01                      |   local.set 1
 00005d: 20 00                      |   local.get 0
 00005f: 21 02                      |   local.set 2
 000061: 03 40                      |   loop
 000063: 20 02                      |     local.get 2
 000065: 10 80 80 80 80 00          |     call 0 <env.print>
 00006b: 20 02                      |     local.get 2
 00006d: 20 00                      |     local.get 0
 00006f: 6a                         |     i32.add
 000070: 21 02                      |     local.set 2
 000072: 20 01                      |     local.get 1
 000074: 41 7f                      |     i32.const 4294967295
 000076: 6a                         |     i32.add
 000077: 22 01                      |     local.tee 1
 000079: 0d 00                      |     br_if 0
 00007b: 0b                         |   end
 00007c: 20 00                      |   local.get 0
 00007e: 41 01                      |   i32.const 1
 000080: 6a                         |   i32.add
 000081: 22 00                      |   local.tee 0
 000083: 41 0b                      |   i32.const 11
 000085: 47                         |   i32.ne
 000086: 0d 00                      |   br_if 0
 000088: 0b                         | end
 000089: 0b                         | end
