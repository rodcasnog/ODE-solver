mu =50;
f = @(t,x) -mu*(x-cos(t));
fexacta = @(t) mu^2/(1+mu^2)*(cos(t)-exp(-mu*t)+1/mu*sin(t));
intervalo=[0,1];
x0=0;
N=27;

h = (intervalo(2)-intervalo(1))/N;
x=0; t=0;
t(1) = intervalo(1);
x(1,:) = x0;

for i=1:1:N
    x(i+1,:) = x(i,:) + h*f(t(i),x(i,:))';
    t(i+1) = t(i) + h;
end
t = t';

figure
plot(linspace(0,1,1e3),fexacta(linspace(0,1,1e3)),'r-')
hold on
plot(t,x,'g.-')
xlim([intervalo(1),intervalo(2)])
figure, plot(t,abs(x-fexacta(t)),'r.'), title ('Norma de la diferencia'), xlim([intervalo(1),intervalo(2)])
