
function  [fitness_value] = Sphere(X , P, input, label)

%FIS1 = FIS( X(1:5),X(6:10), X(61:62), X(73:81), P.lb(1), P.ub(1), P.lb(2), P.ub(2), Data(1), Data(2))

for i = 1:length(input)
    FIS1= FIS( X(1:5),X(6:10), X(61:62), X(73:81), P.lb(1), P.ub(1), P.lb(2), P.ub(2), input(i,1), input(i,2));
    FIS2= FIS( X(11:15),X(16:20), X(63:64), X(81:90), P.lb(3), P.ub(3), P.lb(4), P.ub(4), input(i,3), input(i,4));
    FIS3= FIS( X(21:25),X(26:30), X(65:66), X(91:99), P.lb(5), P.ub(5), P.lb(6), P.ub(6), input(i,5), input(i,6));
    FIS4= FIS( X(31:35),X(36:40), X(67:68), X(100:108), 0, 1, 0, 1, FIS1, FIS2);
    FIS5= FIS( X(41:45),X(46:50), X(69:70), X(109:117), 0, 1, P.lb(7), P.ub(7), FIS3, input(i,7));
    FIS6= FIS( X(51:55),X(56:60), X(71:72), X(118:126), 0, 1, 0, 1, FIS4, FIS5);
    fpredicted(i) = FIS6;
end
Error = sum((fpredicted' - label).^2) /length(label);
fitness_value = -Error; %fitness inverese of MSE

end