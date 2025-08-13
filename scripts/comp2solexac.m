function comp2solexac(met)

datos, N=1e4;
[t,x2] = met(f,intervalo,x0,N);
x1 = fexacta(t')';

n = size(x1); N = n(1); n = n(2);

switch n
    
    case 1
        
        figure, plot(t,x1,'r'), title ('Solución método 1'), xlim([intervalo(1),intervalo(2)])
        figure, plot(t,x1-x2,'r'), title ('Diferencia entre métodos'), xlim([intervalo(1),intervalo(2)])
        figure, plot(t,abs(x1-x2),'r'), title ('Norma de la diferencia'), xlim([intervalo(1),intervalo(2)])
        
    case 2
        
        subplot(2,2,1)
        plot(t,x1(:,1),'r'), title('x(t) método 1'), xlim([intervalo(1),intervalo(2)])
        subplot(2,2,2)
        plot(t,abs(x1(:,1)-x2(:,1)),'r'), title('Diferencia coordenada x'), xlim([intervalo(1),intervalo(2)])
        subplot(2,2,3)
        plot(t,x1(:,2),'g'), title('y(t) método 1'), xlim([intervalo(1),intervalo(2)])
        subplot(2,2,4)
        plot(t,abs(x1(:,2)-x2(:,2)),'g'), title('Diferencia coordenada y'), xlim([intervalo(1),intervalo(2)])
        
        figure
        subplot(1,2,1)
        plot(x1(:,1),x1(:,2),'r'), title('Trayectoria método 1')
        subplot(1,2,2)
        plot(t,sqrt(abs(x1(:,1)-x2(:,1)).^2+abs(x1(:,2)-x2(:,2)).^2),'r'), title('Norma de la diferencia'), xlim([intervalo(1),intervalo(2)])
        
    case 3
        
        subplot(3,2,1)
        plot(t,x1(:,1),'r'), title('x(t) método 1'), xlim([intervalo(1),intervalo(2)])
        subplot(3,2,2)
        plot(t,abs(x1(:,1)-x2(:,1)),'r'), title('Diferencia coordenada x'), xlim([intervalo(1),intervalo(2)])
        subplot(3,2,3)
        plot(t,x1(:,2),'g'), title('y(t) método 1'), xlim([intervalo(1),intervalo(2)])
        subplot(3,2,4)
        plot(t,abs(x1(:,2)-x2(:,2)),'g'), title('Diferencia coordenada z'), xlim([intervalo(1),intervalo(2)])
        subplot(3,2,5)
        plot(t,x1(:,3),'b'), title('y(t) método 1'), xlim([intervalo(1),intervalo(2)])
        subplot(3,2,6)
        plot(t,abs(x1(:,3)-x2(:,3)),'b'), title('Diferencia coordenada z'), xlim([intervalo(1),intervalo(2)])
        
        figure
        subplot(1,2,1)
        plot3(x1(:,1),x1(:,2),x1(:,3),'r'), title('Trayectoria método 1')
        subplot(1,2,2)
        plot(t,sqrt(abs(x1(:,1)-x2(:,1)).^2+abs(x1(:,2)-x2(:,2)).^2+abs(x1(:,3)-x2(:,3)).^2),'r'), title('Norma de la diferencia'), xlim([intervalo(1),intervalo(2)])
        
    otherwise
            
end