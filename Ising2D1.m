%Script general para hacer una corrida  a un set de parametros
%(beta, lado de la red)

%Lado de la red
L = 16;


T = 1:10;
energia_t = zeros(length(T),1);
magnet_t = zeros(length(T),1);


for t=1:length(T)

    S = Ising2D0(L,t);
    
    e = En(S)/(L*L);
    m = sum(sum(S))/(L*L);
    
    energia_t = [energia_t; e];
    magnet_t = [magnet_t; m];

    
end

%Otros plots que pueden/deben hacer, sobreescribe los anteriores.
figure()
plot(energia_t,'.')
xlabel('T')
ylabel('Energia por sitio')

figure()
title(['L = ' num2str(L)],'.');
plot(magnet_t,'.')
xlabel('T')
ylabel('Magnetizacion por sitio')