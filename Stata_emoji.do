//Stata_emoji
//首先生成变量xy
clear
set obs 12
gen x = _n 
gen y = x + uniform()
gen emoji =ustrunescape("\U0001f400") if x == 1
replace emoji = ustrunescape("\U0001f430") if x == 2
replace emoji = ustrunescape("\U0001f439") if x == 3
replace emoji = ustrunescape("\U0001f411") if x == 4
replace emoji = ustrunescape("\U0001f410") if x == 5
replace emoji = ustrunescape("\U0001f404") if x == 6
replace emoji = ustrunescape("\U0001f408") if x == 7
replace emoji = ustrunescape("\U0001f412") if x == 8
replace emoji = ustrunescape("\U0001f434") if x == 9
replace emoji = ustrunescape("\U0001f437") if x == 10
replace emoji = ustrunescape("\U0001f418") if x == 11
replace emoji = ustrunescape("\U0001f43a") if x == 12
scatter y x, mlabel(emoji) mlabsize(huge)
scatter y x, mlabel(emoji) mlabsize(huge) mlabposition(0) //mlabposition用于指定图形点标签的显示位置，0表示中心位置，1-12表示钟表方向。
scatter y x, msymbol(none) mlabel(emoji) mlabsize(huge) mlabposition(0) //msymbol用于改变点的形状，none表示不显示点。
graph export animals.svg, replace //windows系统需要输出svg格式的图片然后用浏览器打开才能显示彩色emoji。
gen y1 = 12*uniform()
tw bar y1 x, color(ltkhaki) || scatter y1 x, mlabel(emoji) mlabposition(12) mlabcolor(black) mlabsize(huge) msymbol(none) legend(off)