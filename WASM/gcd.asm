gcd.wasm:	file format wasm 0x1

Code Disassembly:

000043 func[0] <gcd>:
 000044: 01 7f                      | local[2] type=i32
 000046: 02 40                      | block
 000048: 20 01                      |   local.get 1
 00004a: 0d 00                      |   br_if 0
 00004c: 20 00                      |   local.get 0
 00004e: 0f                         |   return
 00004f: 0b                         | end
 000050: 03 40                      | loop
 000052: 20 00                      |   local.get 0
 000054: 20 01                      |   local.get 1
 000056: 22 02                      |   local.tee 2
 000058: 6f                         |   i32.rem_s
 000059: 21 01                      |   local.set 1
 00005b: 20 02                      |   local.get 2
 00005d: 21 00                      |   local.set 0
 00005f: 20 01                      |   local.get 1
 000061: 0d 00                      |   br_if 0
 000063: 0b                         | end
 000064: 20 02                      | local.get 2
 000066: 0b                         | end
