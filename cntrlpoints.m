function [p1,p2,o1,o2] = cntrlpoints(x1,y1,x2,y2,spline)
    deltx=x2-x1;
    xm1=x1+deltx/3; %calculate x values of control points
    xm2=x1+(2*deltx/3);
    ym1=ppval(spline,xm1); %evaluate interpolated y values
    ym2=ppval(spline,xm2);
    %calculate control points
    f1=(1-(1/3))^3;
    f2=(1-(2/3))^3;
    f3=(2/3)^3;
    b1=ym1-y1*f1-y2/27;
    b2=ym2-y1*f2-f3*y2;
    c1=(-2*b1+b2)/-0.666666666666666666;
    c2=(b2 - 0.2222222222222 * c1) / 0.44444444444444444;
    %return control point coordinates
    p1=xm1;
    p2=c1;
    o1=xm2;
    o2=c2;
    %check for ill fitted splines and tame them
    while(abs(y1-p2)>10) 
        p2=y1-(y1-p2)/3-2;
    end
    while(abs(y2-o2)>10)
        o2=y2-(y2-o2)/3-2;
    end    
end
