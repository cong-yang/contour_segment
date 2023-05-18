function [ OrderedMatchingResults ] = f_CS_7_Matching_TurningAngles_cssh( pointlist1, alldata, filetype, foldername, sampercen, match, fullfeatures )
%f_CS_7_Matching_TurningAngles_cssh: do the matching with matrix algorithm and output the 
%                               ranked final result
%   input:
%         pointlist1: the first point list (query)
%         alldata: list of all object
%         filetype: the loaded file type
%         foldername: folder name for loading the point list
%         sampercen: percent for sampling points
%         match: matching method
%         fullfeatures: full features, only works for mpeg7 dataset
%   output:
%         OrderedMatchingResults: ordered matching results

mylength = length(alldata);
for i = 1:mylength
    object2 = alldata(i,1).name;
    tempname =  regexp(object2,filetype,'split');
    objectname2 = tempname{1};
    
    if mylength == 1400 %only work for MPEG7
        %since the features have been calculated, we just call it
        csfeature1 = pointlist1;
        csfeature2 = fullfeatures{i};
    else
        if mylength == 271 %only work for Berkely
            %display(['  --->',num2str(i),': ',objectname2]);
            %load the pointlist of CS
            load(['../../database/Processed/',foldername,'/',foldername,'_PL/',object2]);
            pointlist2 = pointlist;
            %get the sample points based on samlength
            pointnum1 = round(size(pointlist1,1)*sampercen);
            pointnum2 = round(size(pointlist2,1)*sampercen);

            if pointnum1 < pointnum2
                sampoint1 = f_sample_Points(pointlist1, pointnum1);
                sampoint2 = f_sample_Points(pointlist2, pointnum1);
            else
                sampoint1 = f_sample_Points(pointlist1, pointnum2);
                sampoint2 = f_sample_Points(pointlist2, pointnum2);
            end

            [csfeature1] = f_CS_7_Feature_TurningAngles(sampoint1);
            [csfeature2] = f_CS_7_Feature_TurningAngles(sampoint2);
        else %only works for Sketching
             display(['  --->',num2str(i),': ',objectname2]);
            [objectid] = f_get_SketchingID(objectname2);
            csfeature1 = pointlist1;
            csfeature2 = fullfeatures{objectid};
        end
    end


    if match == 1 %the correlation matching algorithm
        [similarity] = f_CS_7_Similarity_cssh(csfeature1, csfeature2, 'correlation');
    end
    
    if match == 2 %the DP matching algorithm
        [similarity] = f_CS_7_Similarity_cssh(csfeature1, csfeature2, 'intersection');
    end
    
    if match == 3 %the hungarian matching algorithm
        [similarity] = f_CS_7_Similarity_cssh(csfeature1, csfeature2, 'statistics');
    end
    
    if match == 4 %the hungarian matching algorithm
        [similarity] = f_CS_7_Similarity_cssh(csfeature1, csfeature2, 'hellinger');
    end

    MatchingResult{i} = {objectname2, similarity};
end

[OrderedMatchingResults] = f_result_ranking(MatchingResult,mylength, 'descend');
end

