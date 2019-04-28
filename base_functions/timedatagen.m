clc
tdata = zeros(100,100,3);

for i = 100:-1:1
    for j = 100:-1:1
        t1 = 0;
        t2 = 0;
        t3 = 0;
        for k = 1:20
            tic
            riskprob(i,j);
            t1 = toc + t1;
            
            tic
            riskprob2(i,j);
            t2 = toc + t2;
            
            tic
            riskprob3(i,j);
            t3 = toc + t3;
        end
        tdata(i,j,:) = [t1 t2 t3];
        [i,j]
    end
end

tdata = tdata/20;

save('timedata.mat','tdata')
fprintf('done\n')