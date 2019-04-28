clc
clear all

mat = [];

for i = 1:6
    for j = 1:6
        for k = 1:6
            for l = 1:6
                for m = 1:6
                    mat = [mat; i j k l m];
                end
            end
        end
    end
end

for id = 1:2
    for ia = 1:3
        a = sort(mat(:,1:ia),2,'descend');
        d = sort(mat(:,4:3+id),2,'descend');
        
        if id<=ia
            b = d(:,1:id)-a(:,1:id);
        else
            b = d(:,1:ia)-a(:,1:ia);
        end
        
        dscore = sum(all(b>=0,2))/7776;
        ascore = sum(all(b<0,2))/7776;
        draw = (7776-7776*(ascore+dscore))/7776;
        
        prob(ia,id,1) = ascore;
        prob(ia,id,2) = dscore;
        prob(ia,id,3) = draw;
        
        aloss = (2*dscore + draw);
        dloss = (2*ascore + draw);
        
        fprintf('With %1.0f attackers and %1.0f defenders: \n',ia,id)
        fprintf('     Attackers will win %2.2f percent of battles, losing %1.4f soldiers per battle. \n', 100*ascore,aloss)
        fprintf('     Defenders will win %2.2f percent of battles, losing %1.4f soldiers per battle. \n', 100*dscore,dloss)
        fprintf('     The battle will draw %2.2f percent of battles. \n\n', 100*draw)
    end
end


save('probabilities.mat','prob')