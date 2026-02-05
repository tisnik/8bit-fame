
conversions_4.wasm:	file format wasm 0x1

Code Disassembly:

000048 func[0] <from_float>:
 000049: 20 00                      | local.get 0
 00004b: bb                         | f64.promote_f32
 00004c: 0b                         | end
00004e func[1] <to_float>:
 00004f: 20 00                      | local.get 0
 000051: b6                         | f32.demote_f64
 000052: 0b                         | end
