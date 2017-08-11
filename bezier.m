function [bezier] = bezier(x,y,imgdim, curve)
    %initialize some variables
    j=size(x,2);
    i=0;
    %normalize x and y values
    y=(imgdim(1)-(imgdim(1)*y/norm(y)));
    x=imgdim(2)/2+(imgdim(2)*x/norm(x));
    %start the svg string that will be outputted to file later
    svgattr=['<svg xmlns="http://www.w3.org/2000/svg" width="',num2str(x(end)+100),'" height="',num2str(y(end)+100),'" viewbox="100 100',num2str(x(end)),' ', num2str(y(end)),'" version="1.1">\n'];
    %bezierize the first couple points (has to be done because i-1 is
    %invalid when i<2)
    p=spline(x(1:3),y(1:3));
    [p1, p2, o1, o2]=cntrlpoints(x(1),y(1),x(2),y(2),p);
    curveseg=horzcat(['<path stroke="black" stroke-width="1" fill="none" d="','M',num2str(x(1)),',', num2str(y(1)),' C', num2str(p1),',', num2str(p2),' ', num2str(o1),',', num2str(o2),' ', num2str(x(2)),',',num2str(y(2)),'" />\n']);
    svgattr=strcat(svgattr,curveseg);
    [p1, p2, o1, o2]=cntrlpoints(x(2),y(2),x(3),y(3),p);
    curveseg=horzcat(['<path stroke="black" stroke-width="1" fill="none" d="','M',num2str(x(2)),',', num2str(y(2)),' C', num2str(p1),',', num2str(p2),' ', num2str(o1),',', num2str(o2),' ', num2str(x(3)),',',num2str(y(3)),'" />\n']);
    svgattr=strcat(svgattr,curveseg);
    for i=2:j-2
        %generate bezier curve between all of the other points
        pp=spline([x(i-1)-1 x(i) x(i+1)+1],y(i-1:i+1));
        [p1, p2, o1, o2]=cntrlpoints(x(i),y(i),x(i+1),y(i+1),pp);
        curveseg=horzcat(['<path stroke="black" stroke-width="1" fill="none" d="','M',num2str(x(i)),',', num2str(y(i)),' C', num2str(p1),',', num2str(p2),' ', num2str(o1),',', num2str(o2),' ', num2str(x(i+1)),',',num2str(y(i+1)),'" />\n']);
        svgattr=strcat(svgattr,curveseg);
    end
    p=spline(x(j-3:j),y(j-3:j));
    [p1, p2, o1, o2]=cntrlpoints(x(j-1),y(j-1),x(j),y(j),p);
    curveseg=horzcat(['<path stroke="black" stroke-width="1" fill="none" d="','M',num2str(x(j-1)),',', num2str(y(j-1)),' C', num2str(p1),',', num2str(p2),' ', num2str(o1),',', num2str(o2),' ', num2str(x(j)),',',num2str(y(j)),'" />\n']);
    svgattr=strcat(svgattr,curveseg);
    %add ending tag to svg string
    svgattr=strcat(svgattr,'</svg>');
    bezier=svgattr;
end
