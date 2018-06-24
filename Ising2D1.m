%Script general para hacer una corrida  a un set de parametros
%(beta, lado de la red)

%Lado de la red
L = 16;

%Valores de T y vectores iniciales para <E>, <M>, Cv y Xm
T = 0:0.2:10;
Energia_t = [];
Magnet_t = [];
Cv_t = [];
Xm_t = [];

%Calculo, para cada temperatura, el estado del sistema y sus variables
%termodinamicas y las guardo en los vectores definidos anteriormente
for t=T

    [E, M, Cv, Xm] = Ising2D0(L,t);
    
      
    Energia_t = [Energia_t; E];
    Magnet_t = [Magnet_t; M];
    
    Cv_t = [Cv_t; Cv];
    Xm_t = [Xm_t; Xm];

      
end



%Otros plots que pueden/deben hacer, sobreescribe los anteriores.
figure()
scatter(T, Energia_t/(L*L),'b.')
title(['Energia media por sitio para L = ',num2str(L)])
legend('Datos')
xlabel('$T$', 'Interpreter', 'latex')
ylabel('$\frac{<E>}{L^{2}}$', 'Interpreter', 'latex')

figure()
scatter(T, abs(Magnet_t)/(L*L),'b.')
title(['Magnetizacion media por sitio para L = ',num2str(L)])
legend('Datos')
xlabel('$T$', 'Interpreter', 'latex')
ylabel('$\frac{<M>}{L^{2}}$', 'Interpreter', 'latex')

figure()
scatter(T, Cv_t/(L*L),'r.')
title(['Calor especifico por sitio para L = ',num2str(L)])
legend('Datos')
xlabel('$T$', 'Interpreter', 'latex')
ylabel('$\frac{C_{v}}{L^{2}}$', 'Interpreter', 'latex')

figure()
scatter(T, Xm_t/(L*L),'r.')
title(['Susceptibilidad magnetica por sitio para L = ',num2str(L)])
legend('Datos')
xlabel('$T$', 'Interpreter', 'latex')
ylabel('$\frac{\chi_{v}}{L^{2}}$', 'Interpreter', 'latex')
