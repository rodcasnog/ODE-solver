% 1D
f = @(t,x) sin(t.*x); g = @(t,x) cos(t.*x).*(x+t.*sin(t.*x)); intervalo=[0,8*pi]; x0=4; N=1e3;
% 2D
% f=@(t,x) [x(2),-9*x(1)+8*sin(t)]; intervalo=[0,2*pi]; x0=[0,4]; N=1e3;
% k=1; m=1; f=@(t,x) [x(2),-(k/m)*x(1)]; intervalo=[0,10]; x0=[1,0]; N=1e3;
% LORENZ; r = 470/19
% r = 99.5; f = @(t,x) [10*(x(2)-x(1)), r*x(1)-x(1).*x(3)-x(2), x(1).*x(2)-8/3*x(3)]; intervalo=[0,100]; x0=[5,-5,15]; N=1e5;
% r = 470/19; f = @(t,x) [10*(x(2)-x(1)), r*x(1)-x(1).*x(3)-x(2), x(1).*x(2)-8/3*x(3)]; intervalo=[0,100]; x0=[5,-5,15]; N=1e4;
% EJEMPLOS CON SOL EXACTA 2D
% f = @(t,x) [-.1*x(1)+2*x(2),-2*x(1)-.1*x(2)]; fexacta = @(t) [exp(-.1*t).*sin(2*t);exp(-.1*t).*cos(2*t)]; intervalo=[0,10]; x0=[0,1]; N=1e3;
% f = @(t,x) [x(2),-2*x(1)+cos(3*t)]; fexacta = @(t) [8/7*cos(sqrt(2)*t)-1/7*cos(3*t);-sqrt(2)*8/7*sin(sqrt(2)*t)+3/7*sin(3*t)]; intervalo=[0,10]; x0=[1,0]; N=1e3;
% PÉNDULO OSCILANTE
% b=0.5; F=1.1; T=10; m=1; L=1; g=9.8; t0=asin(1/g); v0=0; f = @(t,x) [x(2),(F-m*g*sin(x(1))-2*L*b*x(2))/m/L]; intervalo=[0,T]; x0=[t0,v0]; N=1e4;
% b=0; F=0; T=20; t0=pi/20; v0=0; m=1; L=1; g=9.8; f = @(t,x) [x(2),(F-m*g*x(1)-2*L*b*x(2))/m/L]; intervalo=[0,T]; x0=[t0,v0]; N=1e3;
% LOTKA-VOLTERRA: PREDADOR PRESA
% a=3; b=.2; c=.6; d=5; f = @(t,x) [a*x(1)-b*x(1).*x(2),-c*x(1)+d*x(1).*x(2)]; intervalo=[0,3]; x0=[5,5]; N=1e4;
% a=1; b=1; c=1; d=1; e=.4; f=.02; f = @(t,x) [a*x(1)-b*x(1).*x(2)-e*x(1).^2,-c*x(1)+d*x(1).*x(2)-f*x(2).^2]; intervalo=[0,3]; x0=[5,5]; N=1e4;
% VAN DER POL
% a=8; b=1; f = @(t,x) [x(2),-a*(x(1).^2-b).*x(2)-x(1)]; intervalo=[0,40]; x0=[0,1]; N=1e4;
% ECUACIÓN DE DUFFING
% a=.5; f = @(t,x) [x(2),-a*x(2)-x(1).^3+x(1)]; intervalo=[0,40]; x0=[10,0]; N=1e5;
% OSCILADOR ARMÓNICO FORZADO
% A=10; a=10; b=0; w=10.5;  f = @(t,x) [x(2),-2*b*x(2)-a^2*x(1)+A*cos(w*t)]; intervalo=[0,10*pi]; x0=[0,0]; N=1e4;