
comparison_5.wasm:	file format wasm 0x1

Code Disassembly:

000048 func[0] <eq>:
 000049: 20 00                      | local.get 0
 00004b: 20 01                      | local.get 1
 00004d: 5b                         | f32.eq
 00004e: 0b                         | end
000050 func[1] <ne>:
 000051: 20 00                      | local.get 0
 000053: 20 01                      | local.get 1
 000055: 5c                         | f32.ne
 000056: 0b                         | end
000058 func[2] <lt>:
 000059: 20 00                      | local.get 0
 00005b: 20 01                      | local.get 1
 00005d: 5d                         | f32.lt
 00005e: 0b                         | end
000060 func[3] <le>:
 000061: 20 00                      | local.get 0
 000063: 20 01                      | local.get 1
 000065: 5f                         | f32.le
 000066: 0b                         | end
000068 func[4] <gt>:
 000069: 20 00                      | local.get 0
 00006b: 20 01                      | local.get 1
 00006d: 5e                         | f32.gt
 00006e: 0b                         | end
000070 func[5] <ge>:
 000071: 20 00                      | local.get 0
 000073: 20 01                      | local.get 1
 000075: 60                         | f32.ge
 000076: 0b                         | end
