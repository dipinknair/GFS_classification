% Written by Dr. Seyedali Mirjalili
% To watch videos on this algorithm, enrol to my courses with 95% discount using the following links:

function [child] = mutation(child, Pm, P)

Gene_no = length(child.Gene);

for k = 1: Gene_no
    R = rand();
    if R < Pm
        
        %         if k <= (P.noMem1 + P.noMem2)*3
        %             if k == 1 || k == (P.noMem1 + P.noMem2)*3 || k == (P.noMem1)*3 || k == (P.noMem1)*3 +1
        %                 %do nothing
        %                 %here no mutation happens for the values at boundary.
        %                 %they always will be -4 & 4 for this problem
        %             else
        %                 child.Gene(k) = [2*pi*rand() - pi];
        %             end
        %         elseif k <= P.MemGeneLen
        %             child.Gene(k) = [ 2*rand() - 1];
        %         else
        %             child.Gene(k) = [ round((P.noMemout-1)*rand())+1];
        %         end
        if k <=5
            child.Gene(k) = [(P.ub(1)-P.lb(1))*rand() + P.lb(1)];
        elseif k <=10
            child.Gene(k) = [(P.ub(2)-P.lb(2))*rand() + P.lb(2)];
        elseif k <=15
            child.Gene(k) = [(P.ub(3)-P.lb(3))*rand() + P.lb(3)];
        elseif k <=20
            child.Gene(k) = [(P.ub(4)-P.lb(4))*rand() + P.lb(4)];
        elseif k <=25
            child.Gene(k) =  [(P.ub(5)-P.lb(5))*rand() + P.lb(5)];
        elseif k <=30
            child.Gene(k) = [(P.ub(6)-P.lb(6))*rand() + P.lb(6)];
        elseif k <=35
            child.Gene(k) = [(P.ub(7)-P.lb(7))*rand() + P.lb(7)];
        elseif k <=60
            child.Gene(k) = [rand()];
        elseif k <=72
            child.Gene(k) = [rand()];
        else
            child.Gene(k) = [round(rand())+1];
        end
        
        
    end
    
end


end