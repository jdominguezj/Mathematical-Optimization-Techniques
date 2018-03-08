% Mesh funtion
clear; close; clc;
[X,Y] = meshgrid(0:0.1:5,0:0.1:3);
U1 = U(X,Y);
figure(1), surf(X,Y,U1)
figure(2),contour(X,Y,U1,100),hold on
% Metodo de gradiente
xn  = [4 2]; % x y lamda
iter = 0;
vecU = [];
vecU(1) = U(xn);
camino(1,:) = xn;
fprintf('Running Gradient Descent ...')
while 1
    iter = iter+1;
    fprintf([num2str(iter),', '])
    gd = gradiente(xn);
    Vn = -gd/norm(gd);
    
    t1 = 0;
    t2 = 2;
    dh_dt1 =  gradiente(xn+t1*Vn)*Vn';
    dh_dt2 =  gradiente(xn+t2*Vn)*Vn';
%     (U(xn+(4+1e-6)*Vn)-U(xn+4*Vn))/1e-6
    
    if dh_dt1 > 0
        error('Signo positivo')
        break;
    end
    
    i = 1;
    while dh_dt2 < 0
        t2 = t2*2^i;
        dh_dt2 = gradiente(xn+t2*Vn)*Vn';
        i = i + 1;
    end
    
    while abs(t1-t2) > 1e-6
        k = (t1+t2)/2;
        
        dh1 = gradiente(xn+t1*Vn)*Vn';
        dh2 = gradiente(xn+t2*Vn)*Vn';
        dhk = gradiente(xn+k*Vn)*Vn';
        
        if dh1*dhk < 0
            t2 = k;
        elseif dh2*dhk < 0
            t1 = k;
        elseif dhk == 0
            break
        end
        
    end
    
    alfa = k;
    
    xn_1 = xn + alfa*Vn;
    
    vecU(iter+1) = U(xn_1);
    
    if  norm(gd) < 1e-6
        fprintf('\n')
        fprintf('X found by gradient descent: ');
        fprintf('%f %f \n', xn(1), xn(2));
        break
    elseif norm(xn_1-xn)/norm(xn_1) < 1e-6
        fprintf('\n')
        fprintf('X found by gradient descent: ');
        fprintf('%f %f \n', xn(1), xn(2));
        break
    elseif iter >= 3000
        fprintf('\n')
        disp('Maximum Number of Iterations')
        break
    end
    
    
    xn = xn_1;
    camino(iter+1,:) = xn;
    
end
plotdata(camino,vecU)
hold off
%%
% NI = 1e-13;
% iter = 0;
% alfa = 0:0.01:10;
% for i = 1: 1
%     iter = iter+1;
%     gd = gradiente(xn);
%     j = 1;
%     for i = alfa
%         f(j) =  U(xn-i*gd/norm(gd));
%         j = j+1;
%     end
%     
% end
% figure,plot(alfa,f)