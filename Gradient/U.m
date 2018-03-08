function [PE] = U(X,Y)

L =  1;
K = 1*10^3;
PE = 0;

p(1,:) = [2 0];
p(2,:) = [5 1.5];
p(3,:) = [2.5 3];
p(4,:) = [0 2];
p(5,:) = [0 1];


for i = 1 : 5
    if nargin == 1
        l = norm(X-p(i,:));
    else
        l = vecnorm(X-p(i,1),Y-p(i,2));
    end        
   PE = PE + (0.5)*K*(l-L).^2;
end

end

