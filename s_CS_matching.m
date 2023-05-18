clear all;

%load contour segments
load('cs1.mat');
load('cs2.mat');

%generate features
[csfeature1] = f_CS_1_Feature_Simples(cs1, 'area');
[csfeature2] = f_CS_1_Feature_Simples(cs2, 'area');

%calculate similarity
[similarity] = f_CS_1_Matching_Simples(csfeature1, csfeature2, 'area');

