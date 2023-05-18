function [ AreaValue ] = f_Get_Region_Area( Path, MatrixGraph)
%get_region_area_new: get region area of the object's contour
%   input:
%         Path: contour points list
%         MatrixGraph: reconstructed matrix based on the Path
%   output:
%         AreaValue: area value

[temnumber,~] = size(Path);
%plot(Path(1,1),Path(1,2),'+g'); 
%plot(Path(temnumber,1),Path(temnumber,2),'+g'); 

%connect the two start and end points on curve.
endx3 = Path(1,1);
endy3 = Path(1,2);
endx4 = Path(temnumber,1);
endy4 = Path(temnumber,2);

% for x = min(endx3,endx4):max(endx3,endx4)
%     y = ((endy3-endy4)/(endx3-endx4))*x + (endy3-((endy3-endy4)*endx3)/(endx3-endx4));
%     y = round(y);
%     plot(x,y,'*r');
% end
% hold off;

%insert the put to the point list
if endx3 ~= endx4
    for x = min(endx3,endx4):max(endx3,endx4)
        y = ((endy3-endy4)/(endx3-endx4))*x + (endy3-((endy3-endy4)*endx3)/(endx3-endx4));
        y = round(y);
        MatrixGraph(y,x) = 1;
    end
end

if endy3 ~= endy4
    for y = min(endy3,endy4):max(endy3,endy4)
        x = ((endx3-endx4)/(endy3-endy4))*y + (endx3-((endx3-endx4)*endy3)/(endy3-endy4));
        x = round(x);
        MatrixGraph(y,x) = 1;
    end
end

%figure,imshow(MatrixGraph);

FilledGraph = imfill(MatrixGraph,'holes');

%get the area
AreaValue = 0;
for mm = 1:size(FilledGraph,1)
    for kk = 1:size(FilledGraph,2)
        if FilledGraph(mm,kk) == 1
            AreaValue = AreaValue + 1;
        end
    end
end
%display(AreaValue);
%figure,imshow(FilledGraph);

AreaValue = AreaValue/temnumber; %normalize the area value with the path length
end

