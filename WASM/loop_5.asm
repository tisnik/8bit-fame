
loop_5.wasm:	file format wasm 0x1

Code Disassembly:

000050 func[1] <nested_loops>:
 000051: 01 7c                      | local[1] type=f64
 000053: 02 7f                      | local[2..3] type=i32
 000055: 01 7c                      | local[4] type=f64
 000057: 44 00 00 00 00 00 00 f0 3f | f64.const 0x1p+0
 000060: 21 00                      | local.set 0
 000062: 41 01                      | i32.const 1
 000064: 21 01                      | local.set 1
 000066: 03 40                      | loop
 000068: 41 0a                      |   i32.const 10
 00006a: 21 02                      |   local.set 2
 00006c: 44 00 00 00 00 00 00 f0 3f |   f64.const 0x1p+0
 000075: 21 03                      |   local.set 3
 000077: 03 40                      |   loop
 000079: 20 00                      |     local.get 0
 00007b: 20 03                      |     local.get 3
 00007d: a2                         |     f64.mul
 00007e: 10 80 80 80 80 00          |     call 0 <env.print>
 000084: 20 03                      |     local.get 3
 000086: 44 00 00 00 00 00 00 f0 3f |     f64.const 0x1p+0
 00008f: a0                         |     f64.add
 000090: 21 03                      |     local.set 3
 000092: 20 02                      |     local.get 2
 000094: 41 7f                      |     i32.const 4294967295
 000096: 6a                         |     i32.add
 000097: 22 02                      |     local.tee 2
 000099: 0d 00                      |     br_if 0
 00009b: 0b                         |   end
 00009c: 20 00                      |   local.get 0
 00009e: 44 00 00 00 00 00 00 f0 3f |   f64.const 0x1p+0
 0000a7: a0                         |   f64.add
 0000a8: 21 00                      |   local.set 0
 0000aa: 20 01                      |   local.get 1
 0000ac: 41 01                      |   i32.const 1
 0000ae: 6a                         |   i32.add
 0000af: 22 01                      |   local.tee 1
 0000b1: 41 0b                      |   i32.const 11
 0000b3: 47                         |   i32.ne
 0000b4: 0d 00                      |   br_if 0
 0000b6: 0b                         | end
 0000b7: 0b                         | end
