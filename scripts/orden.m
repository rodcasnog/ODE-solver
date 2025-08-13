function c=orden(rho,sigma)

format LONGG

raices=roots(rho)

if abs(polyval(rho,1)) > 1e-6
    display('Método inconsistente!!')
    return
end

r = length(rho)-1;

rho1(1)=0;
sigma1(1)=0;
for k=0:1:r
    rho1(k+1) = rho(r+1-k);
    sigma1(k+1) = sigma(r+1-k);
end
rho=rho1;
sigma=sigma1;

j=1;
c(j) = 0;
for k=1:1:r+1
    c(j) = c(j) + (k-1)*rho(k) - sigma(k);
end

while abs(factorial(j)*c(j)) < 1e-6
    j=j+1;
    c(j) = 0;
    for k=2:1:r+1
        c(j) = c(j) + ((k-1)*rho(k) - j*sigma(k))*(k-1)^(j-1);
    end
    c(j) = c(j)/factorial(j);
end

fprintf('El orden del método es: %i',j-1)
c=c';