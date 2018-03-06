function [G] = gradiente(x)

epsilon = 1e-5;
G = zeros(size(x));
g = U(x);
for i = 1:length(x)
    delta = zeros(size(x));
    delta(i) = 1;
    gd = U(x+delta*epsilon);
    G(i) = (gd-g)/epsilon;
end
end
