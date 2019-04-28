function sol = riskprob3(attack,defense,varargin)

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
% tload = tload + toc;

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
    d = [];

    ze = unique([find(states(:,1)==0);find(states(:,2)==0)]);
    d = [d;states(ze,:)];

    a3 = find(states(:,1)>=3);
    a2 = find(states(:,1)==2);
    a1 = find(states(:,1)==1);

    d2 = find(states(:,2)>=2);
    d1 = find(states(:,2)==1);

    r32 = intersect(a3,d2);
    r31 = intersect(a3,d1);
    r22 = intersect(a2,d2);
    r21 = intersect(a2,d1);
    r12 = intersect(a1,d2);
    r11 = intersect(a1,d1);

    if ~isempty(r32)
        for i = 1:length(r32)
            d = [d;
                states(r32(i),:).*[1 1 prob(3,2,1)]-[0 2 0];
                states(r32(i),:).*[1 1 prob(3,2,2)]-[2 0 0];
                states(r32(i),:).*[1 1 prob(3,2,3)]-[1 1 0];];
        end 
    end

    if ~isempty(r31)
        for i = 1:length(r31)
            d = [d;
                states(r31(i),:).*[1 1 prob(3,1,1)]-[0 1 0];
                states(r31(i),:).*[1 1 prob(3,1,2)]-[1 0 0];];
        end
    end

    if ~isempty(r22)
        for i = 1:length(r22)
            d = [d;
                states(r22(i),:).*[1 1 prob(2,2,1)]-[0 2 0];
                states(r22(i),:).*[1 1 prob(2,2,2)]-[2 0 0];
                states(r22(i),:).*[1 1 prob(2,2,3)]-[1 1 0];];
        end 
    end

    if ~isempty(r21)
        for i = 1:length(r21)
            d = [d;
                states(r21(i),:).*[1 1 prob(2,1,1)]-[0 1 0];
                states(r21(i),:).*[1 1 prob(2,1,2)]-[1 0 0];];
        end
    end

    if ~isempty(r12)
        for i = 1:length(r12)
            d = [d;
                states(r12(i),:).*[1 1 prob(1,2,1)]-[0 1 0];
                states(r12(i),:).*[1 1 prob(1,2,2)]-[1 0 0];];
        end
    end

    if ~isempty(r11)
        for i = 1:length(r11)
            d = [d;
                states(r11(i),:).*[1 1 prob(1,1,1)]-[0 1 0];
                states(r11(i),:).*[1 1 prob(1,1,2)]-[1 0 0];];
        end
    end
    
    states = d;
%     texp = texp+toc;
    

%sum and remove duplicate states
%     tic
    [ns,~,is] = unique(states(:,1:2),'rows');
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