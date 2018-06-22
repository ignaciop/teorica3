%Script general para hacer una corrida  a un set de parametros
%(beta, lado de la red)

%Lado de la red
L = 16;

T = 0:0.2:10;
Energia_t = [];
Magnet_t = [];
Cv_t = [];
Xm_t = [];


for t=T

    [E, M, Cv, Xm] = Ising2D0(L,t);
    
      
    Energia_t = [Energia_t; E];
    Magnet_t = [Magnet_t; M];
    
    Cv_t = [Cv_t; Cv];
    Xm_t = [Xm_t; Xm];

      
end



%Otros plots que pueden/deben hacer, sobreescribe los anteriores.
figure()
scatter(T, Energia_t/(L*L),'.')
xlabel('T')
ylabel('Energia por sitio')

figure()
title(['L = ' num2str(L)]);
scatter(T, abs(Magnet_t)/(L*L),'.')
xlabel('T')
ylabel('Magnetizacion por sitio')

figure()
title(['L = ' num2str(L)]);
scatter(T, Cv_t/(L*L),'.')
xlabel('T')
ylabel('Cv por sitio')

figure()
title(['L = ' num2str(L)]);
scatter(T, Xm_t/(L*L),'.')
xlabel('T')
ylabel('Susc. por sitio')
