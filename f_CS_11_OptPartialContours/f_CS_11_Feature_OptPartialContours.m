function [ csfeature ] = f_CS_11_Feature_OptPartialContours( ContourSegment )
%f_CS_11_Feature_OptPartialContours: this function is used to generate contour
%                                    segment descriptor using Optimal
%                                    Partial Contours.
%   input: 
%         ContourSegment: a single contour segment
%   output:
%          csfeature: the contour segment feature using optimal partial contours.
%   description:
%          refer to the paper: 
%          Peter Kontschieder, et al., Discriminative learning of contour
%          fragments for object detection, BMVC 2011.

%
% numfra = 1; %number of sub fragment
% mylength = size(ContourSegment,1); 
N = size(ContourSegment,1); 
% N = floor(mylength/numfra); %length of each fragment
% 
% %just to ensure the fragment can be splited correctly
% if (N*numfra) > mylength
%     N = N -1;
% end
% 
% %split the contour segment into fragments
% for i = 1:numfra
%     startindex = (i-1)*N+1;
%     fragments{i} = ContourSegment(startindex:(startindex+N-1),:);
% end

%calculate the descriptor for every individual edge
%for m = 1:numfra
    %B = fragments{m};
    B = ContourSegment;
    %calculate the coordinate of the upper left corner of the 
    %surrounding bounding box of Bi
    px = min(B(:,1));
    py = min(B(:,2));
    
    %generate bi and bj
    sgfeature = zeros(N,N);
    for i = 1:N
        bix = B(i,1);
        biy = B(i,2);
        for j = 1:N
            bjx = B(j,1);
            bjy = B(j,2);
            %start to calculate the angle between [bi,bj] and [bj,p]
            vji = [bjx-bix, bjy-biy];
            vjp = [bjx-px, bjy-py];
            C = dot(vji,vjp)/(norm(vji)*norm(vjp));
            if (norm(vji)*norm(vjp)) == 0
                C = 1;
            end
            alphijp = acos(C);
            sgfeature(i,j) = roundn(alphijp,-4);
        end
    end
    csfeature = sgfeature;
    %fragfeatures{m} = sgfeature;
%end

end

