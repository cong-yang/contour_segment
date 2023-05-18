function [ OrderedMatchingResults ] = f_result_ranking( MatchingResult, mylength, model )
%f_result_ranking: to rank the result based on the value of similarity
%   input:
%        MatchingResult: original matching result
%        mylength: number of queries
%        model: selects the direction of the sort: descend or ascend
%   output:
%        OrderedMatchingResults: ordered matching result

%rank results
[~,order] = sort(cellfun(@(v) v{2}, MatchingResult),model); %ascend, descend
MatchingRankedRestlts = MatchingResult(order);

OrderedMatchingResults={};
% tempindex = ObjectListSize;
% for ii = 1:ObjectListSize
%     OrderedMatchingResults{tempindex} = MatchingRankedRestlts{ii};
%     tempindex = tempindex - 1;
% end

tempindex = 1;
for ii = 1:mylength
    OrderedMatchingResults{tempindex} = MatchingRankedRestlts{ii};
    tempindex = tempindex + 1;
end


end

