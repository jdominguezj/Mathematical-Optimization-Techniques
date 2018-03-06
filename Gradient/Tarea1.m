%%
clear,clc
%%
c1 = [2000 6000]; h1 = 2500;
c2 = [5000 2000]; h2 = -300;
c3 = [8000 3000]; h3 = 1500;
[X,Y] = meshgrid(0:100:10000);
S = @(X,Y) h1.*(1./(1+vecnorm((X-c1(1))./1000,(Y-c1(2))./1000).^2))+...
     h2.*(1./(1+vecnorm((X-c2(1))./1000,(Y-c2(2))./1000).^2))+...
     h3.*(1./(1+vecnorm((X-c3(1))./1000,(Y-c3(2))./1000).^2));
Z = S(X,Y);
%figure(1),contour(X,Y,Z,50)
%figure(2), surf(X,Y,Z)
%% Funcion a minimizar
A0 = [2500,6500]; A = [A0(1),A0(2),S(A0(1),A0(2))];
B0 = [7000,2500]; B = [B0(1),B0(2),S(B0(1),B0(2))];
AB = B-A;
%xn = zeros(1,18);
%xn = [1000 2345 4323 3456 3234 5445 4554 5455 45545 4555 4554 4543 2135
%2323 3456 4565 4345 3456];
v = 0.1:0.1:0.8; x = 2500+v*4500; y =6500-v*4000; z = 1690-v*1015.4;
xn = [x;y];
xn = xn(:);
%figure(1),plot3(x,y,z,'r.'),hold on,plot3(A(1),A(2),A(3),'*'),plot3(B(1),B(2),B(3),'*')
%%
NI = 1e-13;
iter = 0;
%alfa = 100:10000;
alfa = 1:0.1:1000;
pause(1);
while 1
    figure(1), contour(X,Y,Z,50); hold on
    scatter(xn(1:2:end-1),xn(2:2:end),'filled');
    drawnow
    hold off
    iter = iter+1;
    gd=gradientpoint(xn,S,A,B);
    j = 1;
    for i = alfa
        [~,f(j)] =  puntos(xn-i*gd,S,A,B);
        j = j+1;
    end
    
    ind = f == min(f);
    a = alfa(ind);
    xn_1 = xn - a*(gd/norm(gd));
    
    %xn_1 = xn - gd;
    %alfa(find(ind));
    N = norm(gd);
    if  N < 1e-13
        break
    end
    xn = xn_1;
end
%hold off;
%%
[FX,FY] = gradient(-Z);
contour(X,Y,Z,50)
hold on
quiver(X,Y,FX,FY)
hold off

%%
clear, clc
xn = [0 0];
alfa = 0:0.1:1000;
while 1
    gd = grad(xn);
    j = 1;
    for i = alfa
        f(j) = xn(1)^2-24*xn(1)+xn(2)^2-10*xn(2);
        j = j+1;
    end
    
    plot(alfa,f)
    
end
