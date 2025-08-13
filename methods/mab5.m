function [t,x]=mab5(f,intervalo,x0,N)

% h = (intervalo(2) - intervalo(1))/N;
% t(1) = intervalo(1);
% x(1,:) = x0;

% % Inicializa con mrk4
% for i=1:1:4
%     F1 = f(t(i),x(i,:));
%     F2 = f(t(i)+h/2,x(i,:)+h/2.*F1');
%     F3 = f(t(i)+h/2,x(i,:)+h/2.*F2');
%     F4 = f(t(i)+h,x(i,:)+h*F3');
%     x(i+1,:) = x(i,:) + h * (F1+2*F2+2*F3+F4)'/6;
%     t(i+1) = t(i) + h;
% end

% for i=1:1:N-4
%     x(i+5,:) = x(i+4,:) + h/720*(1901*f(t(i+4),x(i+4,:))-2774*f(t(i+3),x(i+3,:))+2616*f(t(i+2),x(i+2,:))-1274*f(t(i+1),x(i+1,:))+251*f(t(i),x(i,:)))';
%     t(i+5) = t(i+4) + h;
% end
% t = t';



% versión alternativa y más eficiente:

h = (intervalo(2) - intervalo(1))/N;
t = intervalo(1):h:intervalo(2);
r = 5;

% Inicializa con mrk4

[~,xr] = mrk4(f,[intervalo(1), intervalo(1)+(r-1)*h],x0,r-1);
x(1:r,:) = xr;

eval_f = [f(t(1),x(1,:)); f(t(2),x(2,:)); f(t(3),x(3,:)); f(t(4),x(4,:)); f(t(5),x(5,:))];

for i=1:1:N-4    
    x(i+5,:) = x(i+4,:) + h / 720 * ( 1901*eval_f(mod(i-1+4,r)+1,:) - 2774*eval_f(mod(i-1+3,r)+1,:) + 2616*eval_f(mod(i-1+2,r)+1,:) - 1274*eval_f(mod(i-1+1,r)+1,:) + 251*eval_f(mod(i-1,r)+1,:) );
    eval_f(mod(i-1,r)+1,:) = f(t(i+5),x(i+5,:));
end
t = t';