% Written by Dr. Seyedali Mirjalili
% To watch videos on this algorithm, enrol to my courses with 95% discount using the following links:

% *************************************************************************************************************************************************
%  A course on "Optimization Problems and Algorithms: how to understand, formulation, and solve optimization problems":
%  https://www.udemy.com/optimisation/?couponCode=MATHWORKSREF
% *************************************************************************************************************************************************
%  "Introduction to Genetic Algorithms: Theory and Applications"
%  https://www.udemy.com/geneticalgorithm/?couponCode=MATHWORKSREF
% *************************************************************************************************************************************************

function [ population ] = initialization(M, P)
fprintf('Initializing population...\n');
for i = 1 : M
    for j = 1:5
        population.Chromosomes(i).Gene(j) = [(P.ub(1)-P.lb(1))*rand() + P.lb(1)];
    end
    for j = 6:10
        population.Chromosomes(i).Gene(j) = [(P.ub(2)-P.lb(2))*rand() + P.lb(2)];
    end
    for j = 11:15
        population.Chromosomes(i).Gene(j) = [(P.ub(3)-P.lb(3))*rand() + P.lb(3)];
    end
    for j = 16:20
        population.Chromosomes(i).Gene(j) = [(P.ub(4)-P.lb(4))*rand() + P.lb(4)];
    end
    for j = 21:25
        population.Chromosomes(i).Gene(j) = [(P.ub(5)-P.lb(5))*rand() + P.lb(5)];
    end
    for j = 26:30
        population.Chromosomes(i).Gene(j) = [(P.ub(6)-P.lb(6))*rand() + P.lb(6)];
    end
    for j = 31:35
        population.Chromosomes(i).Gene(j) = [(P.ub(7)-P.lb(7))*rand() + P.lb(7)];
    end
    for j = 36:60
        population.Chromosomes(i).Gene(j) = [rand()];
    end
    
    % ouput membership fucntion
    for j = 61:72
        population.Chromosomes(i).Gene(j) = [rand()];
    end
    
    for j = 73:P.N
       population.Chromosomes(i).Gene(j) = [round(rand())+1];
    end
end
fprintf('Initialization Completed !\n');
end
