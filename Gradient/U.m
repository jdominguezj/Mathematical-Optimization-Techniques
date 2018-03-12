%Potential Energy Function

%L=Lenght of springs
%K=Constant of springs, assuming each one has the same
%PE, Potential Energy Function

function [PE] = U(X,Y)

L =  1;
K = 1*10^3;
PE = 0;

%Being in this case five springs, below is shown the positions of each one into a XY Plane:

p(1,:) = [2 0]; 
p(2,:) = [5 1.5];
p(3,:) = [2.5 3];
p(4,:) = [0 2];
p(5,:) = [0 1];

%Below, is shown how Potential Energy is calculated trough making differences between a X value given and the values stablished in each
%pair of points in this script (p(1,:),...p(5,:))

for i = 1 : 5
    if nargin == 1 % Nargin returns the number of input  arguments that appear in the function definition.
        l = norm(X-p(i,:));
    else
        l = vecnorm(X-p(i,1),Y-p(i,2));
    end        
   PE = PE + (0.5)*K*(l-L).^2;
end

end

