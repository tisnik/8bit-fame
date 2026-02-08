
goto_1.wasm:	file format wasm 0x1

Code Disassembly:

000079 func[3] <bar>:
 00007a: 02 40                      | block
 00007c: 02 40                      |   block
 00007e: 20 00                      |     local.get 0
 000080: 41 00                      |     i32.const 0
 000082: 4a                         |     i32.gt_s
 000083: 0d 00                      |     br_if 0
 000085: 10 80 80 80 80 00          |     call 0 <env.positive_case>
 00008b: 0c 01                      |     br 1
 00008d: 0b                         |   end
 00008e: 10 81 80 80 80 00          |   call 1 <env.negative_case>
 000094: 0b                         | end
 000095: 10 82 80 80 80 00          | call 2 <env.finish>
 00009b: 0b                         | end
