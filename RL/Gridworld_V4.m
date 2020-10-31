clear;clc;close all

%% create gridworld
% zeros represent terminal states
s = [0 1 2 3; ...
     4 5 6 7;...
     8 9 10 11;...
     12 13 14 0];

% index all nonterminal states
xIND = find(s ~= 0);

%% Reward
R = -1*ones(size(s)); % -1 reward for nonterminal states
R(1,1) = 0; % reward at first goal
R(4,4) = 0; % reward at second goal

%% other parameters
% discount factor
% gamma = 0.9;
gamma = 1;
% same uniform probability pi(s,a) = 1/4
pi = 0.25; % policy - probability of taking action a in state s

% initial value function arbitrarily chosen
Vkplus1 = zeros(size(s))
% initialize loop
iteration = 1;

%% value iteration
for iteration = 1:4
    Vk = Vkplus1;
    
    % for all nonterminal states
    for i = 1:numel(xIND)
        [Iy,Ix] = ind2sub(size(Vkplus1),xIND(i));
        moves = [1,0; 0,1; -1,0; 0,-1]; % (x,y) positive right, up
        
        % four moves per state
        for k = [1,2,3,4]
            move = [moves(k,1),moves(k,2)];
            % account for boarders of gridworld
            % will stay at same state if try to move across boarder
            if Ix == 1 && move(1) == -1
                move = [0,0];
            elseif Ix == 4 && move(1) == 1
                move = [0,0];
            elseif Iy == 1 && move(2) == -1
                move = [0,0];
            elseif Iy == 4 && move(2) == 1
                move = [0,0];
            else
                move = [moves(k,1),moves(k,2)];
            end
            
            % The reward is -1 on all transitions until the terminal state is reached.
            pisum(k) = pi;
            Vksum(k) = Vk(Iy + move(2),Ix + move(1));
        end
        
        Vknew = (sum(pi))*(sum(repmat(R(Iy,Ix),1,4)+gamma*Vksum));
        Vkplus1(Iy,Ix) = Vknew;
        
        %% Plotting the policies
        opt = max(Vksum);
        ind = find(Vksum == opt);
        % convert to -1 meaning up
        optmoves = moves(ind,:);
        optmoves(:,2) = -1*optmoves(:,2);
        
        figure(iteration)
        hold on
        subplot(4,4,1)
        hold on
        realIt = iteration-1;
        realItStr = num2str(realIt);
        title(strcat('Iteration',realItStr))
        plot(0,0,'ko')
        subplot(4,4,16)
        plot(0,0,'ko')

        order = s(Iy,Ix) + 1;
        subplot(4,4,order)
        hold on
        xlim([-1 1])
        ylim([-1 1])
        plotv(optmoves','k-')
        for i = 1:length(optmoves(:,1))
            plot(optmoves(i,1),0,'ko')
            plot(0,optmoves(i,2),'ko')
        end
    end
    
    iteration+1;
    Vkplus1
    pause
end