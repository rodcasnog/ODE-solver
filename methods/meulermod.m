function [t,x]=meulermod(f,intervalo,x0,N)

h = (intervalo(2) - intervalo(1))/N;
t(1) = intervalo(1);
x(1,:) = x0;

for i=1:1:N
    F1 = f(t(i),x(i,:));
    F2 = f(t(i)+h/2,x(i,:)+h/2.*F1);
    x(i+1,:) = x(i,:) + h * F2;
    t(i+1) = t(i) + h;
end
t = t';