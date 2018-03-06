%% Variables
clear
close
clc
xn  = [4 2];

iter = 0;
vecU = [];
vecU(1) = U(xn);
while 1
    iter = iter+1;
    gd = gradiente(xn);
    Vn = -gd/norm(gd);
    
    t1 = 0;
    t2 = 2;
    dh_dt1 =  gradiente(xn+t1*Vn)*Vn';
    dh_dt2 =  gradiente(xn+t2*Vn)*Vn';
%     (U(xn+(4+1e-6)*Vn)-U(xn+4*Vn))/1e-6
    
    if dh_dt1 > 0
        error('Signo positivo')
        break
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
        elseif dk == 0
            break
        end
        
    end
    
    alfa = k;
    
    xn_1 = xn + alfa*Vn;
    
    vecU(iter+1) = U(xn_1);
    
    if  norm(gd) < 1e-6
        disp('Magnitud del gradiente muy peque�o')
        break
    elseif norm(xn_1-xn)/norm(xn_1) < 1e-6
        disp('Cambio peque�o entre xn y xn+1')
        break
    elseif iter >= 3000
        disp('Muchas iteraciones')
        break
    end
    
    
    xn = xn_1;
    
end
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