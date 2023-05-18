load('MisS.mat');
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
            [savestring] = s_run( datalable, matchlabel, lengthlable, missed(j) );
        end
    end
end