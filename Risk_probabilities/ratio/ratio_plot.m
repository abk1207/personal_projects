clc
load('ratiodata.mat')
% x = adp(:,2)./adp(:,1)
x = adp(:,1)+adp(:,2)
y = adp(:,3)

plot(x,y,'r-')
hold on
plot(x,adp(:,2)./adp(:,1))
hold off

l = length(x);
mean(adp(l-5:l,2)./adp(l-5:l,1))