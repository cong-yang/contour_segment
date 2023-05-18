function [ NewCostMatrix ] = f_Adding_Dummy( Object1, Object2, CostMatrix)
%f_Adding_Dummy: this function is used for adding dummy rows to make sure
%costmatrix has same number of rows and columns
%Input: Object1, Object2, CostMatrix
%Output: NewCostMatrix with the adding dummies

nsamp1 = size(Object1,1);
nsamp2 = size(Object2,1);
ndum1 = 0; %number of dummy points need to be added for model data
ndum2 = 0; %number of dummy points need to be added for target data
eps_dum = 0.15;

if nsamp2 > nsamp1
   ndum1 = ndum1 + (nsamp2 - nsamp1);
   nptsd = nsamp1 + ndum1;
   NewCostMatrix = eps_dum * ones(nptsd,nptsd);
   NewCostMatrix(1:nsamp1,1:nsamp2) = CostMatrix;
end

if nsamp2 < nsamp1
    ndum2 = ndum2 + (nsamp1 - nsamp2);
    nptsd = nsamp2 + ndum2;
    NewCostMatrix = eps_dum * ones(nptsd,nptsd);
    NewCostMatrix(1:nsamp1,1:nsamp2) = CostMatrix;
end

if nsamp2 == nsamp1
    NewCostMatrix = CostMatrix;
end

end

