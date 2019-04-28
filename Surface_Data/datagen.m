clc
clear all
for i = 1:200
    for j = 1:200
        val = riskprob(i,j);
        data(i,j)= val(1);
        [i,j]
    end
end

save('data1to200ad.mat','data')
