function [t,x]=mab4am4(f,intervalo,x0,N)

h = (intervalo(2) - intervalo(1))/N;
t(1) = intervalo(1);
x(1,:) = x0;

% Inicializa con mrk4
for i=1:1:4
    F1 = f(t(i),x(i,:));
    F2 = f(t(i)+h/2,x(i,:)+h/2.*F1);
    F3 = f(t(i)+h/2,x(i,:)+h/2.*F2);
    F4 = f(t(i)+h,x(i,:)+h*F3);
    x(i+1,:) = x(i,:) + h * (F1+2*F2+2*F3+F4)/6;
    t(i+1) = t(i) + h;
end

% PECE con ab4 predictor, am4 corrector
for i=1:1:N-3
    
    t(i+4) = t(i+3) + h;
    
    x(i+4,:) = x(i+3,:) + h/24*(55*f(t(i+3),x(i+3,:))-59*f(t(i+2),x(i+2,:))+37*f(t(i+1),x(i+1,:))-9*f(t(i),x(i,:))); % ab4
    
    x(i+4,:) = x(i+3,:) + h/720*(251*f(t(i+4),x(i+4,:))+646*f(t(i+3),x(i+3,:))-264*f(t(i+2),x(i+2,:))+106*f(t(i+1),x(i+1,:))-19*f(t(i),x(i,:))); % am4
    
end
t = t';