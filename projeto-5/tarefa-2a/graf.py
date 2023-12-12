import matplotlib.pyplot as plt
import numpy as np

# Lendo os dados da órbita
dados_orbita = np.loadtxt('orbita.dat')
x = dados_orbita[:, 0]
y = dados_orbita[:, 1]

# Defina o valor da posição y do segundo foco aqui (substitua Y_SEGUNDO_FOCO pelo valor real)
Y_SEGUNDO_FOCO = 0.62436969212943594# insira o valor aqui

# Plotando a órbita com o segundo foco
plt.figure(figsize=(8, 8))
plt.plot(x, y, label='Trajetória do Planeta')
plt.scatter([0], [0], color='red', label='Sol')  # Posição do Sol
plt.scatter([0], [Y_SEGUNDO_FOCO], color='blue', label='Segundo Foco')  # Segundo Foco
plt.xlabel('X')
plt.ylabel('Y')
plt.title('Visualização da Órbita')
plt.legend()
plt.grid(True)
plt.axis('equal')
plt.show()

# Lendo os dados da primeira lei de Kepler
dados_1alei = np.loadtxt('1alei.dat')
tempo_1alei = dados_1alei[:, 0]
dist_1alei = dados_1alei[:, 1]

# Plotando os dados da primeira lei de Kepler com eixo y ajustado
plt.figure(figsize=(8, 6))
plt.plot(tempo_1alei, dist_1alei, label='Distância Focal Total')
plt.xlabel('Tempo')
plt.ylabel('Distância Focal Total')
plt.title('Verificação da Primeira Lei de Kepler')
plt.legend()
plt.grid(True)
plt.ylim(0, 2)  # Ajustando o limite do eixo y
plt.show()

# Lendo os dados da segunda lei de Kepler
dados_2alei = np.loadtxt('2alei.dat')
tempo_2alei = dados_2alei[:, 0]
area_2alei = dados_2alei[:, 1]

# Plotando os dados da segunda lei de Kepler com eixo y ajustado
plt.figure(figsize=(8, 6))
plt.plot(tempo_2alei, area_2alei, label='Área Varrida')
plt.xlabel('Tempo')
plt.ylabel('Área Varrida')
plt.title('Verificação da Segunda Lei de Kepler')
plt.legend()
plt.grid(True)
plt.ylim(0, 1e-4)  # Ajustando o limite do eixo y
plt.show()
