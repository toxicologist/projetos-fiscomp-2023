import numpy as np
import matplotlib.pyplot as plt
from matplotlib.animation import FuncAnimation

fator = 100

# Carregando os dados da Terra
data_terra = np.loadtxt('terra.dat')
x_terra = data_terra[:, 0][::fator]
y_terra = data_terra[:, 1][::fator]

# Carregando os dados de Júpiter
data_jupiter = np.loadtxt('jupiter.dat')
x_jupiter = data_jupiter[:, 0][::fator]
y_jupiter = data_jupiter[:, 1][::fator]

# Configurando a figura e o eixo
fig, ax = plt.subplots(figsize=(16, 12))
line_terra, = ax.plot([], [], 'o-', lw=1, markersize=0.5, color='blue', label='Trajetória da Terra')
line_jupiter, = ax.plot([], [], 'o-', lw=1, markersize=0.5, color='red', label='Trajetória de Júpiter')
ax.set_title('Animação das Órbitas da Terra e Júpiter')
ax.set_xlabel('Posição X')
ax.set_ylabel('Posição Y')
ax.legend()
ax.grid(True)

# Ajustando limites do eixo
ax.set_xlim(min(min(x_terra), min(x_jupiter)), max(max(x_terra), max(x_jupiter)))
ax.set_ylim(min(min(y_terra), min(y_jupiter)), max(max(y_terra), max(y_jupiter)))

# Função de inicialização
def init():
    line_terra.set_data([], [])
    line_jupiter.set_data([], [])
    return line_terra, line_jupiter

# Função de animação
def animate(i):
    line_terra.set_data(x_terra[:i+1], y_terra[:i+1])
    line_jupiter.set_data(x_jupiter[:i+1], y_jupiter[:i+1])
    return line_terra, line_jupiter

# Criando a animação
ani = FuncAnimation(fig, animate, frames=min(len(x_terra), len(x_jupiter)), init_func=init, blit=True, interval=1)

#ani.save('orbitas.mp4', writer='ffmpeg', fps=60)

# Mostrar a animação
plt.show()
