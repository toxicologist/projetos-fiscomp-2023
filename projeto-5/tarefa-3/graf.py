import numpy as np
import matplotlib.pyplot as plt

# Carregando os dados usando NumPy
data = np.loadtxt('terra.dat')
x = data[:, 0]
y = data[:, 1]

# Criando o gráfico
plt.figure(figsize=(8, 8))
plt.plot(x, y, label='Trajetória da Terra')
plt.title('Trajetória da Terra ao Redor do Sol')
plt.xlabel('Posição X')
plt.ylabel('Posição Y')
plt.legend()
plt.grid(True)
plt.show()
