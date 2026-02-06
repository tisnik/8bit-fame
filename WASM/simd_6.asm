
simd_6.wasm:	file format wasm 0x1

Code Disassembly:

000045 func[0] <add>:
 000046: 20 00                      | local.get 0
 000048: 20 04                      | local.get 4
 00004a: 20 02                      | local.get 2
 00004c: fd 6e                      | i8x16.add
 00004e: fd 0b 04 10                | v128.store 4 16
 000052: 20 00                      | local.get 0
 000054: 20 03                      | local.get 3
 000056: 20 01                      | local.get 1
 000058: fd 6e                      | i8x16.add
 00005a: fd 0b 04 00                | v128.store 4 0
 00005e: 0b                         | end
