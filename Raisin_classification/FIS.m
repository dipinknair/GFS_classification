
function  [fis_out] = FIS( vertices1 , vertices2, vertices3, rules, LB1, UB1, LB2, UB2, x1, x2)

%input 1 membership function
vertices1 = sort(vertices1);
Mu1(1) = lshlder(x1,LB1,vertices1(2),LB1);
%vertices1(2:4) = sort(vertices1(2:4));
Mu1(2) = triangle(x1,vertices1(1),vertices1(3),vertices1(5));
Mu1(3) = rshlder(x1,UB1,UB1,vertices1(4));

%old code commented for sorting overlap
% Mu1(1) = lshlder(x1,LB1,vertices1(1),LB1);
% vertices1(2:4) = sort(vertices1(2:4));
% Mu1(2) = triangle(x1,vertices1(2),vertices1(3),vertices1(4));
% Mu1(3) = rshlder(x1,UB1,UB1,vertices1(end));

%input 2 membership function
vertices2 = sort(vertices2);
Mu2(1) = lshlder(x2,LB2,vertices2(2),LB2);
%vertices2(2:4) = sort(vertices2(2:4));
Mu2(2) = triangle(x2,vertices2(1),vertices2(3),vertices2(5));
Mu2(3) = rshlder(x2,UB2,UB2,vertices2(4));


%ouput membership function
vertices3 = sort(vertices3);
Mo(1).v = [0,0, vertices3(2)];
Mo(2).v = [vertices3(1),1, 1];

% Rules grid for FIS
T=[];
for i = 1:3
    for j = 1:3
        T(((i-1)*3)+ j) = min(Mu1(i), Mu2(j));%min(Mu(i,j),Mu(i,j+1));
    end
end

%defuzzification
A = [];
weighted = [];
for m = 1:9
    A(m) = 0.5*T(m)*(Mo(rules(m)).v(3)-Mo(rules(m)).v(1));
    weighted(m) = A(m)*Mo(rules(m)).v(2);
end

Union_Areas = sum(A);
fis_out = sum(weighted)/Union_Areas;
    
end