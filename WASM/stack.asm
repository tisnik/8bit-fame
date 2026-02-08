stack.wasm:	file format wasm 0x1

Code Disassembly:

000058 func[1] <return_constant>:
 000059: 41 2a                      | i32.const 42
 00005b: 0b                         | end
00005d func[2] <call_x>:
 00005e: 20 00                      | local.get 0
 000060: 10 80 80 80 80 00          | call 0 <env.x>
 000066: 0b                         | end
000068 func[3] <first>:
 000069: 20 00                      | local.get 0
 00006b: 0b                         | end
00006d func[4] <second>:
 00006e: 20 01                      | local.get 1
 000070: 0b                         | end
000072 func[5] <try_return>:
 000073: 41 2a                      | i32.const 42
 000075: 41 8f ce 00                | i32.const 9999
 000079: 20 00                      | local.get 0
 00007b: 41 00                      | i32.const 0
 00007d: 48                         | i32.lt_s
 00007e: 1b                         | select
 00007f: 0b                         | end
