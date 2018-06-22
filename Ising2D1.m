%Script general para hacer una corrida  a un set de parametros
%(beta, lado de la red)

%Lado de la red
L = 16;

T = 0:0.2:5;
energia_t = [];
magnet_t = [];
cv_t = [];
xm_t = [];


for t=T

    [S, cv, xm] = Ising2D0(L,t);
    
    e = En(S);
    m = sum(sum(S));
      
    energia_t = [energia_t; e];
    magnet_t = [magnet_t; m];
    
    cv_t = [cv_t; cv];
    xm_t = [xm_t; xm];

      
end



%Otros plots que pueden/deben hacer, sobreescribe los anteriores.
figure()
scatter(T, energia_t/(L*L),'.')
xlabel('T')
ylabel('Energia por sitio')

figure()
title(['L = ' num2str(L)]);
scatter(T, abs(magnet_t)/(L*L),'.')
xlabel('T')
ylabel('Magnetizacion por sitio')

figure()
title(['L = ' num2str(L)]);
scatter(T, cv_t/(L*L),'.')
xlabel('T')
ylabel('Cv por sitio')

figure()
title(['L = ' num2str(L)]);
scatter(T, xm_t/(L*L),'.')
xlabel('T')
ylabel('Susc. por sitio')
