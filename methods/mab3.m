function [t,x]=mab3(f,intervalo,x0,N)

% orden de precisión , y si e_0(h)=O(h^), tmb e(h)=O(h^)

h = (intervalo(2) - intervalo(1))/N;
t(1) = intervalo(1);
x(1,:) = x0;

% Inicializa con meulermej
for i=1:1:2
    F1 = f(t(i),x(i,:));
    F2 = f(t(i)+h,x(i,:)+h.*F1);
    x(i+1,:) = x(i,:) + h * (F1+F2)/2;
    t(i+1) = t(i) + h;
end

for i=1:1:N-2
    x(i+3,:) = x(i+2,:) + h/12*(23*f(t(i+2),x(i+2,:))-16*f(t(i+1),x(i+1,:))+5*f(t(i),x(i,:)));
    t(i+3) = t(i+2) + h;
end
t = t';