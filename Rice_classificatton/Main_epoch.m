% main 
% Written by Dr. Seyedali Mirjalili
% To watch videos on this algorithm, enrol to my courses with 95% discount using the following links: 

clear
clc
close all
tic;
%% Loading data

fprintf('Loading data ...\n')
load Data.mat;

for i = 1:7
    P.lb(i) = min(D.training(:,i));
    P.ub(i) = max(D.training(:,i));
end
% P.lb = P.lb*0.95;
% P.ub = P.ub*1.05;
%% controling paramters of the GA algortihm
Problem.obj = @Sphere;


M = 20; % number of chromosomes (cadinate solutions)


P.N= 126;  %0 (input) + 12 + ouput + 54 rules  =  number of genes (variables)
MaxGen = 2;
Pc = 0.85; 
Pm = 0.01;%0.1;
Er = 0.05;
visualization = 1; % set to 0 if yosu do not want the convergence curve 

%% data


tic
P.BestChrom.Gene = [];
[BestChrom]  = GeneticAlgorithm (M , P, MaxGen , Pc, Pm , Er , Problem.obj , visualization, D.t_test(1:1000,:), D.l_test(1:1000,:))

P.BestChrom.Gene = BestChrom.Gene
[BestChrom]  = GeneticAlgorithm (M , P, MaxGen , Pc, Pm , Er , Problem.obj , visualization, D.t_test(1001:end,:), D.l_test(1001:end,:))
P.BestChrom.Gene = BestChrom.Gene

fprintf('The best fitness value: %f \n',BestChrom.Fitness)
%% memplot
%membership functions are plotted using below code from their respective
%range
% figure()
% x1=-pi:0.01:pi;
% for n=1:length(x1) 
%     for i = 1:P.noMem1
%         vertices = X(((i-1)*3 + 1):((i-1)*3 + 3));
%         vertices = sort(vertices);
%         if i == 1
%             Mu1(i).x(n) = lshlder(x1(n), vertices(2),vertices(3),vertices(1));
%         elseif i ==P.noMem1
%             Mu1(i).x(n) = rshlder(x1(n), vertices(2),vertices(3),vertices(1));
%         else
%             Mu1(i).x(n) = triangle(x1(n), vertices(1), vertices(2), vertices(3));
%         end
%         %Mu1(i).x(n) = triangle(x1(n), vertices(1), vertices(2), vertices(3));
%     end
%     for j =1:P.noMem2
%         vertices = X(((j-1)*3 + P.noMem1*3 + 1):((j-1)*3 +P.noMem1*3 + 3));
%         vertices = sort(vertices);
%         if j == 1
%             Mu2(j).y(n) = lshlder(x1(n), vertices(2),vertices(3),vertices(1));
%         elseif j ==P.noMem2
%             Mu2(j).y(n) = rshlder(x1(n), vertices(2),vertices(3),vertices(1));
%         else
%             Mu2(j).y(n) = triangle(x1(n), vertices(1), vertices(2), vertices(3));
%         end
%     end
%  
%         %Mu2(j).y(n) = triangle(x1(n), vertices(1), vertices(2), vertices(3));
% end
% f1=-1:0.001:1;
% for n=1:length(f1) 
%     for k = 1:P.noMemout
%         vertices = X(((k-1)*3 + +(P.noMem1 +P.noMem2)*3+1):((k-1)*3 + (P.noMem1+P.noMem2)*3+3));
%         vertices = sort(vertices);
%         Mo(k).F(n) = triangle(f1(n), vertices(1), vertices(2), vertices(3));%[vertices(1), vertices(2), vertices(3)];
%     end
% end

%% Plots
%input mem 1
% 
% for i=1:P.noMem1
%     plot(x1,Mu1(i).x,'LineWidth', 2)
%     hold on
% end
% ylim([-0.1 1.1])
% set(gca,'FontWeight','Bold',  'LineWidth', 2);
% xlabel('Input variable, x')
% ylabel('Membership Function')
% %input mem 2
% figure()
% for i=1:P.noMem2
%     plot(x1,Mu2(i).y,'LineWidth', 2)
%     hold on
% end
% ylim([-0.1 1.1])
% set(gca,'FontWeight','Bold',  'LineWidth', 2);
% xlabel('Input variable, y')
% ylabel('Membership Function')
% %output mem
% figure()
% for i=1:P.noMemout
%     plot(f1,Mo(i).F,'LineWidth', 2)
%     hold on
% end
% ylim([-0.1 1.1])
% set(gca,'FontWeight','Bold',  'LineWidth', 2);
% xlabel('Ouput variable, F(x,y)')
% ylabel('Membership Function')

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
save('Best.mat','BestChrom','MaxGen','P','M')
toc