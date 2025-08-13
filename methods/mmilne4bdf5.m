function [t,x]=mmilne4bdf5(f,intervalo,x0,N)

h = (intervalo(2) - intervalo(1))/N;
t(1) = intervalo(1);
x(1,:) = x0;

% Inicializa con mrk4
for i=1:1:5
    F1 = f(t(i),x(i,:));
    F2 = f(t(i)+h/2,x(i,:)+h/2.*F1);
    F3 = f(t(i)+h/2,x(i,:)+h/2.*F2);
    F4 = f(t(i)+h,x(i,:)+h*F3);
    x(i+1,:) = x(i,:) + h * (F1+2*F2+2*F3+F4)/6;
    t(i+1) = t(i) + h;
end

% PECE con milne4 predictor, BDF corrector
for i=1:1:N-4
    
    t(i+5) = t(i+4) + h;
    
    x(i+5,:) = x(i+1,:) + 4*h/3*(2*f(t(i+4),x(i+4,:))-f(t(i+3),x(i+3,:))+2*f(t(i+2),x(i+2,:))); % milne4
    
    x(i+5,:) = ( 300*x(i+4,:) - 300*x(i+3,:) + 200*x(i+2,:) - 75*x(i+1,:) + 12*x(i,:) + h*60*f(t(i+5),x(i+5,:)) )/137; % BDF
    
end
t = t';