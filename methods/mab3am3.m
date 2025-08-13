function [t,x]=mab3am3(f,intervalo,x0,N)

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

% PECE con ab3 predictor, am3 corrector
for i=1:1:N-2
    
    t(i+3) = t(i+2) + h;
    
    x(i+3,:) = x(i+2,:) + h/12*(23*f(t(i+2),x(i+2,:))-16*f(t(i+1),x(i+1,:))+5*f(t(i),x(i,:))); % ab3
    
    x(i+3,:) = x(i+2,:) + h/24*(9*f(t(i+3),x(i+3,:))+19*f(t(i+2),x(i+2,:))-5*f(t(i+1),x(i+1,:))+f(t(i),x(i,:))); % am3
    
end
t = t';