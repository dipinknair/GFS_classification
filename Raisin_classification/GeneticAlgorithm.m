
function [BestChrom]  = GeneticAlgorithm (M , P, MaxGen , Pc, Pm , Er , obj, visuailzation, input, label)

cgcurve = zeros(1 , MaxGen);

%%  Initialization
[ population ] = initialization(M, P);
% if isempty(P.BestChrom.Gene)
%     %donothing
% else
%     population.Chromosomes(end) = P.BestChrom;
% end

for i = 1 : M
    population.Chromosomes(i).fitness = Sphere( population.Chromosomes(i).Gene(:), P, input, label);
end

g = 1;
disp(['Generation #' , num2str(g)]);
[~ , indx] = sort([ population.Chromosomes(:).fitness ] , 'descend');
cgcurve(g) = population.Chromosomes(indx(1)).fitness;

%% Main loop
for g = 2 : MaxGen
    tic
    disp(['Generation #' , num2str(g)]);
    % Calcualte the fitness values
    for i = 1 : M
        population.Chromosomes(i).fitness = Sphere( population.Chromosomes(i).Gene(:), P, input, label);
    end
    
    for k = 1: 2: M
        % Selection
        [ parent1, parent2] = selection(population);
        
        % Crossover
        [child1 , child2] = crossover(parent1 , parent2, Pc, 'single');
        
        % Mutation
        [child1] = mutation(child1, Pm,P);
        [child2] = mutation(child2, Pm,P);
        
        newPopulation.Chromosomes(k).Gene = child1.Gene;
        newPopulation.Chromosomes(k+1).Gene = child2.Gene;
    end
    
    for i = 1 : M
        newPopulation.Chromosomes(i).fitness = Sphere(population.Chromosomes(i).Gene(:), P, input, label);
    end
    % Elitism
    [ newPopulation ] = elitism(population, newPopulation, Er);
    
    cgcurve(g) = newPopulation.Chromosomes(1).fitness;
    
    population = newPopulation; % replace the previous population with the newly made
    toc
end

   
BestChrom.Gene    = population.Chromosomes(1).Gene;
BestChrom.Fitness = population.Chromosomes(1).fitness;
BestChrom.cgcurve = cgcurve;


if visuailzation == 1

    plot( 1 : MaxGen , cgcurve,'LineWidth', 2);
    xlabel('Generation');
    ylabel('Fitness of the best elite')
    set(gca,'FontWeight','Bold',  'LineWidth', 2);
    figure()
    plot( 1 : MaxGen , (-1*cgcurve),'LineWidth', 2);
    xlabel('Generation');
    ylabel('Mean Squared Error')
    set(gca,'FontWeight','Bold',  'LineWidth', 2);
    
end


end