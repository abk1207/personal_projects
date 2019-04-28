clc
clear all

tol = 10^-6;

load('ratiodata.mat')
i = length(adp(:,1));
a = adp(i,1);
d = adp(i,2);

if adp(i,3)<0.5
    a = a+1;
else
    d = d+1;
end

while 1
    out = riskprob(a,d)
    adp = [adp; a, d, out(1)];
    save('ratiodata.mat','adp');
    l = length(adp(:,1));
    s = sum(abs(adp(l-4:l,3)-0.5));
    if s<=5*tol
        out;
        break
    elseif out(1)<out(2)
        a = a+1;
        [a,d]
    elseif out(1)>out(2)
        d = d+1;
        [a,d]
    end
end

