function sol = riskprob(attack,defense,varargin)
states = [attack,defense,1];
load probabilities.mat
num = [];
texpand = 0;
treduce = 0;

if all(states(1:2)==0) || any(states(1:2)<0)
    fprintf('Very funny, you cant break me.\n')
    return
end

while 1
    %test if finished
    if all(sum(states(:,1:2)==0,2)==1)
        break
    end
    
    %expand states
    tic;
    l = length(states(:,1));
    for i = 1:l
        s = states(i,:);
        at = min([s(1),3]);
        de = min([s(2),2]);
        
        if at==0 || de==0
            states = [states;s];
        elseif at==1 || de==1
            sa = (s-[0,1,0]).*[1,1,prob(at,de,1)];
            sde = (s-[1,0,0]).*[1,1,prob(at,de,2)];
            states = [states;sa;sde];
        else
            sa = (s-[0,2,0]).*[1,1,prob(at,de,1)];
            sde = (s-[2,0,0]).*[1,1,prob(at,de,2)];
            sdr = (s-[1,1,0]).*[1,1,prob(at,de,3)];
            states = [states;sa;sde;sdr];
        end
    end
    states(1:l,:) = [];
    texpand = texpand + toc;

    %sum and remove duplicate states
    tic;
    [ns,ins,is] = unique(states(:,1:2),'rows');
    sm = accumarray(is,states(:,3));
    states = [ns,sm];
    treduce = treduce + toc;
    
end

% Total prob of att win or def win
ap = 0;
dp = 0;

for i = 1:length(states(:,1))
    if ~states(i,1)==0;
        ap = ap + states(i,3);
    else
        dp = dp + states(i,3);
    end
end

[p, i] = sort(states(:,1)-states(:,2),'descend');
states= states(i,:);

if length(varargin)==0
    sol = [ap,dp];
elseif length(varargin)==1
    if strcmp(varargin{1},'detail')
        sol = states;
        fprintf('texpand = %f\n', texpand)
        fprintf('treduce = %f\n', treduce)
    else
        fprintf('Incorrect parameter input\n')
        return
    end
elseif length(varargin)>1
    fprintf('Incorrect parameter input\n')
    return
end
