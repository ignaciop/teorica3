%Script general para hacer una corrida  a un set de parametros
%(beta, lado de la red)

%Lado de la red
L = 32;

%Valores de T y vectores iniciales para <E>, <M>, Cv y Xm
T = 0:0.2:10;
Energia_t = [];
Magnet_t = [];
Cv_t = [];
Xm_t = [];
corr_funcs = [];


%Calculo, para cada temperatura, el estado del sistema y sus variables
%termodinamicas y las guardo en los vectores definidos anteriormente
for t=T

    [E, M, Cv, Xm, corr_func] = Ising2D0(L,t,3000,'n');
    
      
    Energia_t = [Energia_t; E];
    Magnet_t = [Magnet_t; M];
    
    Cv_t = [Cv_t; Cv];
    Xm_t = [Xm_t; Xm];
    corr_funcs = [corr_funcs; corr_func];


      
end



%Otros plots que pueden/deben hacer, sobreescribe los anteriores.
figure()
scatter(T, Energia_t/(L*L),'b.')
title(['Energia  media  por  sitio  para  L =  ',num2str(L)])
legend('Datos')
xlabel('T')
ylabel('<E> / (L^2)')

figure()
scatter(T, abs(Magnet_t)/(L*L),'b.')
title(['Magnetizacion  media  por  sitio  para  L =  ',num2str(L)])
legend('Datos')
xlabel('T')
ylabel('<M> / (L^2)')

figure()
scatter(T, Cv_t/(L*L),'r.')
title(['Calor  especifico  por  sitio  para  L =  ',num2str(L)])
legend('Datos')
xlabel('T')
ylabel('Cv / (L^2)')

figure()
scatter(T, Xm_t/(L*L),'r.')
title(['Susceptibilidad  magnetica  por  sitio  para  L =  ',num2str(L)])
legend('Datos')
xlabel('T')
ylabel('Xm / (L^2)')

figure()
scatter(T, corr_funcs,'g.')
title(['Longitud de correlacion  para  L =  ',num2str(L)])
legend('Datos')
xlabel('T')
ylabel('Long. de correlacion')
