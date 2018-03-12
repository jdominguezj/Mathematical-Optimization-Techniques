clear, clc


f = @U;
grad = @grad_f;
Bisection = @bisec;
Newton = @Newton_Raphson;


iter = 0;
xn  = [4 2];
tic
while 1
    iter = iter+1;
    gf_xn = grad(f,xn);
    dir = -gf_xn/norm(gf_xn);
    
%     alfa = Bisection(f,xn,dir,0,2);
    alfa = Newton(f,xn,dir);
    
    xn_1 = xn + alfa*dir;
    
    if  norm(grad(f,xn_1)) < 1e-6
        disp('Magnitud del gradiente muy pequeño')
        break
    elseif norm(xn_1-xn)/norm(xn_1) < 1e-6
        disp('Cambio pequeño entre xn y xn+1')
        break
    elseif iter >= 3000
        disp('Muchas iteraciones')
        break
    end
    
    
    xn = xn_1;
    
end
toc


function PE = U(x)

L =  1;
K = 1e3;
PE = 0;

p(1,:) = [2 0];
p(2,:) = [5 1.5];
p(3,:) = [2.5 3];
p(4,:) = [0 2];
p(5,:) = [0 1];

for i = 1:5
    l = norm(x-p(i,:));
    PE = PE + (0.5)*K*(l-L)^2;
end
end

function G = grad_f(f,x)

G = zeros(size(x));
delta = zeros(size(x));
fx = f(x);

for i = 1:length(x)
    delta(i) = 1e-6;
    G(i) = (f(x+delta)-fx)/1e-6;
    delta(i) = 0;
end
end

function t_min = bisec(f,xn,dir,t1,t2)

dh_dt1 =  grad_f(f,xn+t1*dir)*dir';
dh_dt2 =  grad_f(f,xn+t2*dir)*dir';
    
if dh_dt1 > 0
    error('No hay un descenso para Bisección')
end
    
i = 1;
while dh_dt2 < 0
    t2 = t2*2^i;
    dh_dt2 = grad_f(f,xn+t2*dir)*dir';
    i = i + 1;
end

while abs(t1-t2) > 1e-6
    t_min = (t1+t2)/2;

    dh1 = grad_f(f,xn+t1*dir)*dir';
    dh2 = grad_f(f,xn+t2*dir)*dir';
    dh_min = grad_f(f,xn+t_min*dir)*dir';

    if dh1*dh_min < 0
        t2 = t_min;
    elseif dh2*dh_min < 0
        t1 = t_min;
    elseif dh_min == 0
        break
    end
end
end

function t = Newton_Raphson(f,x0,dir)

d = 1e-6;
tn = 0;
while 1
    dh = (f(x0+(tn+d)*dir)-f(x0+(tn-d)*dir))/(2*d);
    d2h = (f(x0+(tn+d)*dir)-2*f(x0+tn*dir)+f(x0+(tn-d)*dir))/d^2;
    
    tn_1 = tn-dh/d2h;
    
    if abs((tn_1-tn)/tn_1) < 1e-4
        break
    elseif abs((tn_1-tn)/tn_1)> 30
        error('La función g(x) no converge1')
    elseif isnan(tn) || isnan(tn_1)
        error('La función g(x) no converge2')
    end
    
    tn = tn_1;
end

t = tn_1;
end
