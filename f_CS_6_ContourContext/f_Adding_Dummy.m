function [ NewCostMatrix ] = f_Adding_Dummy(CostMatrix)
%f_Adding_Dummy: this function is used for adding dummy rows to make sure
%costmatrix has same number of rows and columns
%Input: CostMatrix
%Output: NewCostMatrix with the adding dummies

nsamp1 = size(CostMatrix,1); %number of rows
nsamp2 = size(CostMatrix,2); %number of columns
ndum1 = 0; %number of dummy points need to be added for model data
ndum2 = 0; %number of dummy points need to be added for target data
eps_dum = sum(sum(CostMatrix))/(nsamp1*nsamp2);

if nsamp2 > nsamp1 %if number of column is bigger than rows, add row
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

