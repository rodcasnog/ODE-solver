function [t,x]=mab2(f,intervalo,x0,N)

% orden de precisión 2, y si e_0(h)=O(h^2), tmb e(h)=O(h^2)

h = (intervalo(2) - intervalo(1))/N;
t(1) = intervalo(1);
x(1,:) = x0;

% Inicializa con meuler
x(2,:) = x(1,:) + h*f(t(1),x(1,:));
t(2) = t(1) + h;

for i=1:1:N-1
    x(i+2,:) = x(i+1,:) + h/2*(3*f(t(i+1),x(i+1,:))-f(t(i),x(i,:)));
    t(i+2) = t(i+1) + h;
end
t = t';