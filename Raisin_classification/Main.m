% main 
% 

clear
clc
close all
tic;
%% Loading data

fprintf('Loading data ...\n')
load Data.mat;
Epochs = 1;
% D.t_test = D.training;
% D.l_test = D.label;
for i=1:Epochs-1
    D.t_test = [D.t_test; D.t_test];
    D.l_test = [D.l_test; D.label];
end


for i = 1:7
    P.lb(i) = min(D.training(:,i));
    P.ub(i) = max(D.training(:,i));
end
% P.lb = P.lb*0.95;
% P.ub = P.ub*1.05;
%% controling paramters of the GA algortihm
Problem.obj = @Sphere;


M = 50; % number of chromosomes (cadinate solutions)


P.N= 126;  %0 (input) + 12 + ouput + 54 rules  =  number of genes (variables)
MaxGen = 50;
Pc = 0.85; 
Pm = 0.1;%0.1;
Er = 0.1;
visualization = 1; % set to 0 if yosu do not want the convergence curve 

%% data


%tic
[BestChrom]  = GeneticAlgorithm (M , P, MaxGen , Pc, Pm , Er , Problem.obj , visualization, D.t_test, D.l_test)

fprintf('The best fitness value: %f \n',BestChrom.Fitness)

%Optimizec fuxxy ouput with validation data
[Predicted, error]= fuzzy_predict(BestChrom.Gene , P, D.t_validation, D.l_validation);
[Qv] = confusionmatrix(Predicted, D.l_validation);
er_valid = 1- (trace(Qv)/sum(sum(Qv)));
accuracy = (1- er_valid)*100;
fprintf('Acccuracy on validation set is %.2f . \n',accuracy)
%nned to shuffle the training and testing data
[Predicted_d, error_d]= fuzzy_predict(BestChrom.Gene , P, D.training, D.label);
[Qd] = confusionmatrix(Predicted_d, D.label);
er_d = 1- (trace(Qd)/sum(sum(Qd)));
accuracy_d = (1- er_d)*100;
fprintf('Acccuracy on Total data set is %.2f . \n',accuracy_d)

%C = confusionmat(Predicted',D.l_validation)
% %error plot
% figure()
% plot(P.data(1281:end,3),'LineWidth', 2)
% hold on
% plot(Fuzzy_F,'LineWidth', 2)
% set(gca,'FontWeight','Bold',  'LineWidth', 2);
% legend('Validation data','Fuzzy ouput');
% xlabel('Numer of Validation data')
% ylabel('F(x,y)')
% 
% [X,Y] = meshgrid(-pi:.2:pi);
% Z = sin(X).* cos(Y);
% 
% figure()
% s = surf(X,Y,Z);
% s.EdgeColor = 'none';
% s.FaceAlpha= 0.8;
% hold on
% p = scatter3(P.data(1281:end,1),P.data(1281:end,2),P.data(1281:end,3),'MarkerEdgeColor','k',...
%         'MarkerFaceColor','r');
% p.SizeData = 35;
% legend('Output Range','Validation data');
% xlabel('x')
% ylabel('y')
% zlabel('F(x,y) = sin(x).cos(y)')
% set(gca,'FontWeight','Bold',  'LineWidth', 2);
% view(-45,45);
% colormap Summer;
% 
% figure()
% s = surf(X,Y,Z);
% s.EdgeColor = 'none';
% s.FaceAlpha= 0.8;
% hold on
% p = scatter3(P.data(1281:end,1),P.data(1281:end,2),Fuzzy_F,'MarkerEdgeColor','k',...
%         'MarkerFaceColor','r');
% p.SizeData = 20;
% legend('Output Range','Fuzzy ouput');
% xlabel('x')
% ylabel('y')
% zlabel('F(x,y) = sin(x).cos(y)')
% set(gca,'FontWeight','Bold',  'LineWidth', 2);
% view(-45,45);
% colormap Summer;
% 
% 
% fprintf('Mean square Error for the validation set data is \n')
% Error
% 
% toc
savefilename = datestr(now, 'yyyy_mm_dd_HH_MM_SS')
save(savefilename,'BestChrom','MaxGen','P','M','Pc','Pm','Er')
%toc