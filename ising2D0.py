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
	e = 0
	for i in range(len(S)):
		for j in range(len(S)):
			if i == 0:
				im = len(S)-1
			else:
				im = i -1
			
			if i == len(S) - 1:
				ip = 0
			else:
				ip = i + 1
				
			if j == 0:
				jm = len(S)-1
			else:
				jm = j - 1
            
			if j == len(S)-1:
				jp = 0
			else:
				jp = j + 1

			e = e - S[i][j]*(S[ip][j]+S[i][jp]+S[im][j]+S[i][jm])
 						
	return e/4.

def ising2Dpaso(S, beta):
	dM = 0
	for h in range(len(S)):
		for k in range(len(S)):
			i = np.random.randint(0,len(S))
			j = np.random.randint(0,len(S))
	
			if i == 0:
				im = len(S)-1
			else:
				im = i -1
			
			if i == len(S) - 1:
				ip = 0
			else:
				ip = i + 1
				
			if j == 0:
				jm = len(S)-1
			else:
				jm = j - 1
            
			if j == len(S)-1:
				jp = 0
			else:
				jp = j + 1
				
			vecinos = S[i][j]*(S[ip][j]+S[i][jp]+S[im][j]+S[i][jm])
	
			dE = 2*S[i][j]*vecinos

			if ((dE <= 0) or (np.random.rand() < np.exp(-beta*dE))):
				S[i][j] *= -1
				dM += 2*S[i][j]
	
	
	return S, dE, dM

#############################################################

#Aca defino los parámetros y corro la cadena de markov
#Lado de la red,
L = 16
T = 0.01
beta = 1/T

#propongo un estado inicial al azar
#S es una matriz de 1 y -1 indicando las dos proyecciones de
#espin
S = 2*(np.random.rand(L,L)>0.5) -1;

npre = 100
npasos = 10000
energia= np.zeros(npasos)
magnet = np.zeros(npasos)

#pretermalizo
#ising2Dpaso hace un nuevo elemento de la cadena de Markov
#la tienen que escribir Uds...
for n in range(npre):
    S, dE, dM = ising2Dpaso(S,beta)

# muestro el estado inicial
#pyplot.imshow(S,interpolation='none')
#pyplot.show(block=False)

energia[0] = calcEnergia(S)
magnet[0] = calcMagnet(S)

for n in range(npasos-1):
	S, dE, dM = ising2Dpaso(S,beta);
	energia[n+1] = energia[n] + dE;
	magnet[n+1] = magnet[n] + dM;
	
    #cada 10 pasos muestro el nuevo estado
	#if n%10 == 0:
		#pyplot.figure(1)
		#pyplot.imshow(S,interpolation='none')
		#pyplot.title("n=%i beta=%.2f mag=%.2f energia=%.2f"%(n,beta,magnet[n],energia[n]))
		#pyplot.show()

pyplot.figure(1)
pyplot.plot(energia/(L*L))
pyplot.xlabel('Iteracion')
pyplot.ylabel('Energia por sitio')
pyplot.show()
	
pyplot.figure(2)
pyplot.plot(magnet/(L*L))
pyplot.xlabel('Iteracion')
pyplot.ylabel('Magnetizacion por sitio')
pyplot.show()