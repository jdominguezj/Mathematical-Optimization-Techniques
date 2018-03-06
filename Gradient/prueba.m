clear, clc
xn = [200 100];
alfa = 0:0.001:10;
g = @(x) x(1)^2-24*x(1)+x(2)^2-10*x(2);
iter = 0;
while 1
    iter = iter + 1;
    gd = grad(xn);
    j = 1;
    for i = alfa
        f(j) = g(xn-i*gd);
        j = j+1;
    end
    
    
    %figure, plot(alfa,f)
    if norm(gd) < 1e-12
        break
    end
    xn_1 = xn -alfa(f == min(f))*gd;
    xn = xn_1;
    
end