
clear all; close all; clc
Raisin=xlsread('Raisin_Dataset.xlsx');
training = Raisin(:,1:7);
label = Raisin(:,9);
nocameo = sum(label==1);
noosci = length(label) - nocameo;
t_test_c = training(1:(nocameo*0.8),:);
t_validation_c = training(((nocameo*0.8)+1):nocameo, :);
l_test_c = label(1:(nocameo*0.8),:);
l_validation_c = label(((nocameo*0.8)+1):nocameo, :);

t_test_o = training((nocameo+1):(nocameo+(noosci*0.8)),:);
t_validation_o = training((nocameo+(noosci*0.8)):end, :);
l_test_o = label((nocameo+1):(nocameo+(noosci*0.8)),:);
l_validation_o = label((nocameo+(noosci*0.8)):end, :);
t_test = [t_test_c;t_test_o];
l_test = [l_test_c;l_test_o];
t_validation = [t_validation_c;t_validation_o];
l_validation = [l_validation_c;l_validation_o];
%shuffling
randperm_test = randperm(length(l_test));
t_test = t_test(randperm_test,:);
l_test = l_test(randperm_test,:);
randperm_validation = randperm(length(l_validation));
t_validation = t_test(randperm_validation,:);
l_validation = l_test(randperm_validation,:);
D.t_test = t_test;
D.l_test = l_test;
D.t_validation = t_validation;
D.l_validation = l_validation;
D.training =  training;
D.label =  label;
save('Data.mat','D')
fprintf('Creating data set completed !\n');
