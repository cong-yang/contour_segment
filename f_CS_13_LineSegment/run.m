for i = 2:2
    for j = 1:4
        for k = 1:4
            display(['task: ',num2str(i),'-',num2str(j),'-',num2str(k)]);
            [ savestring ] = s_run( i, j, k );
            display(savestring);
        end
    end
end