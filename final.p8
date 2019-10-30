pico-8 cartridge // http://www.pico-8.com
version 18
__lua__

--set globals 
t = true 
f = false 

function init_char()
	
	char 
	tmr = 0 
	flp = f 
	
	sp = {96,97}

end 



__gfx__
00000000000000003777777777777777333333333333333300000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000110007000000000000000000000000000000300000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700010000107000000000000000888888888888888000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000010000107000000000000000222222222222222000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000010000107000000000000000000000000000000300000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700010000107000000000000000333333333333333300000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000110007000000000000000333333333333333300000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000007000000000000000333333333333333300000000000000000000000000000000000000000000000000000000000000000000000000000000
3344433330000003300000030000000000000000000000000000000000000000000000000000000000000000dddddddddddddddddddddddddddddddd00000000
3302033304244240044aa4400088088000880880000aaa000090000000a000a000a000000000020000000000d550055dd500005ddddddddddddddddd00000000
330303332444444204000040080080080888888800aa99a000a0090000a00000000000000088000000000000505005055000000565166d516510101000000000
303730339aaaaaa940000004080000080888888800a9a9a000990a00aa0aa00000000a000888882000000000505aa50550000005551555515510101000000000
087882032449944224499442008000800088888000a9aaa000aa090000a000000000a0a002882200000000005059950550000005111111111111111100000000
0888220324422442244224420008080000088800000aaa00099a999000a00a0000000a000022000000000000505005055000000516d516d516d516d500000000
30822033022222200222222000008000000080000000000099a99aa9000000000a00000000022020000000005011110550111105155515551555155500000000
33000333300000033000000300000000000000000000000000999990a00000000000000a00000000000000000111111101111111000000000000000000000000
00000900000900000009000000090000009990003333044300000000000000000000000000000000111110000000000001111111111111111111111100000000
00a0900000000090009a9000000a9000009090003330730300000000000000000000000000000000110000000000000000000111111511111511111100000000
00090900000090000009a900009aa000009990003307d03300000000000000000000000000000000100000000000000000000011155155151111111100000000
009aaa900099a900009aa900009aa900000a000030dd003300000000000000000000000000000000100000000000000000000011151111551111111100000000
009aa990009aa9900099a9000099a900000aa00030d0110300000000000000000000000000000000100000000000000000000011111551551111111100000000
04444900044449000002400000024000000a00003010010300000000000000000000000000000000000000000000000000000001151551115111111100000000
42202444422024440002400000024000000aa0003011110300000000000000000000000000000000000000000000000000000001551115515111111100000000
00000240000002400000000000000000000000003300003300000000000000000000000000000000000000000000000000000001151151111111111100000000
33333333333333333d033dd03d033dd0333333333333333300000000000000000000000000000000000000000000000000000000111111511111111100000000
33900933330000333d800d033d800d03330000003011113300000000000000000000000000000000000000000000000000000000115515551111111100000000
30955903305555030888dd030888dd03309949940151511300000000000000000000000000000000100000000000000000000000155111551111111100000000
0599995005000050088d8203088d8203330940940111151300000000000000000000000000000000000000000000000000000001111551111111111100000000
00400400000000000282820330828203330940940155151300000000000000000000000000000000100000000000000000000001151511551111111100000000
000000000000000002822803308220333a99aaa40151151300000000000000000000000000000000100000000000000000000001155115511111111100000000
30000003300000033022203330220333a94aa4443015511300000000000000000000000000000000110000000000000000000011111151511111111100000000
33333333333333333022033333003333000000003301113300000000000000000000000000000000111111000000000000001111551551111111111100000000
33000033333003333333333333333333333333333333033333333333333333333300003333000033333333333333333333088833333333333088033333300333
30888803330880333333333333333333333776633033333333333033333333333000000330000003330003333300033330886823333333330888803333088033
08222280308228030b33333b0b3333333370766d3330003303000330330003333700700330700703306870333087703330860783333333330868803333088833
82f8222830872803bbb333b3bbb33bb3337006dd33070703307070333070703330000003300000030d8086030808760308070080300888333378823330888803
82882228382222830b3bbb330b3bb33b376666dd33000003300000333000003330000003300000030d80860308087d0308000078088888233738820330288823
0888888038288283333333333333333336d6ddd000000000000000033000003330000003300000030d808d030808dd0328800002888882228688222232288222
3000000330800803333333333333333336d60003300003333300003333000333300000033000000330d8d033308dd03330288800302222000882220030022200
33333333333333333333333333333333300033333333333333333333333333333003003330030033330003333300033333000033330000333000003333302033
00000000006000008888888890000000000009000000000000008000008000803333344444433333000000000000000033333330066003333333333330000333
00000000006000000828820009998000099800000000000008088800000880003334499999944333000000000000000033333306655503333333333301111033
0666000006660600080820209aa998809aa98000000980000080980000899800334999a4aa999433000000000000000033333065555003333333333311111033
000000000000060002082000a77a9998a77a98800a798800008aa9800080a9093499aaa4aaaa9903000000000000000033333655500040333333333310111103
0000666000606660000220009aa998809aa9800000980000009a0999089a7090499a4aaaaaa4a990000000000000000033333650033040333333333110011110
000000000060000002000000099980000998000000000000008a7a99099a7a9049aaaaaaaaaaaa90000000000000000033333603333340333333333170711110
0666000006660000000200000000008090000000000000000009a9900009a900494a0aaaaa0aa490000000000000000033333033333302033333333100011110
00000000000000000000000000900000000000a000000000000000000000000049aaa0a90000aa90000000000000000033333333333330033333333101111110
000000000000000000000000000000000000000000000040000000000000000049aaaaa0aa0aaa90000000000000000033333333333330203333333111111103
4099990000000000099990000999904000000000099990400000000000000000494aaaa0aaaaa490000000000000000033333333333333003333333111111103
4999ff9004999900999ff900999999400999904099999940000000000000000049aaaaa0aaaaaa90000000000000000033333333333333003333333011111113
4f0ff0f00499ff90f0ff0f009999994099999940999999f00000000000000000499aaa000aaaa990000000000000000033333333333333333333333011111113
40ffff00040ff0f00ffff000099990409999994009999d40000000000000000034994aa0aaa49903000000000000000033333333333333333333333311103113
fddddd0004ffff004f4444440dddddf009999040fdddd0000000000000000000334999aa4a999033000000000000000033333333333333333333333301103333
40ddddf00fdddd000ddddf00fdddd0400dddddf00dddd00000000000000000003334499999900333000000000000000033333333333333333333333333103313
0030030004ddddf00300300003003000fdddd0400300300000000000000000003333300000003333000000000000000033333333333333333333333313033333
0000000000000000000f000033330003330999000099903333333333000000000000000000000000000000000000000000000000000000000000000000000000
000600000000042000f7e0003330665330ff99999999ff0333333333000000000000000000000000000000000000000000000000000000000000000000000000
000600000000420000eee0003366555330ff79999999ff0333111333000000000000000000000000000000000000000000000000000000000000000000000000
0006000000042000000e000033655043330f70799079f03331111133000000000000000000000000000000000000000000000000000000000000000000000000
00060000004200000002000036503343330770077009909031111133000000000000000000000000000000000000000000000000000000000000000000000000
00999000042000000002000035033343330777777777999031000033000000000000000000000000000000000000000000000000000000000000000000000000
000c000000000000000200003033334330ff7777777ff90337333333000000000000000000000000000000000000000000000000000000000000000000000000
000c0000000000000000000033333343330000000000003333333333000000000000000000000000000000000000000000000000000000000000000000000000
33333033033333333333333333333333333333333333333333333333333333333300000000003333333300000000333300000000000000000000000000000000
333330030033333333333333333333333333333333333333333333333333333330dd010ddddd00333300dd01110d003300000000000000000000000000000000
33333003003033333333333333333333333333333300000000033333333333330dd01110dddddd0330dddd01110ddd0300000000000000000000000000000000
3333300300300333333333333333333333333333000000000000003333333333ddd01110ddddddd00ddddd01110dddd000000000000000000000000000000000
3033000000000333333333311301133333333330000000000000000333333333ddd01110ddddddd00ddddd01110dddd000000000000000000000000000000000
3001100000003333330113001000133333333330000000000000000033333333ddd01110ddddddd00dddddd010ddddd000000000000000000000000000000000
30000000001333333301000000000333333333300000000000000000333333330dd01110dddddd0330dddddd0ddddd0300000000000000000000000000000000
330000000133333330000000000003333333330000000000000000003333333330d0010ddddd00333300dddddddd003300000000000000000000000000000000
33300001111333333000000000000033333333000000000000000000033333330000000000000000000000000000000000000000000000000000000000000000
333331001113333330000000000000333333300000ddd0100dd00000033333330440000000000000000000000000044000000000000000000000000000000000
3333300001333333300000000dd0003033333000dddd01110dddd000003333330444444400000000000000004444444000000000000000000000000000000000
333300000133333330d00dd0030d0d033333000ddddd01110ddddd00003333330044222244444444444444442222240000000000000000000000000000000000
d0000000111333333ddd0d3d033333333333000ddddd01110ddddd00003333330042444422222222222222224444240000000000000000000000000000000000
3dd000d0dd1113333333d333333333333333000ddddd01110ddddd00003333330042444444444444444444444444240000000000000000000000000000000000
3333d33333ddd333333333333333333333300000dddd01110dddd000003333330042444444444444444444444444240000000000000000000000000000000000
333333333333333333333333333333333330000000dd00100dd00000001333330042444444444444444444444444240000000000000000000000000000000000
01111111000000000000000000000000330000000000000000000000001333330004244444444444444444444442400000000000000000000000000000000000
10000000000000000000000000000000331000000000000000000000001333330004244444444444444444444442400000000000000000000000000000000000
10000000000000000000000000000000331000000000000000000000001333330004244444444444444444444442400000000000000000000000000000000000
10000000000000000000000000000000331000000000000000000000001333330004244444444444444444444442400000000000000000000000000000000000
11000000000000000000000000000000331000000000000000000000001133330004244444444444444444444442400000000000000000000000000000000000
01000000000000000000000000000000331000000000000000000000001133330004244444444444444444444442400000000000000000000000000000000000
00100000000000000000000000000000331100000000000000000000001133330004244444444444444444444442400000000000000000000000000000000000
00110000000000000000000000000000311100000000000000000000001111330004244444444444444444444442400000000000000000000000000000000000
00000000000000000000000000000000311100000000000000000000001111130042444444444444444444444444240000000000000000000000000000000000
00000000000000000000000000000000311110000000000000000000001111130042444444444444444444444444240000000000000000000000000000000000
0000000000000000000000000000000033d1110000000011110000000111d1130042444444444444444444444444240000000000000000000000000000000000
000000000000000000000000000000003333110000000111110000000111dd330042444422222222222222224444240000000000000000000000000000000000
000000000000000000000000000000003333dd100000111111111100011dd3330044222244444444444444442222440000000000000000000000000000000000
00000000000000000000000000000000333333d1100111d111ddddd1133333330444444400000000000000004444444000000000000000000000000000000000
000000000000000000000000000000003333331111dddd3311333333333333330440000000000000000000000000044000000000000000000000000000000000
00000000000000000000000000000000333331111333333333333333333333330000000000000000000000000000000000000000000000000000000000000000
__map__
1414131313777777777777777101010100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1d1d1e1d521d1c1e1d1d1b1d1e1d1d1d00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
3d3d2d3d2d2e3e2d243d3d2d3d403d3d00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
3d2a2b2c2d3d3d3d182d173d4e2d2d3d00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
3d3a2b3c30603e431511124f3d123d3d00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
3d4a2d3d313d3e3e413d3d443d3d2d3d00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
2d3d3d103d3d3d3d2a2c3d3d3d3d3d3d00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
2d3d3d2d2d193d3d3a3c3d2d3d3d2d3d00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
3d3d3d3d3d2d2d3d3d3d3d3d3d3d3d3d00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
