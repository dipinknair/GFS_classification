function [x1,y1,y2,y3,lb,ub] = plotimf(vertices,lb, ub)

%figure()

vertices = sort(vertices);
%lb = vertices(1);
%ub = vertices(end);
div = (ub-lb)/10000;
x1 = ((lb-(lb*0.2)):div:(ub+(ub*0.20)))';
for i=1:length(x1)
    y1(i) = lshlder(x1(i),lb,vertices(2),lb-(lb*0.2)); %center right left
    y2(i) = triangle(x1(i),vertices(1),vertices(3),vertices(5));
    y3(i) = rshlder(x1(i),ub,ub+(ub*0.20),vertices(4));
end
y1 = y1';
y2 = y2';
y3 = y3';