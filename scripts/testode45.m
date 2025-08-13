datos
[t,x] = ode45(@(t,x) f(t,x)',linspace(intervalo(1),intervalo(2),N),x0);
graficas