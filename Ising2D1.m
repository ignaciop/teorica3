%Script general para hacer una corrida  a un set de parametros
%(beta, lado de la red)

%Lado de la red
L = 16;

energia_t = zeros(20 + 1,1);
magnet_t = zeros(20 + 1,1);

energia_t(1) = -2;
magnet_t(1) = 1;

for T=1:0.5:10

    beta = 1/T;


    %propongo un estado inicial al azar
    %S es una matriz de 1 y -1 indicando las dos proyecciones de
    %espin
    S = 2*(rand(L,L) > 0.5) - 1;

    npre = 100;
    npasos = 10000;
    
    energia = zeros(npasos + 1,1);
    magnet = zeros(npasos + 1,1);


    %Pretermalizo
    %La funcion ising2Dpaso hace un nuevo elemento de la cadena de Markov. La tienen que escribir uds!
    for n=1:npre
        [S, dE, dM] = ising2Dpaso(S,beta);
    end

    %La funcion En calcula la energia de la red. Tambien la tienen que escribir uds!
    energia(1) = En(S);
    magnet(1) = sum(sum(S));

    for n=1:npasos
        [S, dE, dM] = ising2Dpaso(S,beta);
    
        energia(n+1) = energia(n) + dE;
        magnet(n+1) = magnet(n) + dM;
    end
    
    energia_t = [energia_t; mean(energia)];
    magnet_t = [magnet_t; mean(magnet)];

    
end

%Otros plots que pueden/deben hacer, sobreescribe los anteriores.
figure()
plot(energia_t/(L*L))
xlabel('T')
ylabel('Energia por sitio')

figure()
title(['L = ' num2str(L)]);
plot(abs(magnet_t)/(L*L))
xlabel('T')
ylabel('Magnetizacion por sitio')