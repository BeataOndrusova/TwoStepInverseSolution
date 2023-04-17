function [minGlobalRRE_val, minGlobalRRE_pos, minLocalRRE_val, minLocalRRE_pos] = minRRE(RRE, time_start, time_end) 
% With this script we are looking the inverse solution using criterion of
% minimal RRE
% Within this script we are looking for global and local minima of RRE
% within selected time interval


% determine the time interval for selection of the solution
% the start of the signal does not need to be in position 1 but after NaN
[row, ~] = find(isnan(RRE));
if isempty(row) % if there is no NaN
    time_start = time_start;
    time_end = time_end;
else
    time_start = time_start + row;
    time_end =  time_end + row;
end

% global minimum
row = [];
col = [];
minGlobalRRE_val = min(RRE(time_start:time_end,1));
[minGlobalRRE_pos, ~] = find(RRE == minGlobalRRE_val);


% local minimum
TF = islocalmin(RRE,1); % the row with local minimum contains 1 and row without contain 0

if sum(TF(time_start:time_end,1)) == 0 % it is possible that within the time frame there will be no localmin - therefore minLocalRRE = minGlobalRRE
    minLocalRRE_val = minGlobalRRE_val;
    minLocalRRE_pos = minGlobalRRE_pos;
else
    hlp_pos = find(TF == 1);
    hlp_pos = hlp_pos(and(hlp_pos>=time_start, hlp_pos<=time_end)); % just find positions of the minimum within the selected time interval
    minLocalRRE_val = min(RRE(hlp_pos));
    minLocalRRE_pos = find(RRE == minLocalRRE_val); % there can be multiplpe local minima, how to solve it? Here I just the minimal value
end


end %% function
