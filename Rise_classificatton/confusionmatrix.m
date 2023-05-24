function [Q] = confusionmatrix(predicted,true)
%CONFUSTION_MATRIX Summary of this function goes here
% Detailed explanation goes here

m=1;
for i = 1:2
    k=1;
    for j = 1:2  
        Q(i,j) = sum((true==m & predicted==k));
        k = k-1;
    end
    m =m-1;
end

