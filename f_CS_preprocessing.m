function [ cont ] = f_CS_preprocessing( cont, n_contsamp )
%f_CS_preprocessing: this function is used to process the original contour
%segment and select the sample points along the contour segment
%   input:
%         orics: the original contour segment
%         n_contsamp: number of sample points we will choose
%   output:
%         cont: the contour segment after preprocessing

%ensure the points are listed along the row
[M,~] = size(cont);
if M == 2
    cont = cont';
end

% cont		= [cont; cont(1,:)];
% dif_cont	= abs(diff(cont,1,1));
% id_gd		= find(sum(dif_cont,2)>0.001);
% cont		= cont(id_gd,:); %sample points of the object countour after remove the redundant point

% force the contour to be anti-clockwisecomputed above is at the different orientation
bClock		= f_is_clockwise(cont);
if bClock	
    cont	= flipud(cont);		
end

 % start from bottom
[~,id]	= min(cont(:,2));
cont		= circshift(cont,[length(cont)-id+1]);

[XIs,YIs]	= f_uniform_interp(cont(:,1),cont(:,2),n_contsamp-1);
cont		= [cont(1,:); [XIs YIs]];
end

