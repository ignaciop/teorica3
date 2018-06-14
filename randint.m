%Funcion que genera una matriz de nxm con los numeros enteros generados uniformemente en el intervalo (a,b)
function rn = randint(n,m,a,b)
rn = 1 + floor((a-1) + (b-(a-1))* rand(n,m));
end

