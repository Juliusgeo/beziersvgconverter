clear imgx imgy imgcurve image s k
%open image
image=imread('l.jpg');
%make it black and white
image=im2bw(image);
%define dimensions to be used in later functions
imagedim=size(image);
%define how wide between each x input to be used in decloud.m
step=round(imagedim(2)/2);
%apply imgcurve to image
[imgx, imgy]=imgcurve(image);
%decloud curve
curvez=decloud(imgx*5, imgy, step);
%make sure there are no duplicate points
curve=unique(curvez(:,:),'rows');

%graph a scatter plot of all points in curve, and then prompt the user to
%order them by polling mouse input
scatter(curve(:,1), curve(:,2));
title('Click to define critical points, hit enter to finish');
h=gcf;
dcm_obj=datacursormode(h);
set(dcm_obj, 'DisplayStyle','datatip','Enable','on','SnapToDataVertex','on');
[xm, ym]=ginput();
x=[];
y=[];
%find the closest point in the curve array to each of the points selected
%in previous section
for o=1:1:size(xm)
    kk=(curve(:,1)-xm(o)).^2;
    ll=(curve(:,2)-ym(o)).^2;
    [~, d] = min(sqrt(kk+ll));
    x_c = curve(d,1); %extract
    y_c = curve(d,2);
    x=[x, x_c];
    y=[y, y_c];
end
y=y-min(y);
for i=1:size(x)
    plot(x, y, 'x');
    axis([0 2000 0 285]);
end
%construct beziers
out=bezier(x,y, imagedim, curve);
%output to file
fid = fopen('output.svg','wt');
fprintf(fid, out);
fclose(fid);
fprintf('SVG exported...');
open('output.svg');