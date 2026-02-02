arith_1.wasm:	file format wasm 0x1

Code Disassembly:

00004c func[0] <iadd>:
 00004d: 20 01                      | local.get 1
 00004f: 20 00                      | local.get 0
 000051: 6a                         | i32.add
 000052: 0b                         | end
000054 func[1] <isub>:
 000055: 20 00                      | local.get 0
 000057: 20 01                      | local.get 1
 000059: 6b                         | i32.sub
 00005a: 0b                         | end
00005c func[2] <imul>:
 00005d: 20 01                      | local.get 1
 00005f: 20 00                      | local.get 0
 000061: 6c                         | i32.mul
 000062: 0b                         | end
000064 func[3] <idiv>:
 000065: 20 00                      | local.get 0
 000067: 20 01                      | local.get 1
 000069: 6d                         | i32.div_s
 00006a: 0b                         | end
00006c func[4] <imod>:
 00006d: 20 00                      | local.get 0
 00006f: 20 01                      | local.get 1
 000071: 6f                         | i32.rem_s
 000072: 0b                         | end
000074 func[5] <uadd>:
 000075: 20 01                      | local.get 1
 000077: 20 00                      | local.get 0
 000079: 6a                         | i32.add
 00007a: 0b                         | end
00007c func[6] <usub>:
 00007d: 20 00                      | local.get 0
 00007f: 20 01                      | local.get 1
 000081: 6b                         | i32.sub
 000082: 0b                         | end
000084 func[7] <umul>:
 000085: 20 01                      | local.get 1
 000087: 20 00                      | local.get 0
 000089: 6c                         | i32.mul
 00008a: 0b                         | end
00008c func[8] <udiv>:
 00008d: 20 00                      | local.get 0
 00008f: 20 01                      | local.get 1
 000091: 6e                         | i32.div_u
 000092: 0b                         | end
000094 func[9] <umod>:
 000095: 20 00                      | local.get 0
 000097: 20 01                      | local.get 1
 000099: 70                         | i32.rem_u
 00009a: 0b                         | end
