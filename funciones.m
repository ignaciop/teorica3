global L=10;

%Funcion que genera una matriz de nxm con los numeros enteros generados uniformemente en el intervalo (a,b)
function rn = randint(n,m,a,b)
rn = 1 + floor((a-1) + (b-(a-1))* rand(n,m));
end

function [S,DE,DM] = ising2Dpaso(S,beta)
global L;
indices = randint(1,2,1,L);
h = indices(1); k = indices(2);

if h == L
	S(h+1,k) = S(1,k);
endif

if k == L
	S(h,k+1) = S(h,1);
endif

prox_vecinos = [S(h+1,k);S(h,k+1)];

DE = 2*S(h,k)*sum(prox_vecinos);

if (DE <= 0 || rand() <= exp(-beta*DE))
	S(h,k) = -S(h,k);
endif

%DM = 2*S(h,k);
DM = sum(sum(S)); %Probar con esto!!
end

function e = En(S)
global L;
e = 0;
for h=1:L
	for k=1:L

	if h == L
		S(h+1,k) = S(1,k);
	endif

	if k == L
		S(h,k+1) = S(h,1);
	endif


	prox_vecinos = [S(h+1,k);S(h,k+1)];

	e = e - S(h,k)*sum(prox_vecinos);
	endfor
endfor

e = e/4;
end
