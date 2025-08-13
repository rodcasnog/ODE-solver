% DATOS

f = @(t,x) 2*x.*(5-x);
sol = @(t,x) 15./(3+2*exp(-10*t));
intervalo=[0,2];
x0=3;
N=200;


% INICIALIZACION DE LAS VARIABLES

h = (intervalo(2) - intervalo(1))/N;
t = intervalo(1):h:intervalo(2);
x(1,:) = x0;


% Inicializamos con meuler

x(2,:) = x(1,:) + h * f(t(1),x(1,:));


% P(EC)E con meuler predictor, BDF2 corrector

for i=1:1:N-1
    
%     (EVALUACION + ) PREDICCION
    x(i+2,:) = x(i+1,:) + h * f(t(i+1),x(i+1,:));
    
%     (EVALUACION + ) CORRECCION
    x(i+2,:) = 4/3 * x(i+1,:) - 1/3 * x(i,:) + h * 2/3 * f(t(i+2),x(i+2,:));
    
end

% N�tese que hemos de desplazar un �nidice la sintaxis usual del m�todo
% de euler, como si ahora fuera de 2 pasos, para que se corresponda con
% el m�todo BDF que s� tiene 2 pasos.

% A modo de comentario, como se puede observar, la sintaxis no sigue el
% esquema PECE literalmente, si no que tal y como est� redactado el c�gigo, m�s bien es
% un esquema EPEC. No obstante, es claramente completamente equivalente, 
% y de hecho as� se recoge dentro del propio bucle la consideraci�n particular de la
% �ltima iteraci�n que ahorra la �ltima evaluaci��n de f, sin necesidad de sacarla del bucle.

t = t';


% DIBUJAMOS LA SOLUCION OBTENIDA JUNTO CON LA EXACTA

xexac = sol(t);

figure
plot(t,x,'r-')
hold on
plot(t,xexac,'k-')
xlim([intervalo(1),intervalo(2)])
title('Ejercicio 4')
legend('Soluci�n num�rica','Soluci�n exacta')


% CALCULAMOS EL ERROR ABSOLUTO GLOBAL DE DISCRETIZACION

format longg
eps = max( abs( x-xexac ) );
fprintf('El error absoluto global de discretizaci�n es: %f1\n',eps)