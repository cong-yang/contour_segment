clear all;

load('G:\Matlab-Experiment\Contour Segments\database\Processed\BerkeleyCS\BerkeleyCS_PL\applelogos1.mat');
apple1 = pointlist;
load('G:\Matlab-Experiment\Contour Segments\database\Processed\BerkeleyCS\BerkeleyCS_PL\applelogos2.mat');
apple2 = pointlist;

clear pointlist;

% [csfeature1] = f_CS_1_Feature_Simples(apple1, 'eccentricity');
% [csfeature2] = f_CS_1_Feature_Simples(apple2, 'eccentricity');
% 

[csfeature1] = f_CS_16_Feature_Complexity(apple1);
[csfeature2] = f_CS_16_Feature_Complexity(apple2);