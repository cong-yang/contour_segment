function [ SketchingList ] = f_objects_sketching()
%the 1st group A1	E2	A2	B2	I1
SketchingList{1,1} = 'A1.mat';
alldata(1,1).name = 'E2.mat';
alldata(2,1).name = 'A2.mat';
alldata(3,1).name = 'B2.mat';
alldata(4,1).name = 'I1.mat';
SketchingList{1,2} = alldata;
clear alldata;

%the 2nd group B1	B2	C1	J1	F1
SketchingList{2,1} = 'B1.mat';
alldata(1,1).name = 'B2.mat';
alldata(2,1).name = 'C1.mat';
alldata(3,1).name = 'J1.mat';
alldata(4,1).name = 'F1.mat';
SketchingList{2,2} = alldata;
clear alldata;

%the 3rd group C1	F1	F2	I1	C2
SketchingList{3,1} = 'C1.mat';
alldata(1,1).name = 'F1.mat';
alldata(2,1).name = 'F2.mat';
alldata(3,1).name = 'I1.mat';
alldata(4,1).name = 'C2.mat';
SketchingList{3,2} = alldata;
clear alldata;

%the 4th group D1	D2	C1	B2	J1
SketchingList{4,1} = 'D1.mat';
alldata(1,1).name = 'D2.mat';
alldata(2,1).name = 'C1.mat';
alldata(3,1).name = 'B2.mat';
alldata(4,1).name = 'J1.mat';
SketchingList{4,2} = alldata;
clear alldata;

%the 5th group E1	F1	E2	D2	J1
SketchingList{5,1} = 'E1.mat';
alldata(1,1).name = 'F1.mat';
alldata(2,1).name = 'E2.mat';
alldata(3,1).name = 'D2.mat';
alldata(4,1).name = 'J1.mat';
SketchingList{5,2} = alldata;
clear alldata;

%the 6th group F1	I1	I2	G1	F2
SketchingList{6,1} = 'F1.mat';
alldata(1,1).name = 'I1.mat';
alldata(2,1).name = 'I2.mat';
alldata(3,1).name = 'G1.mat';
alldata(4,1).name = 'F2.mat';
SketchingList{6,2} = alldata;
clear alldata;

%the 7th group G1	I1	J2	G2	J1
SketchingList{7,1} = 'G1.mat';
alldata(1,1).name = 'I1.mat';
alldata(2,1).name = 'J2.mat';
alldata(3,1).name = 'G2.mat';
alldata(4,1).name = 'J1.mat';
SketchingList{7,2} = alldata;
clear alldata;

%the 8th group H1	J1	H2	G1	G2
SketchingList{8,1} = 'H1.mat';
alldata(1,1).name = 'J1.mat';
alldata(2,1).name = 'H2.mat';
alldata(3,1).name = 'G1.mat';
alldata(4,1).name = 'G2.mat';
SketchingList{8,2} = alldata;
clear alldata;

%the 9th group I1	B2	I2	E2	G1
SketchingList{9,1} = 'I1.mat';
alldata(1,1).name = 'B2.mat';
alldata(2,1).name = 'I2.mat';
alldata(3,1).name = 'E2.mat';
alldata(4,1).name = 'G1.mat';
SketchingList{9,2} = alldata;
clear alldata;

%the 10th group J1	G2	J2	G1	E1
SketchingList{10,1} = 'J1.mat';
alldata(1,1).name = 'G2.mat';
alldata(2,1).name = 'J2.mat';
alldata(3,1).name = 'G1.mat';
alldata(4,1).name = 'E1.mat';
SketchingList{10,2} = alldata;
clear alldata;
end

