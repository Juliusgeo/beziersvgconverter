function [decloudcurve] = decloud(curvex, curvey, step)
    %initialize variables
    curve=[];
    n=[];
    zu=[];
    %create the combined curve array from curvex and curvey
    for i=1:1:size(curvex,2)
        curve=[curve; curvex(i) curvey(i)];
    end
    %main decloud loop
    for x=1:step:size(curve(:,1))
        %create array of all indexes of x values that are the same as
        %current x value
        n=find(curve(:,1)==curve(x,1));
        %initialize cell array of all y clusters for current x value
        ns={};
        %finds the difference between each adjecent point, stores all of
        %the indexes of all the breakpoints
        diffs=abs(diff(curve(n,2)));
        zs=find(diffs>1);
        if(size(zs,1)<1)
            %sets ns to n if there are no breakpoints
            ns=[ns; {n}];
        else
            %stores each cluster array in ns for each breakpoint
            brpt=1;
            u=1;
            nseval='ns=[';
            for k=1:1:size(zs,1)
                u=zs(k);
                nseval=strcat(nseval,' {n(',num2str(brpt),':1:',num2str(u),')}');
                brpt=u+1;
            end
            nseval=strcat(nseval, ' {n(',num2str(brpt),':1:',num2str(size(n,1)),')}];');
            eval(nseval);
        end
        %saves the average of each respective y cluster with the current x
        %value
        for t=1:1:size(ns,2)
            zu=[zu; x mean(curve(ns{t},2))];  
        end
    end
    decloudcurve=zu;
end
