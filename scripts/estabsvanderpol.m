a=30;
b=1;
f = @(t,x) [x(2);-a*(x(1).^2-b).*x(2)-x(1)];
intervalo=[0,250];
x0=[0.1,0.1];
N=1e4;

opciones=odeset('Stats','off','AbsTol',1.e-5,'RelTol',1.e-5);
[t1,x1]=ode45(f,intervalo,x0,opciones);

opciones=odeset('Stats','off','AbsTol',1.e-5,'RelTol',1.e-5);
[t2,x2]=ode15s(f,intervalo,x0,opciones);

figure
subplot(2,1,1)
plot(t1,x1(:,1),'r'), title('x(t)'), xlim([intervalo(1),intervalo(2)])
subplot(2,1,2)
plot(t1,x1(:,2),'g'), title('x''(t)'), xlim([intervalo(1),intervalo(2)])

figure
subplot(2,1,1)
plot(t2,x2(:,1),'r'), title('x(t)'), xlim([intervalo(1),intervalo(2)])
subplot(2,1,2)
plot(t2,x2(:,2),'g'), title('x''(t)'), xlim([intervalo(1),intervalo(2)])

figure
plot(diff(t1),'.g')
hold on
plot(diff(t2),'.b')
[length(t1),length(t2)]
