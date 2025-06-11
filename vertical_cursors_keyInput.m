function [] = vertical_cursors_keyInput()
function [] = data_subplots()
% Link data cursors so that they track accross subplots.

% Create the subplots.
% Alternatively, use GET to create s and L from existing plots.
x = 1:.1:10;
for ii = 1:3
    s(ii) = subplot(3,1,ii);
    L(ii) = plot(x,sin(x/ii)*ii);
end

% Now start the work.

for ii = 1:length(s)
    S.D{ii} = get(L(ii),{'xdata','ydata'});
    S.L(ii) = length(S.D{ii}{1});    
    S.M(ii) = floor(S.L(ii)/2);
    S.DF = diff(S.D{ii}{1}(S.M(ii):S.M(ii)+1)); % uniform assum
    S.I(ii) = S.M(ii);
    S.T(ii) = text(S.D{ii}{1}(S.M(ii)+2),S.D{ii}{2}(S.M(ii)+2),'here');
    set(S.T(ii),'string',{['X: ',sprintf('%3.3g',S.D{ii}{1}(S.M(ii)))];...
        ['Y: ',sprintf('%3.3g',S.D{ii}{2}(S.M(ii)))]},...
        'parent',s(ii),'backgroundco',[.8 .8 0]);
    set(s(ii),'nextplot','add')
    S.F(ii) = plot(s(ii),S.D{ii}{1}(S.M(ii)),S.D{ii}{2}(S.M(ii)),'sk');
    set(S.F(ii),'markerfacec','b')
end

set(gcf,'keypressfcn',{@fh_kpfcn,S})

function [] = fh_kpfcn(varargin)
D = varargin{2}.Key;
S = varargin{3};
if strcmp(D,'leftarrow')
    for ii = 1:length(S.T)
        if S.I(ii)~=1
            S.I(ii) = S.I(ii)-1;
            set(S.F(ii),'xdata',S.D{ii}{1}(S.I(ii)),...
                'ydata',S.D{ii}{2}(S.I(ii)))
            set(S.T(ii),'position',...
                [S.D{ii}{1}(S.I(ii))+S.DF*2,S.D{ii}{2}(S.I(ii))],...
                'string',{['X: ',sprintf('%3.3g',S.D{ii}{1}(S.I(ii)))];...
                ['Y: ',sprintf('%3.3g',S.D{ii}{2}(S.I(ii)))]})
        end
    end
elseif strcmp(D,'rightarrow')
    for ii = 1:length(S.T)
        if S.I(ii)~=S.L(ii)
            S.I(ii) = S.I(ii)+1;
            set(S.F(ii),'xdata',S.D{ii}{1}(S.I(ii)),...
                'ydata',S.D{ii}{2}(S.I(ii)))
            set(S.T(ii),'position',...
                [S.D{ii}{1}(S.I(ii))+S.DF*2,S.D{ii}{2}(S.I(ii))],...
                'string',{['X: ',sprintf('%3.3g',S.D{ii}{1}(S.I(ii)))];...
                ['Y: ',sprintf('%3.3g',S.D{ii}{2}(S.I(ii)))]})
        end
    end

end
set(gcf,'keypressfcn',{@fh_kpfcn,S})  % Update the structure.