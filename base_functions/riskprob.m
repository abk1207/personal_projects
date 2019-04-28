function sol = riskprob(attack,defense,varargin)

% tload = 0;
% tfunny = 0;
% tcheck = 0;
% texp = 0;
% treduce = 0;
% ttotal = 0;
% tsort = 0;
% tout = 0;

states = [attack,defense,1];
% tic
load probabilities.mat
% tload = tload+toc;


% tic
if all(states(1:2)==0) || any(states(1:2)<0)
    fprintf('Very funny, you cant break me.\n')
    return
end
% tfunny = tfunny+toc;

while 1
%test if finished
%     tic
    if all(sum(states(:,1:2)==0,2)==1)
        break
    end
%     tcheck = tcheck + toc;
    
%expand states

%     tic
    l = length(states(:,1));
    
    d = [];
    for i = 1:l
        s = states(i,:);
        at = min([s(1),3]);
        de = min([s(2),2]);
        
        if at==0 || de==0
            d = [d;s];
        elseif at==1 || de==1
            sa = (s-[0,1,0]).*[1,1,prob(at,de,1)];
            sde = (s-[1,0,0]).*[1,1,prob(at,de,2)];
            d = [d;sa;sde];
        else
            sa = (s-[0,2,0]).*[1,1,prob(at,de,1)];
            sde = (s-[2,0,0]).*[1,1,prob(at,de,2)];
            sdr = (s-[1,1,0]).*[1,1,prob(at,de,3)];
            d = [d;sa;sde;sdr];
        end
    end
    states = d;
%     tif = tif +toc;

%sum and remove duplicate states
%     tic
    [ns,ins,is] = unique(states(:,1:2),'rows');
    sm = accumarray(is,states(:,3));
    states = [ns,sm];
%     treduce = treduce + toc;
    
end

% Total prob of att win or def win
% tic
ap = 0;
dp = 0;

for i = 1:length(states(:,1))
    if ~states(i,1)==0;
        ap = ap + states(i,3);
    else
        dp = dp + states(i,3);
    end
end
% ttotal = ttotal +toc;

% tic
[~, i] = sort(states(:,1)-states(:,2),'descend');
states= states(i,:);
% tsort = tsort + toc;

% tic
if isempty(varargin)
    %CHANGE
    sol = [ap,dp];
elseif length(varargin)==1
    if strcmp(varargin{1},'detail')
        %CHANGE
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
% tout = tout+toc;

% sol = [tload, tfunny, tcheck, texp, treduce, ttotal, tsort, tout];