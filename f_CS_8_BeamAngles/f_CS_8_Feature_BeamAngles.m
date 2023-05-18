function [ csfeature ] = f_CS_8_Feature_BeamAngles( ContourSegment )
%f_CS_8_Feature_BeamAngles: this function is used to generate contour
%                              segment descriptor using Beam Angles.
%   input: 
%         ContourSegment: a single contour segment
%   output:
%          csfeature: the contour segment feature using Beam Angles
%   description:
%          refer to the paper: 
%          Nadia Payet, et al., From a set of shapes to object 
%          discovery, ECCV 2010.

%Each contour point is characterized by the descriptor called 
%weighted Beam Angle Histogram (BAH).

numofbin = 12; %number of bins for BAH
k = 0.01; %the weight of angle theta_{ij} is computed as exp(-kj), j = 1,2,...,numofbin
mylength = size(ContourSegment,1);
csfeature = zeros(mylength,numofbin);

for i = 1:mylength
    px = ContourSegment(i,1);
    py = ContourSegment(i,2);
    for j = 1:numofbin
        %predecessor q
        indexq = i - j;
        if indexq <= 0
            indexq = 1;     
        end
        qx = ContourSegment(indexq,1);
        qy = ContourSegment(indexq,2);
    
        %successor r
        indexr = i + j;
        if indexr >= mylength
            indexr = mylength;
        end
        rx = ContourSegment(indexr,1);
        ry = ContourSegment(indexr,2);
        
        %calculate the beam angle qpr
        vpq = [px-qx, py-qy];
        vpr = [px-rx, py-ry];
        C = dot(vpq,vpr)/(norm(vpq)*norm(vpr));
        qpr = acos(C);
        
        myweight = exp(-k*j);
        csfeature(i,j) = qpr * myweight;
    end
end

csfeature(1,:)=[];
csfeature(mylength-1,:)=[];

end

