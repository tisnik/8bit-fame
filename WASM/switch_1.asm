
switch_1.wasm:	file format wasm 0x1

Code Disassembly:

00006c func[4] <numeric_value>:
 00006d: 02 40                      | block
 00006f: 02 40                      |   block
 000071: 02 40                      |     block
 000073: 02 40                      |       block
 000075: 02 40                      |         block
 000077: 20 00                      |           local.get 0
 000079: 0e 04 00 01 02 03 04       |           br_table 0 1 2 3 4
 000080: 0b                         |         end
 000081: 10 80 80 80 80 00          |         call 0 <env.foo>
 000087: 0f                         |         return
 000088: 0b                         |       end
 000089: 10 81 80 80 80 00          |       call 1 <env.bar>
 00008f: 0f                         |       return
 000090: 0b                         |     end
 000091: 10 82 80 80 80 00          |     call 2 <env.baz>
 000097: 0f                         |     return
 000098: 0b                         |   end
 000099: 10 83 80 80 80 00          |   call 3 <env.bzz>
 00009f: 0b                         | end
 0000a0: 0b                         | end
