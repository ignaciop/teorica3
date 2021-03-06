function [E, M, Cv, Xm, corr_func] = ising2D0(L,T,npasos,a)
    %Script general para hacer una corrida  a un set de parametros
    %(beta, lado de la red)

    beta = 1/T;


    %propongo un estado inicial al azar
    %S es una matriz de 1 y -1 indicando las dos proyecciones de
    %espin
    S = 2*(rand(L,L) > 0.5) - 1;

    %Condiciones iniciales y vectores para guardar los valores de energia, 
    %magnetizacion, energia^2 y magnetizacion^2 para un valor de T
    npre = 100;
    energia = zeros(npasos + 1,1);
    magnet = zeros(npasos + 1,1);
    energia2 = zeros(npasos + 1,1);
    magnet2 = zeros(npasos + 1,1);


    %Pretermalizo
    %La funcion ising2Dpaso hace un nuevo elemento de la cadena de Markov. La tienen que escribir uds!
    for n=1:npre
        [S, dE, dM,Sis,SiSjs] = ising2Dpaso(S,beta);
    end

    %La funcion En calcula la energia de la red. Tambien la tienen que escribir uds!
    energia(1) = En(S);
    magnet(1) = sum(sum(S));
    energia2(1) = energia(1)*energia(1);
    magnet2(1) = magnet(1)*magnet(1);

    %Ciclo para calcular el estado de S luego de termalizar
    for n=1:npasos
        [S, dE, dM,Sis,SiSjs] = ising2Dpaso(S,beta);

        energia(n+1) = energia(n) + dE;
        magnet(n+1) = magnet(n) + dM;
        energia2(n+1) = energia2(n) + dE*dE;
        magnet2(n+1) = magnet2(n) + dM*dM;

        %El tercer parametro de entrada es para mostrar/ocultar los graficos.
        %Util para el ejercicio siguiente
        if a == 'y'
            if(mod(n,10) == 0)
                imagesc(S);shading flat;
                title(['n = ' num2str(n) ' T = ' num2str(1/beta) ' e = ' num2str(energia(n)/(L*L)) ' m = ' num2str(magnet(n)/(L*L))]);
                drawnow;
            end
        end
    end

    %Valores medios de los vectores previamente calculados:
    %<E>, <M>, Cv = (1/T^2)*(<E^2> - <E>^2), Xm = (1/T)*(<M^2> - <M>^2)
    E = mean(energia);
    M = mean(magnet);
    E2 = mean(energia2);
    M2 = mean(magnet2);
    Cv = (E2 - E*E)/(T*T);
    Xm = (M2 - M*M)/T;
    
    %Variables para calcular la longuitud de correlacion: <Si> y <SiSj>
    Si_avg = mean(Sis);
    SiSj_avg = mean(SiSjs);
    corr_func = abs(SiSj_avg - Si_avg*Si_avg);


    %Otros plots que pueden/deben hacer, sobreescribe los anteriores.
    if a == 'y'
        figure()
        plot(energia/(L*L))
        title(['L = ' num2str(L)])
        xlabel('Paso')
        ylabel('Energia  por  sitio')

        figure()
        plot(abs(magnet)/(L*L))
        title(['L = ' num2str(L)])
        xlabel('Paso')
        ylabel('Magnetizacion  por  sitio')
    end
end