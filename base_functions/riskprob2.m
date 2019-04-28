function sol = riskprob2(attack,defense,varargin)

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
        d = [d;
            bsxfun(@times, bsxfun(@minus, states(r32,:), [0 2 0]),[1 1 prob(3,2,1)]);
            bsxfun(@times, bsxfun(@minus, states(r32,:), [2 0 0]),[1 1 prob(3,2,2)]);
            bsxfun(@times, bsxfun(@minus, states(r32,:), [1 1 0]),[1 1 prob(3,2,3)])];
    end

    if ~isempty(r31)
        d = [d;
            bsxfun(@times, bsxfun(@minus, states(r31,:), [0 1 0]),[1 1 prob(3,1,1)]);
            bsxfun(@times, bsxfun(@minus, states(r31,:), [1 0 0]),[1 1 prob(3,1,2)])];
    end

    if ~isempty(r22)
        d = [d;
            bsxfun(@times, bsxfun(@minus, states(r22,:), [0 2 0]),[1 1 prob(2,2,1)]);
            bsxfun(@times, bsxfun(@minus, states(r22,:), [2 0 0]),[1 1 prob(2,2,2)]);
            bsxfun(@times, bsxfun(@minus, states(r22,:), [1 1 0]),[1 1 prob(2,2,3)])];
    end

    if ~isempty(r21)
        d = [d;
            bsxfun(@times, bsxfun(@minus, states(r21,:), [0 1 0]),[1 1 prob(2,1,1)]);
            bsxfun(@times, bsxfun(@minus, states(r21,:), [1 0 0]),[1 1 prob(2,1,2)])];
    end

    if ~isempty(r12)
        d = [d;
            bsxfun(@times, bsxfun(@minus, states(r12,:), [0 1 0]),[1 1 prob(1,2,1)]);
            bsxfun(@times, bsxfun(@minus, states(r12,:), [1 0 0]),[1 1 prob(1,2,2)])];
    end

    if ~isempty(r11)
        d = [d;
            bsxfun(@times, bsxfun(@minus, states(r11,:), [0 1 0]),[1 1 prob(1,1,1)]);
            bsxfun(@times, bsxfun(@minus, states(r11,:), [1 0 0]),[1 1 prob(1,1,2)])];
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
