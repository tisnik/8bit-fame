
condition_4.wasm:	file format wasm 0x1

Code Disassembly:

000056 func[2] <foo>:
 000057: 02 40                      | block
 000059: 20 00                      |   local.get 0
 00005b: 41 29                      |   i32.const 41
 00005d: 4a                         |   i32.gt_s
 00005e: 0d 00                      |   br_if 0
 000060: 20 00                      |   local.get 0
 000062: 10 80 80 80 80 00          |   call 0 <env.bar>
 000068: 0f                         |   return
 000069: 0b                         | end
 00006a: 20 00                      | local.get 0
 00006c: 10 81 80 80 80 00          | call 1 <env.baz>
 000072: 0b                         | end
