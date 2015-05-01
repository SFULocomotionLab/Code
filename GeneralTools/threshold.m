function [t_up, t_down]=threshold(signal, cutoff, minrunlength,options)
% [t_up, t_down]=threshold(signal, cutoff, minrunlength, options) determines when 
% a signal crosses a threshold both on the way up and on the way down
%
% INPUT: 
% SIGNAL - the signal to analyze for threshold crossings
% CUTOFF - the threshold to detect
% MINRUNLENGTH - for a threshold crossing to be reported, the signal must spend
% minrunlength above the threshold
% OPTIONS - choose different options for reporting threshold crossings.
%       options=0: reports all crossings. 
%       options=1: only report first up crossing and last down crossing. 
%
% OUTPUT: 
% t_up: the indices that the signal crossed the threshold on the way up
% t_down: the indices that the signal crossed the threshold on the way down
%
% Written by Max Donelan on 16-Sep-2002

if nargin < 3, minrunlength = 0; options = 0; end
if nargin < 4, options = 0; end

% Find the parts of the signal that are above a certain threshold
over=find(signal>=cutoff);
% Find the parts of the signal that are above the threshold and consecutive
consecutives=diff(over)==1;
% This find the beginning indices for runs of consecutive parts above the threshold
beginrun=find(consecutives==1 & [0; consecutives(1:end-1)]==0);
% This does the same for the end indices
endrun=find(consecutives == 1 & [consecutives(2:end); 0] == 0)+1;
% This goes back to the indices of the original signal
beginit=over(beginrun);
endit=over(endrun);
% in the event that the signal starts above the cutoff, get rid of it
%if beginit(1) ==1, beginit(1) = []; end
% This gets rid of unpaired crossings
%if endit(1) < beginit(1), endit(1) = []; end
%if beginit(end) > endit(end), beginit(end) = []; end
% calculate the length of runs and get rid of the ones that aren't long enough
runlength=endit-beginit+1;

t_up = beginit(runlength >= minrunlength);
t_down = endit(runlength >= minrunlength);

% this takes care of when the algorithm identifies the last sample as
% coming down
%if t_down(end) == length(signal), t_down(end) = []; end

% % this takes care of when the signal starts above threshold
% if isempty(t_up) & ~isempty(t_down), t_up = 1; end
% 
% % this takes care of when the signal ends above threshold
% if isempty(t_down) & ~isempty(t_up), t_down = length(signal); end

% choose different options for reporting threshold crossings.
if options == 1,    % only report first up crossing and last down crossing.
    if ~isempty(t_up), t_up = t_up(1); end
    if ~isempty(t_down), t_down = t_down(end); end
end