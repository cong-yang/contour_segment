function [ csfeature ] = f_CS_10_Feature_ContourFlexibility( ContourSegment )
%f_CS_10_Feature_ContourFlexibility: this function is used to generate contour
%                                    segment descriptor using Contour Flexibility.
%   input: 
%         ContourSegment: a single contour segment
%   output:
%          csfeature: the contour segment feature using Contour Flexibility
%   description:
%          refer to the paper: 
%          Chunjing Xu, et al., 2D shape matching by contour flexibility,
%          PAMI, 2009.

mylength = size(ContourSegment,1);
if mod(mylength,2) == 1
    TempCS(1:(mylength-1),:) = ContourSegment(1:(mylength-1),:);
    ContourSegment = TempCS;
end
%------ Parameters ----------------------------------------------
n_pt= size(ContourSegment,1);
X	= ContourSegment(:,1);
Y	= ContourSegment(:,2);  % X,Y are both column vectors
hf = zeros(n_pt-3, n_pt);

%-- Geodesic distances between all landmark points ---------
Xs			= repmat(X,1,n_pt);  % Xs = [X X ... X];
dXs			= Xs-Xs';
Ys			= repmat(Y,1,n_pt);  % Xs,Ys are both square matrix 
dYs			= Ys-Ys';
dis_mat		= sqrt(dXs.^2+dYs.^2);    % this data representation and algorithm to get all distances is great! use matrix operations naturally.
diameter    = max(dis_mat(:));  % max or mean both try

%-- SAR for every landmark point ---------
X3 = repmat(X,3,1);
Y3 = repmat(Y,3,1);

for p_index = 1+n_pt : n_pt+n_pt
    scale_index = n_pt/2-1;
    left = p_index-scale_index;
    right = p_index+scale_index;
    chord = pdist([X3(left) Y3(left); X3(right) Y3(right)]); % chord length
    height_vector = zeros(2*scale_index-1, 1);
        
    for i = left+1 : right-1
        height_vector(i-left) = det([X3(left) Y3(left) 1; X3(i) Y3(i) 1; X3(right) Y3(right) 1]); % signed area
    end
    height_vector = height_vector / chord; % signed height
    hf(:, p_index-n_pt) = height_vector;
end

%-- Normalize tar with the shape diameter --------------------
hf = hf / diameter;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%smoothing and local normalization
% k=6, M=16 %
% scales1 = [1:6];
% scales2 = [7:12];
% scales3 = [13:18];
% scales4 = [19:24];
% scales5 = [25:30];
% scales6 = [31:37];
% scales7 = [37:42];
% scales8 = [43:49];
% scales9 = [49:55];
% scales10 = [56:61];
% scales11 = [62:67];
% scales12 = [68:73];
% scales13 = [74:79];
% scales14 = [80:85];
% scales15 = [86:91];
% scales16 = [92:97];

totalrow = n_pt - 3;
k = 6;
numscale = floor(totalrow/k);
for i = 1:numscale
    if i == numscale
        %display(['[',num2str(i*k-(k-1)),':',num2str(totalrow),']']);
        tmp(i,:) = sum(hf([i*k-(k-1):totalrow],:));
    else
        %display(['[',num2str(i*k-(k-1)),':',num2str(i*k),']']);
        tmp(i,:) = sum(hf([i*k-(k-1):i*k],:));
    end
end

%tmp = [sum(hf(scales1, :)); sum(hf(scales2, :)); sum(hf(scales3, :)); sum(hf(scales4, :)); sum(hf(scales5, :)); sum(hf(scales6, :)); sum(hf(scales7, :)); sum(hf(scales8, :)); sum(hf(scales9, :)); sum(hf(scales10, :)); sum(hf(scales11, :)); sum(hf(scales12, :)); sum(hf(scales13, :)); sum(hf(scales14, :)); sum(hf(scales15, :)); sum(hf(scales16, :))];
%mytmp = [sum(hf(scales1, :)); sum(hf(scales2, :)); sum(hf(scales3, :)); sum(hf(scales4, :)); sum(hf(scales5, :)); sum(hf(scales6, :))];

v = max(abs(tmp'));
norm_hf = tmp ./ repmat(v', 1, n_pt);
csfeature = norm_hf;
end

