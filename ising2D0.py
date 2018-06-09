#script general para hacer una corrida a un set de parámetros,
#beta, tamaño de la red,

import numpy as np
from matplotlib import pyplot

#############################################################
# estas son las funciones que tienen que escribir ustedes
# calcMagnet ya esta lista

def calcMagnet(S):
    
    M = np.sum(S)
    
    return M

def calcEnergia(S):
    
    #    return E
    return 0

def ising2Dpaso(S, beta):
    
    #    return nuevo_S, dE, dM
    return S, 0, 0

#############################################################

#Aca defino los parámetros y corro la cadena de markov
#Lado de la red,
L = 10
# beta = 1/T
beta = 0.1

#propongo un estado inicial al azar
#S es una matriz de 1 y -1 indicando las dos proyecciones de
#espin
S = 2*(np.random.rand(L,L)>0.5) -1;

npre = 100
npasos = 1000
energia= np.zeros(npasos)
magnet = np.zeros(npasos)

#pretermalizo
#ising2Dpaso hace un nuevo elemento de la cadena de Markov
#la tienen que escribir Uds...
for n in range(npre):
    S, dE, dM = ising2Dpaso(S,beta)

# muestro el estado inicial
pyplot.imshow(S,interpolation='none')
pyplot.show(block=False)

energia[0] = calcEnergia(S)
magnet[0] = calcMagnet(S)

for n in range(npasos-1):
    S, dE, dM = ising2Dpaso(S,beta);
    energia[n+1] = energia[n] + dE;
    magnet[n+1] = magnet[n] + dM;
    
    #cada 10 pasos muestro el nuevo estado
    if n%10 == 0:
        pyplot.imshow(S,interpolation='none')
        pyplot.title("n=%i beta=%.2f mag=%.2f energia=%.2f"%(n,beta,magnet[n],energia[n]))
        pyplot.draw()
