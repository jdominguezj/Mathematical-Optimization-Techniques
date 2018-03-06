function [P,g] = puntos(x,S,A,B)
j =  1;
P = zeros(length(x)/2,3);
g = 0;
for i = 1 : 2: size(x,2)
    P(j,:) = [x(i),x(i+1),S(x(i),x(i+1))];
    if j == 1
        g = g + norm(B-P(j,:));
    elseif j == 9
        g = g + norm(P(j,:)-A);
    else
        g = g + norm(P(j-1,:)-P(j,:));
    end
    j = j+1;
end
end

