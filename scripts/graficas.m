n = size(x); N = n(1); n = n(2);

switch n
    
    case 1
        figure, plot(t,x,'r'), xlim([intervalo(1),intervalo(2)])
        
    case 2
        
        figure
        subplot(2,1,1)
        plot(t,x(:,1),'r'), title('x(t)'), xlim([intervalo(1),intervalo(2)])
        subplot(2,1,2)
        plot(t,x(:,2),'g'), title('y(t)'), xlim([intervalo(1),intervalo(2)])
        
        figure
        plot(x(:,1),x(:,2),'r'), title('Trayectoria')
        
    case 3
        
        figure
        subplot(3,1,1)
        plot(t,x(:,1),'r'), title('x(t)'), xlim([intervalo(1),intervalo(2)])
        subplot(3,1,2)
        plot(t,x(:,2),'g'), title('y(t)'), xlim([intervalo(1),intervalo(2)])
        subplot(3,1,3)
        plot(t,x(:,3),'b'), title('z(t)'), xlim([intervalo(1),intervalo(2)])
        
        figure
        plot3(x(:,1),x(:,2),x(:,3),'r'), title('Trayectoria')
        
    otherwise
            
end        