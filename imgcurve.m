function [imgcurvex, imgcurvey] = imgcurve(img)
    %stores all of the black pixels' coordinates in the image into curvex and curvey
    imgcurve=[];
    x=size(img,2);
    y=size(img,1);
    xx=[];
    yy=[];
    for i=1:1:x
        for n=1:1:y
            if img(n,i)==0
                xx=[xx i];
                yy=[yy n];

            end
        end
    end   
    imgcurvex=xx;
    imgcurvey=y-yy;
end
