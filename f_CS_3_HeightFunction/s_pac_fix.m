%this script is used to fix the ungeneraged quries and then package the
%results into one TotalResults
clear all;
descriptor = 'HeightFunction';
boolpackaging = 0;

display('Start to check.......');
taskes{1} = ['Re-RichCS-DP-Berkeley-',descriptor,'-L1'];
taskes{2} = ['Re-RichCS-DP-Berkeley-',descriptor,'-L2'];
taskes{3} = ['Re-RichCS-DP-Berkeley-',descriptor,'-L3'];
taskes{4} = ['Re-RichCS-DP-Berkeley-',descriptor,'-L4'];

taskes{5} = ['Re-RichCS-DP-MPEG7-',descriptor,'-L1'];
taskes{6} = ['Re-RichCS-DP-MPEG7-',descriptor,'-L2'];
taskes{7} = ['Re-RichCS-DP-MPEG7-',descriptor,'-L3'];
taskes{8} = ['Re-RichCS-DP-MPEG7-',descriptor,'-L4'];

taskes{9} = ['Re-RichCS-DTW-Berkeley-',descriptor,'-L1'];
taskes{10} = ['Re-RichCS-DTW-Berkeley-',descriptor,'-L2'];
taskes{11} = ['Re-RichCS-DTW-Berkeley-',descriptor,'-L3'];
taskes{12} = ['Re-RichCS-DTW-Berkeley-',descriptor,'-L4'];

taskes{13} = ['Re-RichCS-DTW-MPEG7-',descriptor,'-L1'];
taskes{14} = ['Re-RichCS-DTW-MPEG7-',descriptor,'-L2'];
taskes{15} = ['Re-RichCS-DTW-MPEG7-',descriptor,'-L3'];
taskes{16} = ['Re-RichCS-DTW-MPEG7-',descriptor,'-L4'];

taskes{17} = ['Re-RichCS-Hungarian-Berkeley-',descriptor,'-L1'];
taskes{18} = ['Re-RichCS-Hungarian-Berkeley-',descriptor,'-L2'];
taskes{19} = ['Re-RichCS-Hungarian-Berkeley-',descriptor,'-L3'];
taskes{20} = ['Re-RichCS-Hungarian-Berkeley-',descriptor,'-L4'];

taskes{21} = ['Re-RichCS-Hungarian-MPEG7-',descriptor,'-L1'];
taskes{22} = ['Re-RichCS-Hungarian-MPEG7-',descriptor,'-L2'];
taskes{23} = ['Re-RichCS-Hungarian-MPEG7-',descriptor,'-L3'];
taskes{24} = ['Re-RichCS-Hungarian-MPEG7-',descriptor,'-L4'];

filetype = '.mat';
for i = 1:length(taskes)
    myfolder = taskes{i};
    alldata = dir(fullfile(['resources/',myfolder,'/'],['*',filetype]));
    N = size(alldata,1);
    findit = strfind(myfolder,'Berkeley'); %to check the database name
    if isempty(findit)
        fulllength = 1400;
    else
        fulllength = 271;
    end
    %creat the full object list name
    fullname = linspace(1,fulllength,fulllength);
    %if there are some object in the folder,do the checking
    if isempty(alldata) == 0
        for j = 1:N
            myobject = alldata(j,1).name;
            tempname =  regexp(myobject,filetype,'split');
            objectname = tempname{1};
            mynumber = str2num(objectname);
            %display(mynumber);
            if mynumber <= fulllength
                fullname(mynumber) = 0;
            else
                display(['error........',num2str(mynumber)]);
            end
        end
        missedname = find(fullname ~= 0);
        MISS{i,1} = myfolder;
        MISS{i,2} = missedname;
    end
    display([myfolder,': ',num2str(length(missedname))]);
end

save('resources/MISS.mat','MISS');
display('Checking is Finished!');

%%
%generate text file and packaging
if boolpackaging
display('Start to packaging');
fid = fopen('resources/MISS.txt', 'wt');
for i = 1:length(MISS)
    myname = MISS{i,1};
    missed = MISS{i,2};
    finddatabase = strfind(myname,'Berkeley'); %to check the database name
    
    findmatch1 = strfind(myname,'DTW'); %to check the matching method
    findmatch2 = strfind(myname,'DP'); %to check the matching method
    findmatch3 = strfind(myname,'Hungarian'); %to check the matching method
    
    findlength1 = strfind(myname,'L1'); %to check the length
    findlength2 = strfind(myname,'L2'); %to check the length
    findlength3 = strfind(myname,'L3'); %to check the length
    findlength4 = strfind(myname,'L4'); %to check the length
    
    %check the datalabel
    if isempty(finddatabase) %if it is not Berkeley, then MPEG7
        datalable = 2; %MPEG7
    else
        datalable = 1; %Berkeley
    end
    
    %check the matching label
    if isempty(findmatch1) == 0 % DTW method
        matchlabel = 1;
    end
    if isempty(findmatch2) == 0 % DP method
        matchlabel = 2;
    end
    if isempty(findmatch3) == 0 % DP method
        matchlabel = 3;
    end
    
    %check the length label
    if isempty(findlength1) == 0 % L1
        lengthlable = 1;
    end
    if isempty(findlength2) == 0 % L2
        lengthlable = 2;
    end
    if isempty(findlength3) == 0 % L3
        lengthlable = 3;
    end
    if isempty(findlength4) == 0 % L4
        lengthlable = 4;
    end
    
    if isempty(missed) == 0 %if there are some missing data
        display([myname,' has ',num2str(length(missed)), ' quries unfinishd']);
        for j = 1:length(missed)
            fprintf( fid, '%d,%d,%d,%d\n', datalable, matchlabel, lengthlable, missed(j));
        end
    else
        %start to packaging them into one file
        alldata = dir(fullfile(['resources/',myname,'/'],['*',filetype]));
        N = length(alldata);
        for j = 1:N
            myobject = alldata(j,1).name;
            tempname =  regexp(myobject,filetype,'split');
            objectname = tempname{1};
            load(['resources/',myname,'/',myobject]);
            if datalable == 1
                myresult = TotalResults{str2num(objectname)};
            else
                myresult{1,1} = TotalResults{1,2};
                myresult{1,2} = TotalResults{1,3};
            end
            if mod(str2num(objectname),10) == 0
                display(['Packaging ',objectname,' to ', myname]);
            end
            AllResults{str2num(objectname)} = myresult;
            clear myresult;
        end
        save(['resources/',myname,'.mat'],'AllResults');
        AllResults = [];
        display([myname,' is finished!']);
    end
end
fclose(fid);
end
