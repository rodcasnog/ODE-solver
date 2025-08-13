function [t,x]=mab2am2(f,intervalo,x0,N)

h = (intervalo(2) - intervalo(1))/N;
t(1) = intervalo(1);
x(1,:) = x0;

% Inicializa con meulermej
F1 = f(t(1),x(1,:));
F2 = f(t(1)+h,x(1,:)+h.*F1);
x(2,:) = x(1,:) + h * (F1+F2)/2;
t(2) = t(1) + h;

% PECE con ab2 predictor, am2 corrector
for i=1:1:N-1
    
    t(i+2) = t(i+1) + h;
    
    x(i+2,:) = x(i+1,:) + h/2*(3*f(t(i+1),x(i+1,:))-f(t(i),x(i,:))); % ab2
    
    x(i+2,:) = x(i+1,:) + h/12*(5*f(t(i+2),x(i+2,:))+8*f(t(i+1),x(i+1,:))-f(t(i),x(i,:))); % am2
    
end
t = t';