function [E, M, Cv, Xm] = ising2D0(L,T)
%Script general para hacer una corrida  a un set de parametros
%(beta, lado de la red)

%Lado de la red
%L = 16;
%T = 2.1;

beta = 1/T;


%propongo un estado inicial al azar
%S es una matriz de 1 y -1 indicando las dos proyecciones de
%espin
S = 2*(rand(L,L) > 0.5) - 1;

npre = 100;
npasos = 5000;
energia = zeros(npasos + 1,1);
magnet = zeros(npasos + 1,1);
energia2 = zeros(npasos + 1,1);
magnet2 = zeros(npasos + 1,1);


%Pretermalizo
%La funcion ising2Dpaso hace un nuevo elemento de la cadena de Markov. La tienen que escribir uds!
for n=1:npre
    [S, dE, dM] = ising2Dpaso(S,beta);
end

%La funcion En calcula la energia de la red. Tambien la tienen que escribir uds!
energia(1) = En(S);
magnet(1) = sum(sum(S));
energia2(1) = energia(1)*energia(1);
magnet2(1) = magnet(1)*magnet(1);

for n=1:npasos
    [S, dE, dM] = ising2Dpaso(S,beta);
    
    energia(n+1) = energia(n) + dE;
    magnet(n+1) = magnet(n) + dM;
    energia2(n+1) = energia2(n) + dE*dE;
    magnet2(n+1) = magnet2(n) + dM*dM;

    %if(mod(n,10) == 0)
     %   imagesc(S);shading flat;
      %  title(['n = ' num2str(n) ' T = ' num2str(1/beta) ' e = ' num2str(energia(n)/(L*L)) ' m = ' num2str(magnet(n)/(L*L))]);
       % drawnow;
    %end
end

E = mean(energia);
M = mean(magnet);
E2 = mean(energia2);
M2 = mean(magnet2);
Cv = (E2 - E*E)/(T*T);
Xm = (M2 - M*M)/T;


%Otros plots que pueden/deben hacer, sobreescribe los anteriores.
%figure()
%plot(energia/(L*L))
%xlabel('paso')
%ylabel('Energia por sitio')

%figure()
%title(['L = ' num2str(L)]);
%plot(abs(magnet)/(L*L))
%xlabel('paso')
%ylabel('Magnetizacion por sitio')
end