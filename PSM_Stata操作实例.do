clear all
set more off 
cd "/Users/mr.cheng/documents/PSM" 
use "https://github.com/ZhenxingCheng/Chen_Qiang_DataSets/raw/master/ldw_exper.dta", clear

reg re78 t, r

reg re78 t age educ black hisp married re74 re75 u74 u75, r

set seed 123 
gen ranorder = runiform() 
sort ranorder 
psmatch2 t age educ black hisp married re74 re75 u74 u75,outcome(re78) n(1) ate ties logit common

set seed 145
bootstrap r(att) r(atu) r(ate), reps(500):psmatch2 t age educ black hisp married re74 re75 u74 u75, outcome(re78) n(1) ate ties logit common

qui psmatch2 t age educ black hisp married re74 re75 u74 u75, outcome(re78) n(1) ate ties logit common
pstest age educ black hisp married re74 re75 u74 u75, both graph

psgraph

global reduce "age educ black hisp married re74 re75 u74 u75"
psmatch2 t $reduce, outcome(re78) n(4) ate ties common qui

sum _pscore

psmatch2 t $reduce, outcome(re78) n(4) cal(0.01) ate ties logit common qui

psmatch2 t $reduce, outcome(re78) radius cal(0.01) ate ties logit common qui

psmatch2 t $reduce, outcome(re78) kernel ate ties logit common qui

psmatch2 t $reduce, outcome(re78) llr ate ties logit common qui

set seed 112345
bootstrap r(att) r(atu) r(ate), reps(500): psmatch2 t $reduce, outcome(re78) llr ate ties logit common qui

net install snp7_1.pkg
set seed 1234567
bootstrap r(att) r(atu) r(ate), reps(500): psmatch2 t $reduce, outcome(re78) spline ate ties logit common qui

psmatch2 t, outcome(re78) mahal($reduce) n(4) ai(4) ate


