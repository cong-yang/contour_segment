function [ csfeature ] = f_CS_15_Feature_CSS( ContourSegment )
%f_CS_15_Feature_CSS: this function is used to generate contour
%                     segment descriptor using Curvature Scale Space.
%   input: 
%         ContourSegment: a single contour segment
%   output:
%          csfeature: the contour segment feature using Curvature Scale Space.
%   description:
%          refer to the paper: 
%          A. Rattarangsi, et al., "Scale-based detection of corners of 
%          planar curves," PAMI, 1992.
%          http://www.ee.surrey.ac.uk/CVSSP/demos/segment/index.html

SIGMA_MAX = 120.0;
SIGMA_STEP = 0.1;
s_index = 1;

%preprocess the boundary
ContourSegment = circshift(ContourSegment, [0 1]);
[~, min_index] = min (ContourSegment(:,2));
ContourSegment = circshift(ContourSegment, [-(min_index-1) 0]);
cssi = {};

for sigma = 1.0 : SIGMA_STEP : SIGMA_MAX
%     isPlot = 0;
%     if DISPLAY_STEP > 0 && sigma > 1.0
%         p_index = ceil(sigma/DISPLAY_STEP);
%         if p_index == plot_index
%             plot_index = plot_index + 1;
%             isPlot = 1;
%             %display(p_index);
%         end
%     end
        
    zero_crossings = get_cssi_zero_crossings(sigma, ContourSegment);

    if size(zero_crossings,2) == 1 && zero_crossings(1) == -1
        %fprintf('--- sigma = %f generates no zero-crossings ---\n', sigma);
        break;    
    end
    
%     cssi(s_index).sigma = sigma;
%     cssi(s_index).zero_crossings = zero_crossings;
    cssi{s_index,1} = sigma;
    cssi{s_index,2} = zero_crossings;
        
    if sigma / 2 == ceil(sigma/2) 
        %fprintf('--- process sigma %f ---\n', sigma);
    end
       
    s_index = s_index + 1;
end

if 0
    for i = 1 : length(cssi)  
        x_range = cssi(i).zero_crossings;
        y_range = repmat(cssi(i).sigma,[1 length(x_range)]);
        plot(x_range,y_range,'.') ;     

        hold on;    
    end
end

curvatures = LineCurvature2D(ContourSegment);
%for selecting points,we only consier the points in the middle-grainded
if isempty(cssi)
    csfeature = 0;
else
    mylocation = round(size(cssi,1)/2);
    mypoints = cssi{mylocation,2};

    csfeature = curvatures(mypoints);
end

end