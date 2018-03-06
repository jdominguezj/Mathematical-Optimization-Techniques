function [G] = grad(x)

epsilon = 1e-5;
G = zeros(size(x));
g = x(1)^2-24*x(1)+x(2)^2-10*x(2);
for i = 1:length(x)
    delta = zeros(size(x));
    delta(i) = 1;
    xn = x+delta*epsilon;
    gd = xn(1)^2-24*xn(1)+xn(2)^2-10*xn(2);
    G(i) = (gd-g)/epsilon;
end
end