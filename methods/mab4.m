function [t,x]=mab4(f,intervalo,x0,N)

% orden de precisión , y si e_0(h)=O(h^), tmb e(h)=O(h^)

h = (intervalo(2) - intervalo(1))/N;
t(1) = intervalo(1);
x(1,:) = x0;

% Inicializa con mrk3
for i=1:1:3
    F1 = f(t(i),x(i,:));
    F2 = f(t(i)+h/2,x(i,:)+h/2.*F1);
    F3 = f(t(i)+h*3/4,x(i,:)+h*3/4.*F2);
    x(i+1,:) = x(i,:) + h * (2*F1+3*F2+4*F3)/9;
    t(i+1) = t(i) + h;
end

for i=1:1:N-3
    x(i+4,:) = x(i+3,:) + h/24*(55*f(t(i+3),x(i+3,:))-59*f(t(i+2),x(i+2,:))+37*f(t(i+1),x(i+1,:))-9*f(t(i),x(i,:)));
    t(i+4) = t(i+3) + h;
end
t = t';