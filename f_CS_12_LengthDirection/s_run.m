function [ savestring ] = s_run( dataset, match, mylength )
%s_run: this function is used for triggering the experiment
%input:
%      dataset: 
%             1: Berkeley, 2: Sketching 3: mpeg
%      match: 
%             1:DTW,  2: DP,  3: Hungarian, 4: original
%      mylength:
%             1: L1, 2: L2,  3: L3, 4: L4

filetype = '.mat';

if dataset == 1
    foldername = 'BerkeleyCS';
    alldata = dir(fullfile(['../../database/Processed/',foldername,'/',foldername,'_PL/'],['*',filetype]));
    N = size(alldata,1);
    datalebel = 'Berkeley';
end
if dataset == 2
    foldername = 'SketchingCS';
    N = 10;
    datalebel = 'Sketching';
end
if dataset == 3
    foldername = 'MPEG7CS_Small';
    alldata = dir(fullfile(['../../database/Processed/',foldername,'/',foldername,'_PL/'],['*',filetype]));
    N = size(alldata,1);
    datalebel = 'MPEG7';
end

if mylength == 1
    sampercen = 0.25; %percentage of sample length to the original length
    samlabel = 'L1';
end
if mylength == 2
    sampercen = 0.5; %percentage of sample length to the original length
    samlabel = 'L2';
end
if mylength == 3
    sampercen = 0.75; %percentage of sample length to the original length
    samlabel = 'L3';
end
if mylength == 4
    sampercen = 1; %percentage of sample length to the original length
    samlabel = 'L4';
end

if match ==1
    matchlabel = 'DTW';
end
if match == 2
    matchlabel = 'DP';
end
if match == 3
    matchlabel = 'Hungarian';
end
if match == 4
    matchlabel = 'Original';
end
    

%---------------------------start matching---------------------------
if dataset == 1 %retrieval for BerkeleyCS dataset
    for i =1:N
        object1 = alldata(i,1).name;
        tempname =  regexp(object1,filetype,'split');
        objectname1 = tempname{1};
        display([num2str(i),': ',objectname1]);
        %load the pointlist of CS
        load(['../../database/Processed/',foldername,'/',foldername,'_PL/',object1]);
        pointlist1 = pointlist;
        fullfeatures = 0; %only for temp
        [matchingresult] = f_CS_12_Matching_LengthDirection(pointlist1, alldata, filetype, foldername, sampercen, match, fullfeatures);
%         TotalResults{1,1} = query;
%         TotalResults{1,2} = objectname1;
%         TotalResults{1,3} = matchingresult;
        TotalResults{i} = {objectname1,matchingresult};
%         myfolder = ['resources/Re-RichCS-',matchlabel,'-',datalebel,'-LengthDirection-',samlabel];
%         if exist(myfolder, 'dir')
%             save([myfolder,'/',num2str(query),'.mat'],'TotalResults');
%             savestring = ['Re-RichCS-',matchlabel,'-',datalebel,'-LengthDirection-',samlabel,'-',num2str(query),'.mat'];
%         else
%             mkdir(myfolder);
%             save([myfolder,'/',num2str(query),'.mat'],'TotalResults');
%             savestring = ['Re-RichCS-',matchlabel,'-',datalebel,'-LengthDirection-',samlabel,'-',num2str(query),'.mat'];
%         end
    end
    save(['resources/Re-RichCS-',matchlabel,'-',datalebel,'-LengthDirection-',samlabel,'.mat'],'TotalResults');
    savestring = ['Re-RichCS-',matchlabel,'-',datalebel,'-LengthDirection-',samlabel,'.mat'];
    clear TotalResults;
end

if dataset == 2 %retrieval for SketchingCS dataset
    [SketchingList] = f_objects_sketching();
     %load the features
    if mylength == 1
        load('resources/Feature-Sketching-LengthDirection-L1.mat');
    end
    if mylength == 2
        load('resources/Feature-Sketching-LengthDirection-L2.mat');
    end
    if mylength == 3
        load('resources/Feature-Sketching-LengthDirection-L3.mat');
    end
    if mylength == 4
        load('resources/Feature-Sketching-LengthDirection-L4.mat');
    end
    
    for i = 1:N
        object1 = SketchingList{i,1};
        tempname =  regexp(object1,filetype,'split');
        objectname1 = tempname{1};
        [objectid] = f_get_SketchingID(objectname1);
        display([num2str(i),': ',objectname1]);
        pointlist1 = fullfeatures{objectid}; %give the feature to pointlist1
        alldata = SketchingList{i,2};
        [matchingresult] = f_CS_12_Matching_LengthDirection(pointlist1, alldata, filetype, foldername, sampercen, match, fullfeatures);
        TotalResults{i} = {objectname1,matchingresult};
    end
    save(['resources/Re-RichCS-',matchlabel,'-',datalebel,'-LengthDirection-',samlabel,'.mat'],'TotalResults');
    savestring = ['Re-RichCS-',matchlabel,'-',datalebel,'-LengthDirection-',samlabel,'.mat'];
    clear TotalResults;
end

if dataset == 3 %retrieval for MPEG7CS dataset   
    %first step: load the features
    if mylength == 1
        load('resources/Feature-MPEG7-LengthDirection-L1.mat');
    end
    if mylength == 2
        load('resources/Feature-MPEG7-LengthDirection-L2.mat');
    end
    if mylength == 3
        load('resources/Feature-MPEG7-LengthDirection-L3.mat');
    end
    if mylength == 4
        load('resources/Feature-MPEG7-LengthDirection-L4.mat');
    end
    
    %second step, do the retrieval
    tic;
    for i =1:N
        object1 = alldata(i,1).name;
        tempname =  regexp(object1,filetype,'split');
        objectname1 = tempname{1};
        display([num2str(i),': ',objectname1]);
        pointlist1 = fullfeatures{i};
        [matchingresult] = f_CS_12_Matching_LengthDirection(pointlist1, alldata, filetype, foldername, sampercen, match, fullfeatures);
        TotalResults{i} = {objectname1,matchingresult};
%         TotalResults{1,1} = query;
%         TotalResults{1,2} = objectname1;
%         TotalResults{1,3} = matchingresult;
%         myfolder = ['resources/Re-RichCS-',matchlabel,'-',datalebel,'-LengthDirection-',samlabel];
%         if exist(myfolder, 'dir')
%             save([myfolder,'/',num2str(query),'.mat'],'TotalResults');
%             savestring = ['Re-RichCS-',matchlabel,'-',datalebel,'-LengthDirection-',samlabel,'-',num2str(query),'.mat'];
%         else
%             mkdir(myfolder);
%             save([myfolder,'/',num2str(query),'.mat'],'TotalResults');
%             savestring = ['Re-RichCS-',matchlabel,'-',datalebel,'-LengthDirection-',samlabel,'-',num2str(query),'.mat'];
%         end
    end
    mytime = toc;
    save(['resources\Re-RichCS-',matchlabel,'-',datalebel,'-LengthDirection-',samlabel,'.mat'],'TotalResults');
    save(['resources\Time-RichCS-',matchlabel,'-',datalebel,'-LengthDirection-',samlabel,'.mat'],'mytime');
    savestring = ['Re-RichCS-',matchlabel,'-',datalebel,'-LengthDirection-',samlabel,'.mat'];
end

end
