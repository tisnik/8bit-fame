0 REM ---------------------
1 REM WeakPoint V.1.0
2 REM Tisnik 2013
3 REM ---------------------
4 PRINT ""
5 PRINT "WeakPoint V.1.0"
6 PRINT "Tisnik 2013"
7 PRINT "*********************"
8 PRINT ""
9 GOSUB 10000
10 PRINT "SLIDE: ";SLIDE
11 PRINT " PREVIOUS SLIDE"
12 PRINT " NEXT SLIDE"
20 GOSUB KEYCODE
30 KEY=PEEK(754)
40 SLIDE=SLIDE-(KEY=LEFTKEY)
41 SLIDE=SLIDE+(KEY=RIGHTKEY)
50 IF SLIDE>0 THEN GOSUB SLIDE*100
60 GOTO MAINLOOP
100 REM slide # 1
101 GRAPHICS 2
102 ? #6;"SOUND CHIPS"
103 ? #6;"for"
104 ? #6;"8-бит мацхинес"
105 ? #6;""
106 ? #6;"PAVEL TISNOVSKY"
108 RETURN 
200 REM slide # 2
201 GRAPHICS 2
202 ? #6;"SOUND CHIP"
203 ? #6;""
204 ? #6;"integrated circuit"
205 ? #6;"designed to produce"
206 ? #6;"sound"
207 ? #6;""
209 RETURN 
300 REM slide # 3
301 GRAPHICS 2
302 ? #6;"SOUND CHIP"
303 ? #6;""
304 ? #6;"used in 8-bit era"
305 ? #6;""
306 ? #6;"хоме цомпутерс"
307 ? #6;"гаме цонсолес"
308 ? #6;"арцаде гамес"
310 RETURN 
400 REM slide # 4
401 GRAPHICS 2
402 ? #6;"SOUND CHIPS TYPES"
403 ? #6;""
404 ? #6;"digital"
405 ? #6;"analog"
406 ? #6;"digital+analog"
408 RETURN 
500 REM slide # 5
501 GRAPHICS 2
502 ? #6;"SOUND CHIP FAMILIES"
503 ? #6;""
504 ? #6;"psg"
505 ? #6;"fm synthesizers"
506 ? #6;"pcm (play samples)"
508 RETURN 
600 REM slide # 6
601 GRAPHICS 2
602 ? #6;"PSG"
603 ? #6;""
604 ? #6;"programmable sound"
605 ? #6;"generator"
606 ? #6;""
607 ? #6;"генератес жариоус"
608 ? #6;"соунд важес"
610 RETURN 
700 REM slide # 7
701 GRAPHICS 2
702 ? #6;"PSG"
703 ? #6;""
704 ? #6;"multiple waveforms"
705 ? #6;"сяуаре"
706 ? #6;"триангле"
707 ? #6;"ноисе генератор"
708 ? #6;"енжелопе генератор"
709 ? #6;""
710 ? #6;"filters (a or d)"
712 RETURN 
800 REM slide # 8
801 GRAPHICS 2
802 ? #6;"TRIANGLE WAVE(S)"
803 ? #6;""
804 ? #6;"only on some psgs"
805 ? #6;""
806 ? #6;"usually 4bit"
807 ? #6;"samples"
808 ? #6;"16 лежелс"
810 RETURN 
900 REM slide # 9
901 GRAPHICS 2
902 ? #6;"ENVELOPE"
903 ? #6;""
904 ? #6;"only on some psgs"
905 ? #6;""
906 ? #6;"*shaping amplitude*"
907 ? #6;"аттацк"
908 ? #6;"децаы"
909 ? #6;"сустатин"
910 ? #6;"релеасе"
912 RETURN 
1000 REM slide # 10
1001 GRAPHICS 2
1002 ? #6;"NOISE GENERATOR"
1003 ? #6;""
1004 ? #6;"on almost all psgs"
1005 ? #6;""
1006 ? #6;"based on lfsr"
1007 ? #6;"линеар феедбацк"
1008 ? #6;"схифт регистер"
1009 ? #6;""
1010 ? #6;"a.k.a."
1011 ? #6;"полы цоунтер"
1013 RETURN 
1100 REM slide # 11
1101 GRAPHICS 2
1102 ? #6;"TYPICAL LSFRS"
1103 ? #6;""
1104 ? #6;"4 bit tia, pokey"
1105 ? #6;"5 bit tia, pokey"
1106 ? #6;"9 bit tia, pokey"
1107 ? #6;"15 bit sn76489,2a03"
1108 ? #6;"17 bit pokey"
1110 RETURN 
1200 REM slide # 12
1201 GRAPHICS 2
1202 ? #6;"LIST OF PSGS (#1)"
1203 ? #6;""
1204 ? #6;"ula pin#28 :-)"
1205 ? #6;"atari tia"
1206 ? #6;"atari pokey"
1207 ? #6;"huc6280"
1208 ? #6;"ricoh 2a03/2a07"
1210 RETURN 
1300 REM slide # 13
1301 GRAPHICS 2
1302 ? #6;"LIST OF PSGS (#1)"
1303 ? #6;""
1304 ? #6;"ay-3-8910 (ym2149)"
1305 ? #6;"ti sn76477"
1306 ? #6;"ti sn76489 (dcsg)"
1307 ? #6;"ti sn76496"
1308 ? #6;"mos sid"
1310 RETURN 
1400 REM slide # 14
1401 GRAPHICS 2
1402 ? #6;""
1403 ? #6;"*******************"
1404 ? #6;"ula pin#28"
1405 ? #6;"*******************"
1406 ? #6;""
1408 RETURN 
1500 REM slide # 15
1501 GRAPHICS 2
1502 ? #6;"ULA"
1503 ? #6;""
1504 ? #6;"zx spectrum 48k"
1505 ? #6;"one bit i/o"
1506 ? #6;"variable freq."
1507 ? #6;"can be controlled"
1508 ? #6;"by software"
1509 ? #6;"(маны трицкс)"
1511 RETURN 
1600 REM slide # 16
1601 GOSUB 20000
1604 RETURN 
1700 REM slide # 17
1701 GRAPHICS 2
1702 ? #6;""
1703 ? #6;"*******************"
1704 ? #6;"tia"
1705 ? #6;"*******************"
1706 ? #6;""
1708 RETURN 
1800 REM slide # 18
1801 GRAPHICS 2
1802 ? #6;"TIA"
1803 ? #6;""
1804 ? #6;"television"
1805 ? #6;"interface"
1806 ? #6;"adaptor"
1807 ? #6;""
1808 ? #6;"GRAPHICS AND SOUND"
1809 ? #6;"CHIP FOR ATARI 2600"
1810 ? #6;""
1811 ? #6;"jay miner"
1813 RETURN 
1900 REM slide # 19
1901 GRAPHICS 2
1902 ? #6;"TIA SOUND SUBSYSTEM"
1903 ? #6;""
1904 ? #6;"two oscillators"
1905 ? #6;"freq. dividers"
1906 ? #6;"lfsr (poly counter)"
1907 ? #6;"audio volume ctrl"
1909 RETURN 
2000 REM slide # 20
2001 GRAPHICS 2
2002 ? #6;"TIA SOUND"
2003 ? #6;""
2004 ? #6;"oscillators"
2005 ? #6;"30кхз референце"
2006 ? #6;"цлоцк сигнал"
2007 ? #6;""
2008 ? #6;"5 бит фреяуенцы"
2009 ? #6;"дижидер"
2011 RETURN 
2100 REM slide # 21
2101 GRAPHICS 2
2102 ? #6;"TIA SOUND"
2103 ? #6;""
2104 ? #6;"oscillators (cont.)"
2105 ? #6;"+ аддитионал"
2106 ? #6;"фреяуенцы дижиде"
2107 ? #6;"ис поссибле"
2108 ? #6;"/2 /6 /31 /93"
2109 ? #6;""
2110 ? #6;"(детунед нотес)"
2112 RETURN 
2200 REM slide # 22
2201 GRAPHICS 2
2202 ? #6;"TIA SOUND"
2203 ? #6;""
2204 ? #6;"sound control"
2205 ? #6;"4 бит жолуме"
2206 ? #6;"лфср цонтрол"
2208 RETURN 
2300 REM slide # 23
2301 GRAPHICS 2
2302 ? #6;"TIA LFSR"
2303 ? #6;""
2304 ? #6;"9bit lfsr with"
2305 ? #6;"selectable feedback"
2306 ? #6;"taps:"
2307 ? #6;"4bit lfsr"
2308 ? #6;"5bit lfsr"
2309 ? #6;"5+4bit lfsrs"
2311 RETURN 
2400 REM slide # 24
2401 GRAPHICS 2
2402 ? #6;""
2403 ? #6;"*******************"
2404 ? #6;"pokey"
2405 ? #6;"*******************"
2406 ? #6;""
2408 RETURN 
2500 REM slide # 25
2501 GRAPHICS 2
2502 ? #6;"POKEY"
2503 ? #6;""
2504 ? #6;"audio +"
2505 ? #6;"keyboard +"
2506 ? #6;"paddles +"
2507 ? #6;"serial i/o +"
2508 ? #6;"prng generator"
2509 ? #6;"chip"
2510 ? #6;""
2511 ? #6;"доуг неубауер"
2513 RETURN 
2600 REM slide # 26
2601 GRAPHICS 2
2602 ? #6;"POKEY"
2603 ? #6;"4 audio channels"
2604 ? #6;"цан бе цомбинед"
2605 ? #6;"селецтабле цханнелс"
2606 ? #6;"4Ь8 БИТ ЦХАННЕЛС"
2607 ? #6;"2Ь16 БИТ ЦХАННЕЛС"
2608 ? #6;"1Ь16 БИТ + 2Ь8 БИТ"
2609 ? #6;""
2610 ? #6;"digital hi-pass"
2611 ? #6;"filter"
2613 RETURN 
2700 REM slide # 27
2701 GRAPHICS 2
2702 ? #6;"POKEY"
2703 ? #6;""
2704 ? #6;"4 audio channels"
2705 ? #6;""
2706 ? #6;"each channel"
2707 ? #6;"фреяеунцы"
2708 ? #6;"жолуме"
2709 ? #6;"важеформ"
2710 ? #6;"СЯУАРЕ ВАЖЕ"
2711 ? #6;"ЛФСР НОИСЕ"
2713 RETURN 
2800 REM slide # 28
2801 GRAPHICS 2
2802 ? #6;"POKEY"
2803 ? #6;""
2804 ? #6;"noise generators"
2805 ? #6;"сампле анд холд"
2806 ? #6;""
2807 ? #6;"unique *pokey* sound"
2809 RETURN 
2900 REM slide # 29
2901 GRAPHICS 0
2902 ? "              "
2903 ? "|4 bit poly|"
2904 ? "|         |          |"
2905 ? "|         |   "
2906 ? "|         "
2907 ? "|"
2908 ? "|             "
2909 ? "| 5 bit poly |"
2910 ? "|         |            |"
2911 ? "|         |   "
2912 ? "|         "
2913 ? "|"
2914 ? "|         "
2915 ? "|    17 bit poly     |"
2916 ? "|     |                    |"
2917 ? "|     |   "
2918 ? "|     "
2919 ? "|              |"
2920 ? "vstup      prepnuti 9/17bit"
2922 RETURN 
3000 REM slide # 30
3001 GRAPHICS 0
3002 ? "            "
3003 ? "            |      |"
3004 ? "5 bit | D  Q |"
3005 ? "            |      |"
3006 ? "clock | C    |"
3007 ? "            |      |"
3008 ? "            "
3010 RETURN 
3100 REM slide # 31
3101 GRAPHICS 2
3102 ? #6;"POKEY SOUND CONTROL"
3103 ? #6;"REGISTERS"
3104 ? #6;""
3105 ? #6;"9x8 bit registers"
3106 ? #6;""
3107 ? #6;"аудф1-аудф4"
3108 ? #6;"аудц1-аудц4"
3109 ? #6;"аудцтл"
3111 RETURN 
3200 REM slide # 32
3201 GRAPHICS 2
3202 ? #6;"POKEY SOUND CONTROL"
3203 ? #6;"REGISTERS"
3204 ? #6;""
3205 ? #6;"audf1-audf4"
3206 ? #6;"фреяуенцы"
3207 ? #6;"дижидер"
3208 ? #6;"фосц/1..256"
3209 ? #6;""
3210 ? #6;"(detuned notes!)"
3212 RETURN 
3300 REM slide # 33
3301 GRAPHICS 2
3302 ? #6;"POKEY SOUND CONTROL"
3303 ? #6;"REGISTERS"
3304 ? #6;""
3305 ? #6;"audc1-audc4"
3306 ? #6;"4 бит жолуме"
3307 ? #6;"1 бит дирецт"
3308 ? #6;"цонтрол"
3310 RETURN 
3400 REM slide # 34
3401 GRAPHICS 2
3402 ? #6;"POKEY SOUND CONTROL"
3403 ? #6;"REGISTERS"
3404 ? #6;"audc1-audc4"
3405 ? #6;"3 бит лфср"
3406 ? #6;"НО ПОЛЫ"
3407 ? #6;"4 БИТ ПОЛЫ"
3408 ? #6;"5 БИТ ПОЛЫ"
3409 ? #6;"5+4"
3410 ? #6;"17 БИТ ПОЛЫ"
3411 ? #6;"5+17"
3413 RETURN 
3500 REM slide # 35
3501 GRAPHICS 2
3502 ? #6;"POKEY SOUND CONTROL"
3503 ? #6;"REGISTERS"
3504 ? #6;""
3505 ? #6;"audctl"
3506 ? #6;"join two channels"
3507 ? #6;"into 16 bit one"
3508 ? #6;""
3509 ? #6;"fosc selection"
3511 RETURN 
3600 REM slide # 36
3601 GRAPHICS 2
3602 ? #6;""
3603 ? #6;"*******************"
3604 ? #6;"AY-3-8910 (YM2149)"
3605 ? #6;"*******************"
3606 ? #6;""
3608 RETURN 
3700 REM slide # 37
3701 GRAPHICS 2
3702 ? #6;"AY-3-8910"
3703 ? #6;""
3704 ? #6;"ym 2149"
3705 ? #6;"зь спецтрум 128"
3706 ? #6;"мсь"
3707 ? #6;"жецтреь"
3708 ? #6;"атари ст"
3709 ? #6;"жидео гаме цабс."
3711 RETURN 
3800 REM slide # 38
3801 GRAPHICS 2
3802 ? #6;"THREE AY VARIANTS"
3803 ? #6;""
3804 ? #6;"ay-3-8910"
3805 ? #6;"40 пинс, 2ьи/о"
3806 ? #6;"ay-3-8912"
3807 ? #6;"28 пинс, 1ьи/о"
3808 ? #6;"ay-3-8913"
3809 ? #6;"24 пинс, но и/о"
3811 RETURN 
3900 REM slide # 39
3901 GRAPHICS 2
3902 ? #6;"AY SOUND SYNTHESIS"
3903 ? #6;""
3904 ? #6;"3 sound channels"
3905 ? #6;"separate outputs"
3906 ? #6;"square waves"
3907 ? #6;"noise generator"
3908 ? #6;"envelope generator"
3909 ? #6;"mixer"
3910 ? #6;"d/a convertor"
3912 RETURN 
4000 REM slide # 40
4001 GRAPHICS 2
4002 ? #6;"AY SQUARE WAVE GEN."
4003 ? #6;""
4004 ? #6;"12bit freq. divider"
4005 ? #6;"4bit amplitude"
4006 ? #6;"or env.generator"
4008 RETURN 
4100 REM slide # 41
4101 GRAPHICS 2
4102 ? #6;"AY NOISE GENERATOR"
4103 ? #6;""
4104 ? #6;"5bit freq. divider"
4106 RETURN 
4200 REM slide # 42
4201 GRAPHICS 2
4202 ? #6;"AY ENVELOPE GEN."
4203 ? #6;""
4204 ? #6;"16bit freq. divider"
4205 ? #6;"envelope shape"
4206 ? #6;""
4207 ? #6;"8 shapes"
4208 ? #6;"трианглес"
4209 ? #6;"савтоотх"
4210 ? #6;"аттацк онлы"
4211 ? #6;"децаы онлы"
4213 RETURN 
4300 REM slide # 43
4301 GRAPHICS 2
4302 ? #6;"AY D/A"
4303 ? #6;""
4304 ? #6;"16 levels"
4305 ? #6;"дигитал сигнал"
4306 ? #6;""
4307 ? #6;"logarithmic dac"
4309 RETURN 
4400 REM slide # 44
4401 GRAPHICS 2
4402 ? #6;""
4403 ? #6;"*******************"
4404 ? #6;"huc6280"
4405 ? #6;"*******************"
4406 ? #6;""
4408 RETURN 
4500 REM slide # 45
4501 GRAPHICS 2
4502 ? #6;""
4503 ? #6;"*******************"
4504 ? #6;"RICOH 2A03/2A07"
4505 ? #6;"*******************"
4506 ? #6;""
4508 RETURN 
4600 REM slide # 46
4601 GRAPHICS 2
4602 ? #6;"RICOH 2A03/2A07"
4603 ? #6;""
4604 ? #6;"ricoh 2a03 cpu"
4605 ? #6;"nes/gameboy"
4606 ? #6;""
4607 ? #6;"2a03 - ntsc"
4608 ? #6;"2007 - pal"
4610 RETURN 
4700 REM slide # 47
4701 GRAPHICS 2
4702 ? #6;"RICOH 2A03/2A07"
4703 ? #6;""
4704 ? #6;"based on mos 6502"
4705 ? #6;""
4706 ? #6;"2a03 vs mos 6502"
4707 ? #6;"- бцд моде"
4708 ? #6;"+ тимер"
4709 ? #6;"+ дма"
4710 ? #6;"+ соунд сыстем"
4712 RETURN 
4800 REM slide # 48
4801 GRAPHICS 2
4802 ? #6;"2A03 SOUND SYSTEM"
4803 ? #6;""
4804 ? #6;"5 channels"
4805 ? #6;"2 square waves"
4806 ? #6;"1 triangle wave"
4807 ? #6;"1 noise generator"
4808 ? #6;"1 d/a converter"
4809 ? #6;""
4810 ? #6;"22 control registers"
4812 RETURN 
4900 REM slide # 49
4901 GRAPHICS 2
4902 ? #6;"2A03 SQUARE WAVES"
4903 ? #6;""
4904 ? #6;"54.6 hz - 12,4 khz"
4905 ? #6;"4 bit amplitude"
4906 ? #6;"variable duty"
4907 ? #6;"1:8"
4908 ? #6;"1:4"
4909 ? #6;"1:2"
4910 ? #6;"3:4"
4912 RETURN 
5000 REM slide # 50
5001 GRAPHICS 2
5002 ? #6;"2A03 TRIANGLE WAVE"
5003 ? #6;""
5004 ? #6;"27.3 hz - 55.9 khz"
5005 ? #6;"4 bit amplitude"
5006 ? #6;"(automatic control)"
5008 RETURN 
5100 REM slide # 51
5101 GRAPHICS 2
5102 ? #6;"2A03 NOISE GENERATOR"
5103 ? #6;""
5104 ? #6;"15 bit lfsr"
5105 ? #6;"29.3 hz - 447 khz"
5106 ? #6;"two modes"
5107 ? #6;"лонг"
5108 ? #6;"32767 БИТ ЦЫЦЛЕ"
5109 ? #6;"схорт"
5110 ? #6;"93 БИТ ЦЫЦЛЕ"
5112 RETURN 
5200 REM slide # 52
5201 GRAPHICS 2
5202 ? #6;"2A03 D/A CONVERTER"
5203 ? #6;""
5204 ? #6;"dmc"
5205 ? #6;"делта модулатион"
5206 ? #6;""
5207 ? #6;"7 bit"
5208 ? #6;"4.2 khz - 33.5 khz"
5209 ? #6;"semi automatic dma"
5210 ? #6;"non-linear d/a"
5212 RETURN 
5300 REM slide # 53
5301 GRAPHICS 2
5302 ? #6;""
5303 ? #6;"*******************"
5304 ? #6;"TI SN76489 (DCSG)"
5305 ? #6;"*******************"
5306 ? #6;""
5308 RETURN 
5400 REM slide # 54
5401 GRAPHICS 2
5402 ? #6;"TI SN76489 (DCSG)"
5403 ? #6;""
5404 ? #6;"dcsg"
5405 ? #6;"дигитал"
5406 ? #6;"цомплеь"
5407 ? #6;"соунд"
5408 ? #6;"генератор"
5409 ? #6;""
5411 RETURN 
5500 REM slide # 55
5501 GRAPHICS 2
5502 ? #6;"TI SN76489 USED IN"
5503 ? #6;""
5504 ? #6;"sega game 1000"
5505 ? #6;"sega master system"
5506 ? #6;"sega gamegear"
5507 ? #6;"sega megadrive"
5508 ? #6;"acorn bbc"
5509 ? #6;"tomy tutor"
5510 ? #6;"8bit sharp"
5512 RETURN 
5600 REM slide # 56
5601 GRAPHICS 2
5602 ? #6;"TI SN76489 (DCSG)"
5603 ? #6;""
5604 ? #6;"minimalistic design"
5605 ? #6;""
5606 ? #6;"16pin dil"
5607 ? #6;"three square wave"
5608 ? #6;"generators"
5609 ? #6;"one noise generator"
5610 ? #6;""
5611 ? #6;"8 control registers"
5613 RETURN 
5700 REM slide # 57
5701 GRAPHICS 2
5702 ? #6;"TI SN76489 (DCSG)"
5703 ? #6;""
5704 ? #6;"16pin dil"
5705 ? #6;"+5ж + гнд"
5706 ? #6;"д0-д7"
5707 ? #6;"це + ве"
5708 ? #6;"цло (ин)"
5709 ? #6;"ауд (оут)"
5710 ? #6;"оут (оут)"
5711 ? #6;"реы (оут)"
5713 RETURN 
5800 REM slide # 58
5801 GRAPHICS 2
5802 ? #6;"TI SN76489 (DCSG)"
5803 ? #6;""
5804 ? #6;"square wave gen."
5805 ? #6;"10бит фрея.дижидер"
5806 ? #6;"4бит амплитуде"
5808 RETURN 
5900 REM slide # 59
5901 GRAPHICS 2
5902 ? #6;"TI SN76489 (DCSG)"
5903 ? #6;""
5904 ? #6;"noise generator"
5905 ? #6;"15 бит лфср"
5906 ? #6;"онлы 3 фрея."
5907 ? #6;"ФОСЦ/64"
5908 ? #6;"ФОСЦ/128"
5909 ? #6;"ФОСЦ/256"
5911 RETURN 
6000 REM slide # 60
6001 GRAPHICS 0
6002 ? "Rezim 1:"
6003 ? "   "
6004 ? "/|1|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|"
6005 ? "|  "
6006 ? "|                                 |"
6007 ? ""
6008 ? ""
6009 ? "Rezim 2:"
6010 ? "   "
6011 ? "/|1|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|"
6012 ? "|  "
6013 ? "|                           |     |"
6014 ? "|                   |     |"
6015 ? "|                |      |     |"
6016 ? "| XOR  |         |"
6017 ? "                 |      |"
6018 ? "                 "
6020 RETURN 
6100 REM slide # 61
6101 GRAPHICS 2
6102 ? #6;""
6103 ? #6;"*******************"
6104 ? #6;"ti sn76494"
6105 ? #6;"*******************"
6106 ? #6;""
6108 RETURN 
6200 REM slide # 62
6201 GRAPHICS 2
6202 ? #6;"TI SN76494"
6203 ? #6;""
6204 ? #6;"almost the same"
6205 ? #6;"as sn76489"
6206 ? #6;""
6207 ? #6;"missing f/8 divider"
6208 ? #6;"4 mhz -> 500 khz"
6209 ? #6;""
6210 ? #6;"arcade games"
6212 RETURN 
6300 REM slide # 63
6301 GRAPHICS 2
6302 ? #6;""
6303 ? #6;"*******************"
6304 ? #6;"sid"
6305 ? #6;"*******************"
6306 ? #6;""
6308 RETURN 
6400 REM slide # 64
6401 GRAPHICS 2
6402 ? #6;"SID"
6403 ? #6;""
6404 ? #6;"3 oscillators"
6405 ? #6;"each oscillator"
6406 ? #6;"жар. пулсе"
6407 ? #6;"савтоотх"
6408 ? #6;"триангле"
6409 ? #6;"ноисе"
6410 ? #6;""
6411 ? #6;"adsr"
6413 RETURN 
6500 REM slide # 65
6501 GRAPHICS 2
6502 ? #6;"SID"
6503 ? #6;""
6504 ? #6;"filters"
6505 ? #6;"лов пасс"
6506 ? #6;"хигх пасс"
6507 ? #6;"нотцх"
6508 ? #6;""
6509 ? #6;"ring modulator"
6510 ? #6;""
6511 ? #6;"oscillator sync."
6513 RETURN 
6600 REM slide # 66
6601 GRAPHICS 0
6602 ? "      "
6603 ? "  |Tone oscillator   |    |Amplitude|"
6604 ? "|Waveform generator||modulator|"
6605 ? "  |        #1        | |    #1   |"
6606 ? "   |  "
6607 ? "                       |"
6608 ? "   |"
6609 ? "  |Envelope generator| |"
6610 ? "|                  |  ADRS"
6611 ? "  |        #1        |"
6612 ? "  "
6614 RETURN 
6700 REM slide # 67
6701 GRAPHICS 2
6702 ? #6;""
6703 ? #6;"*******************"
6704 ? #6;"* DEMONSTRATIONS  *"
6705 ? #6;"*******************"
6706 ? #6;""
6708 RETURN 
6800 REM slide # 68
6801 GRAPHICS 2
6802 ? #6;""
6803 ? #6;"8BIT GAME CONSOLES"
6804 ? #6;"2ND GENERATION"
6805 ? #6;"CHANNEL F      1976"
6806 ? #6;"ATARI 2600     1977"
6807 ? #6;"MAGNAVOX ODD.  1978"
6808 ? #6;"INTELLIVISION  1979"
6810 RETURN 
6900 REM slide # 69
6901 GRAPHICS 2
6902 ? #6;"16BIT GAME CONSOLES"
6903 ? #6;"TURBOGRAFX-16   1987"
6904 ? #6;"SEGA MEGA DRIVE 1988"
6905 ? #6;"SUPER NES(SNES) 1990"
6906 ? #6;"NEO GEO         1991"
6907 ? #6;"COMMODORE CDTV  1991"
6908 ? #6;"PHILIPS CD-I    1991"
6910 RETURN 
7000 REM slide # 70
7001 GRAPHICS 2
7002 ? #6;"8BIT HOME COMPUTERS"
7004 RETURN 
7100 REM slide # 71
7101 GRAPHICS 2
7102 ? #6;"16BIT PERSONAL COMP."
7104 RETURN 
7200 REM slide # 72
7201 GRAPHICS 2
7202 ? #6;"NES"
7203 ? #6;"nintendo"
7204 ? #6;"entertaiment"
7205 ? #6;"system"
7207 RETURN 
7300 REM slide # 73
7301 GRAPHICS 2
7302 ? #6;"SUPER NES (SNES)"
7303 ? #6;"65c816 cpu"
7304 ? #6;"16bit variant 6502"
7305 ? #6;"sound generated by"
7306 ? #6;"spc700 coprocessor"
7308 RETURN 
7400 REM slide # 74
7401 GRAPHICS 2
7402 ? #6;"SPC700"
7403 ? #6;"programmable"
7404 ? #6;"has 64 kb ram"
7405 ? #6;"8 stereo channels"
7406 ? #6;"16bit samples"
7408 RETURN 
7500 REM slide # 75
7501 GRAPHICS 2
7502 ? #6;""
10000 REM 
10001 REM ---------------------
10002 REM INICIALIZACE
10003 REM ---------------------
10010 SLIDE=0
10020 MAINLOOP=10
10030 KEYCODE=10100
10031 LEFTKEY=134
10032 RIGHTKEY=135
10090 RETURN 
10100 REM 
10101 REM ---------------------
10102 REM PRECTENI KLAVESY
10103 REM ---------------------
10110 POKE 754,255
10120 IF PEEK(754)=255 THEN 10120
10130 RETURN 
20000 REM 
20001 REM ---------------------
20002 REM LOAD RUTINA
20003 REM ---------------------
20010 GRAPHICS 8
20020 ADDR=PEEK(88)+256*PEEK(89)
20030 OPEN #1,4,0,"H:SPECCY.PBM"
20040 FOR I=0 TO 6400-1
20050 GET #1,A
20060 POKE ADDR,A
20070 ADDR=ADDR+1
20080 NEXT I
20090 CLOSE #1
20100 RETURN 

