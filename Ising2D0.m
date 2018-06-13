%Script general para hacer una corrida  a un set de parametros
%(beta, lado de la red)

%Lado de la red
global L=10;

%beta = 1/T
beta=0.1;


%propongo un estado inicial al azar
%S es una matriz de 1 y -1 indicando las dos proyecciones de
%espin
S=2*(rand(L,L)>0.5) -1;

npre = 100;
npasos = 2e5;
energia=zeros(npasos+1,1);
magnet=zeros(npasos+1,1);

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

	e = e + S(h,k)*sum(prox_vecinos);
	endfor
endfor

e = -0.5*e;
end


%Pretermalizo
%La funcion ising2Dpaso hace un nuevo elemento de la cadena de Markov. La tienen que escribir uds!
for n=1:npre
[S, DE, DM]=ising2Dpaso(S,beta);
end

%La funcion En calcula la energia de la red. Tambien la tienen que escribir uds!
energia(1) = En(S);
magnet(1) = sum(sum(S));
for n=1:npasos
[S,DE,dM] = ising2Dpaso(S,beta);
energia(n+1) = energia(n) + DE;
magnet(n+1) = magnet(n) + dM;

if(mod(n,10) == 0)
imagesc(S);shading flat;
title(['T = ' num2str(1/beta) ' e = ' num2str(energia(n)/(L*L)) ' m = ' num2str(magnet(n)/(L*L))]);
drawnow;
end


end

%Otros plots que pueden/deben hacer, sobreescribe los anteriores.
plot(energia/(L*L))
xlabel('paso')
ylabel('Energia por sitio')

plot(magnet/(L*L))
xlabel('paso')
ylabel('Magnetizacion por sitio')