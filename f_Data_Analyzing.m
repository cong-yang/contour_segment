function [ bullseye ] = f_Data_Analyzing( TotalResults, topcount)
%f_Data_Analyzing This function is used for calculate the corrected matches
%and the bulls eye score
%Input:
%      TotalResults: retrieval results
%      New_Diff: the affinity matrix of similarity between each pair of
%                objects.
%      nrobjectsperclass: The number of objects per class
%      nrofmatches: The number of matches thar should be conidered as correct.
%                   nrofmatches > nrobjectsperclass
%      topcount: to print the number of correct matches among the topcount
%                position.
%Output:
%       bullseye: score of bulls eye test

bullseye = 0;

[~,querysize] = size(TotalResults);
ResultMatrix = zeros(topcount,querysize);
for mm = 1: querysize
    queryname = TotalResults{mm}{1};
    tempcategory = regexp(queryname,'\d*','split');
    category = tempcategory{1};
    if strcmp(category,'device')
        category = queryname(1:7);
    end
    %display(category{1});
    MatchingResults = TotalResults{mm}{2};
    for kk = 1: topcount
        objectname = MatchingResults{kk}{1};
        tempobjectname = regexp(objectname,'\d*','split');
        objectcategory = tempobjectname{1};
        if strcmp(objectcategory,'device')
            objectcategory = objectname(1:7);
        end
        if strcmp(objectcategory,category) == 1
            ResultMatrix(kk,mm) = 1;
        end
    end
end

showingresult = zeros(topcount,2);
for i = 1:topcount
    showingresult(i,1) = i;
    showingresult(i,2) = sum(ResultMatrix(i,:));
end
% display(showingresult);
% display(size(showingresult,1));

for m = 1:topcount
    display(strcat(num2str(showingresult(m,1)),'=',num2str(showingresult(m,2)),','));
    
end

%start to calculate score
% mydiff = 1/topcount;
% mytwic = 1;
% for m = 1:topcount
%     bullseye = bullseye + (showingresult(m,2)/100)*mytwic;
%     mytwic = mytwic - mydiff;
% end

%calculate the bulls eye score
for m = 1:topcount
    bullseye = bullseye + showingresult(m,2);
end

bullseye = bullseye/28000;

display(bullseye);

end

