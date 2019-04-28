clc
clear all

val1 = zeros(1,9);
for i = 1:10000
    val1 = val1 + riskprob(100,100);
    i
end

val2 = zeros(1,8);
for j = 1:10000
    val2 = val2 + riskprob2(100,100);
    j
end

val3 = zeros(1,8);
for k = 1:10000
    val3 = val3 + riskprob3(100,100);
    k
end

clc

val1
per1 = val1/sum(val1)
total1 = sum(val1)
%[treduce, tfunny, tif, tset, tlength, ttotal, tsort, tout, tcheck]

val2
per2 = val2/sum(val2)
total2 = sum(val2)
% [treduce, tfunny, texp, tfind, ttotal, tsort, tout, tcheck]

val3
per3 = val3/sum(val3)
total3 = sum(val3)
% [treduce, tfunny, texp, tfind, ttotal, tsort, tout, tcheck]