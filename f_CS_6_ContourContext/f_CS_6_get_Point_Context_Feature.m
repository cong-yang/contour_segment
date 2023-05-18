function [ PointContextFeature, mean_dist] = f_CS_6_get_Point_Context_Feature( PointX, PointY, ContourPointList, nbins_theta, nbins_r, mean_dist)
%f_Point_Context to calculate the point context feature for p(PointX, PointY)
%   Input:
%         PointX: x-axis of the interesting point
%         PointY: y-axis of the interesting point
%         ShapeContour: Shape Contour Matrix
%         nbins_theta: number of bins for theta log-polar histogram
%         nbins_r: number of bins for log(r) log-polar histogram
%         global_mean_dist: for normalization
%   Output:
%         PointContextFeature: Point context features, with 
%                              nbins_theta x nbins_r dimension

Bsamp = ContourPointList'; %sample points. (x and y coords.)
nsamp = size(ContourPointList,1); %number of points on model data
r_inner = 1/8;
r_outer = 2;
out_vec = zeros(1,nsamp);
Tsamp = zeros(1,nsamp);

nsamp = size(Bsamp,2);
in_vec = out_vec == 0;

% compute r,theta arrays
r_array = real(sqrt(f_dist2(Bsamp',Bsamp'))); % real is needed to
                                          % prevent bug in Unix version
theta_array_abs = atan2(Bsamp(2,:)'*ones(1,nsamp)-ones(nsamp,1)*Bsamp(2,:),Bsamp(1,:)'*ones(1,nsamp)-ones(nsamp,1)*Bsamp(1,:))';
theta_array = theta_array_abs - Tsamp'*ones(1,nsamp);

% create joint (r,theta) histogram by binning r_array and
% theta_array

% normalize distance by mean, ignoring outliers
if isempty(mean_dist)
   tmp=r_array(in_vec,:);
   tmp=tmp(:,in_vec);
   mean_dist = mean(tmp(:));
end
r_array_n = r_array/mean_dist;

% use a log. scale for binning the distances
r_bin_edges = logspace(log10(r_inner),log10(r_outer),5);
r_array_q = zeros(nsamp,nsamp);
for m=1:nbins_r
   r_array_q=r_array_q+(r_array_n<r_bin_edges(m));
end
fz = r_array_q > 0; % flag all points inside outer boundary

% put all angles in [0,2pi) range
theta_array_2 = rem(rem(theta_array,2*pi)+2*pi,2*pi);
% quantize to a fixed set of angles (bin edges lie on 0,(2*pi)/k,...2*pi
theta_array_q = 1+floor(theta_array_2/(2*pi/nbins_theta));

nbins = nbins_theta * nbins_r;
%BH = zeros(nsamp,nbins);
PointContextFeature = zeros(1, nbins);

for n=1:nsamp
    if ContourPointList(n,1) == PointX && ContourPointList(n,2) == PointY
        fzn = fz(n,:)&in_vec;
        Sn = sparse(theta_array_q(n,fzn),r_array_q(n,fzn),1,nbins_theta,nbins_r);
        %BH(n,:) = Sn(:)';
        PointContextFeature(1,1:nbins) = Sn(:)';
        %display(ContourPointList(n,1));
    end
end

end

