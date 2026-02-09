
switch_2.wasm:	file format wasm 0x1

Code Disassembly:

00006c func[4] <numeric_value>:
 00006d: 02 40                      | block
 00006f: 02 40                      |   block
 000071: 02 40                      |     block
 000073: 02 40                      |       block
 000075: 20 00                      |         local.get 0
 000077: 0e 03 00 01 02 03          |         br_table 0 1 2 3
 00007d: 0b                         |       end
 00007e: 10 80 80 80 80 00          |       call 0 <env.foo>
 000084: 0f                         |       return
 000085: 0b                         |     end
 000086: 10 81 80 80 80 00          |     call 1 <env.bar>
 00008c: 0f                         |     return
 00008d: 0b                         |   end
 00008e: 10 82 80 80 80 00          |   call 2 <env.baz>
 000094: 0f                         |   return
 000095: 0b                         | end
 000096: 10 83 80 80 80 00          | call 3 <env.bzz>
 00009c: 0b                         | end
