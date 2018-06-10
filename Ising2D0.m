%Script general para hacer una corrida  a un set de parametros
%(beta, lado de la red)

%Lado de la red,
L=10;
%beta = 1/T
beta=0.1;

%propongo un estado inicial al azar
%S es una matriz de 1 y -1 indicando las dos proyecciones de
%espin
S=2*(rand(L,L)>0.5) -1;

npre = 100;
npasos = 1e3;
energia=zeros(npasos+1,1);
magnet=zeros(npasos+1,1);

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