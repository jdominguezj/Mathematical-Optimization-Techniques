%Gradient finally function implemented                                    

function [G] = gradientpoint(x,S,A,B)

epsilon = 1e-5;
G = zeros(size(x));
[~,g] = puntos(x,S,A,B);
for i = 1:length(x)
    delta = zeros(size(x));
    delta(i) = 1;
    [~,gd] = puntos(x+delta*epsilon,S,A,B);
    G(i) = (gd-g)/epsilon;
end
end

