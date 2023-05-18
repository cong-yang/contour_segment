function [ bool_straight ] = f_Estimate_Straight_Line( Path )
%f_Estimate_Straight_Line: This function is used for estimate whether a input 
% path is a straight line or not
%   Input: 
%         Path: path points
%   Output:
%         bool_straight: 1 straight, 2 not straight
bool_straight = 1;

for i = 1:size(Path,1)-1
    minusx = abs(Path(i,1)-Path(i+1,1));
    minusy = abs(Path(i,2)-Path(i+1,2));
    if minusx ~= 1 || minusy ~= 1
        bool_straight = 2;
        return;
    end
end

end

