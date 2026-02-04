
condition_5.wasm:	file format wasm 0x1

Code Disassembly:

000056 func[2] <foo>:
 000057: 02 40                      | block
 000059: 20 00                      |   local.get 0
 00005b: 43 00 00 28 42             |   f32.const 0x1.5p+5
 000060: 5d                         |   f32.lt
 000061: 45                         |   i32.eqz
 000062: 0d 00                      |   br_if 0
 000064: 20 00                      |   local.get 0
 000066: 10 80 80 80 80 00          |   call 0 <env.bar>
 00006c: 0f                         |   return
 00006d: 0b                         | end
 00006e: 20 00                      | local.get 0
 000070: 10 81 80 80 80 00          | call 1 <env.baz>
 000076: 0b                         | end
