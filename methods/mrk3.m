function [t,x]=mrk3(f,intervalo,x0,N)

h = (intervalo(2) - intervalo(1))/N;
t(1) = intervalo(1);
x(1,:) = x0;

for i=1:1:N+1
    F1 = f(t(i),x(i,:));
    F2 = f(t(i)+h/2,x(i,:)+h/2.*F1);
    F3 = f(t(i)+h*3/4,x(i,:)+h*3/4.*F2);
    x(i+1,:) = x(i,:) + h * (2*F1+3*F2+4*F3)/9;
    t(i+1) = t(i) + h;
end
t = t';