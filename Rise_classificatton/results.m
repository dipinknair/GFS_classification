clc
clear all

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


%load("Best100_100.mat")
load("Best.mat")

[Predicted, error]= fuzzy_predict(BestChrom.Gene , P, D.t_validation, D.l_validation);
[Qv] = confusionmatrix(Predicted, D.l_validation);
er_valid = 1- (trace(Qv)/sum(sum(Qv)));
accuracy_t = (1- er_valid)*100;
precision_t = Qv(1,1)/sum(Qv(1,:))*100;
recall_t = Qv(1,1)/sum(Qv(:,1))*100;
f1score_t = 2*(recall_t * precision_t) / (recall_t + precision_t);
fprintf('Acccuracy on validation set is %.2f . \n',accuracy_t)
fprintf('precision on validation set is %.2f . \n',precision_t)
fprintf('sensitivity on validation set is %.2f . \n',recall_t)
fprintf('f1score on validation set is %.2f . \n',f1score_t)
fprintf('Confusion matrix is \n')
disp(Qv)
[Predicted_d, error_d]= fuzzy_predict(BestChrom.Gene , P, D.training, D.label);
[Qd] = confusionmatrix(Predicted_d, D.label);
er_d = 1- (trace(Qd)/sum(sum(Qd)));
accuracy_d = (1- er_d)*100;
precision_d = Qd(1,1)/sum(Qd(1,:))*100;
recall_d = Qd(1,1)/sum(Qd(:,1))*100;
f1score_d = 2*(recall_d * precision_d) / (recall_d + precision_d);
fprintf('Acccuracy on Total data set is %.2f . \n',accuracy_d)
fprintf('precision on validation set is %.2f . \n',precision_d)
fprintf('sensitivity on validation set is %.2f . \n',recall_d)
fprintf('f1score on validation set is %.2f . \n',f1score_d)
fprintf('Confusion matrix is \n')
disp(Qd)

X = BestChrom.Gene;
%input mem1
figure()
subplot(4,2,1)
[x1, y1, y2, y3, lb, ub] = plotimf(sort(X(1:5)),P.lb(1),P.ub(1));
plot(x1, [y1 y2 y3], 'LineWidth',2);
xlim([(lb-(lb*0.20)) (ub+(ub*0.20))])
xlabel('Area')
ylabel('Membership degree')
title('Input Membership function')
set(gca,'FontWeight','bold')
%input mem2
%figure()
subplot(4,2,2)
[x1, y1, y2, y3, lb, ub] = plotimf(sort(X(6:10)),P.lb(2),P.ub(2));
plot(x1, [y1 y2 y3], 'LineWidth',2);
xlim([(lb-(lb*0.20)) (ub+(ub*0.20))])
xlabel('Perimeter')
ylabel('Membership degree')
title('Input Membership function')
set(gca,'FontWeight','bold')

%input mem3
subplot(4,2,3)
[x1, y1, y2, y3, lb, ub] = plotimf(sort(X(11:15)),P.lb(3),P.ub(3));
plot(x1, [y1 y2 y3], 'LineWidth',2);
xlim([(lb-(lb*0.20)) (ub+(ub*0.20))])
xlabel('Major axis')
ylabel('Membership degree')
title('Input Membership function')
set(gca,'FontWeight','bold')

%input mem4
%figure()
subplot(4,2,4)
[x1, y1, y2, y3, lb, ub] = plotimf(sort(X(16:20)),P.lb(4),P.ub(4));
plot(x1, [y1 y2 y3], 'LineWidth',2);
xlim([(lb-(lb*0.20)) (ub+(ub*0.20))])
xlabel('Minor axis')
ylabel('Membership degree')
title('Input Membership function')
set(gca,'FontWeight','bold')

%input mem5
%figure()
subplot(4,2,5)
[x1, y1, y2, y3, lb, ub] = plotimf(sort(X(21:25)),P.lb(5),P.ub(5));
plot(x1, [y1 y2 y3], 'LineWidth',2);
xlim([(lb-(lb*0.20)) (ub+(ub*0.20))])
xlabel('Eccentricity')
ylabel('Membership degree')
title('Input Membership function')
set(gca,'FontWeight','bold')

%input mem6
%figure()
subplot(4,2,6)
[x1, y1, y2, y3, lb, ub] = plotimf(sort(X(26:30)),P.lb(6),P.ub(6));
plot(x1, [y1 y2 y3], 'LineWidth',2);
xlim([(lb-(lb*0.20)) (ub+(ub*0.20))])
xlabel('Convex area')
ylabel('Membership degree')
title('Input Membership function')
set(gca,'FontWeight','bold')

%input mem7
%figure()
subplot(4,2,7)
[x1, y1, y2, y3, lb, ub] = plotimf(sort(X(31:35)),P.lb(7),P.ub(7));
plot(x1, [y1 y2 y3], 'LineWidth',2);
xlim([(lb-(lb*0.20)) (ub+(ub*0.20))])
xlabel('Extent')
ylabel('Membership degree')
title('Input Membership function')
set(gca,'FontWeight','bold')

%input FIS1
figure()
subplot(3,2,1)
[x1, y1, y2, y3, lb, ub] = plotimf(sort(X(36:40)),0,1);
plot(x1, [y1 y2 y3], 'LineWidth',2);
xlim([0 1])
xlabel('FIS1')
ylabel('Membership degree')
title('Input Membership function')
set(gca,'FontWeight','bold')

%input FIS2
subplot(3,2,2)
[x1, y1, y2, y3, lb, ub] = plotimf(sort(X(41:45)),0,1);
plot(x1, [y1 y2 y3], 'LineWidth',2);
xlim([0 1])
xlabel('FIS2')
ylabel('Membership degree')
title('Input Membership function')
set(gca,'FontWeight','bold')

%input FIS3
subplot(3,2,3)
[x1, y1, y2, y3, lb, ub] = plotimf(sort(X(46:50)),0,1);
plot(x1, [y1 y2 y3], 'LineWidth',2);
xlim([0 1])
xlabel('FIS3')
ylabel('Membership degree')
title('Input Membership function')
set(gca,'FontWeight','bold')
%input FIS4
subplot(3,2,4)
[x1, y1, y2, y3, lb, ub] = plotimf(sort(X(51:55)),0,1);
plot(x1, [y1 y2 y3], 'LineWidth',2);
xlim([0 1])
xlabel('FIS4')
ylabel('Membership degree')
title('Input Membership function')
set(gca,'FontWeight','bold')
%input FIS5
subplot(3,2,5)
[x1, y1, y2, y3, lb, ub] = plotimf(sort(X(56:60)),0,1);
plot(x1, [y1 y2 y3], 'LineWidth',2);
xlim([0 1])
xlabel('FIS5')
ylabel('Membership degree')
title('Input Membership function')
set(gca,'FontWeight','bold')

%Ouput
figure()
x1 = linspace(0,1,1000);
bounds = sort(X(71:72));
coefficients = polyfit([0, bounds(2)], [1, 0], 1);
y1 = coefficients(1)*x1 + coefficients(2);
coefficients = polyfit([bounds(1), 1], [0, 1], 1);
y2 = coefficients(1)*x1 + coefficients(2);
%[x1, y1, y2, y3, lb, ub] = plotimf(sort(X(56:60)),0,1);
plot(x1', [y1' y2'], 'LineWidth',2);
xlim([0 1])
ylim([0 1])
xlabel('Output')
ylabel('Membership degree')
title('Output Membership function')
set(gca,'FontWeight','bold')
