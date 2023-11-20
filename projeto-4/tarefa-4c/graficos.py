import subprocess
import matplotlib.pyplot as plt
import numpy as np
import itertools

# Configurar para tema escuro
plt.style.use('dark_background')

# Alphas e t_trans
#alphas = [0.5, 0.75, 1.0, 1.25, 1.4, 1.5, 1.2, 10.0]
#t_trans = [20.0, 50.0, 30.0, 0.0, 0.0, 0.0, 0.0, 0.0]
alphas = [1.5]
t_trans = [0.0]

# Valores iniciais de teta0 e w0
teta0_values = [0, 0.01 * np.pi, 0.02 * np.pi, 0.03 * np.pi]
w0_values = [0, 1e-3, 1e-4, 5e-4, 5e-3, 1e-4]
#teta0_values = [0, 0.5*np.pi]#, 1*np.pi]
#teta0_values=[0]
#w0_values = [1, 1e-3, 1e-4, 1e-1]

# Paleta de cores neon
colors = ['magenta', 'lime', 'cyan', 'yellow', 'orange', 'hotpink', 'red', 'violet', 'aqua', 'orangered', 'crimson']

# Compilar o código Fortran
subprocess.run(["gfortran", "-o", "tarefa-4c.exe", "tarefa-4c.f"])

for i, (alpha, trans) in enumerate(zip(alphas, t_trans)):
    print("plotando i", str(i), alpha)

    plt.figure(figsize=(12, 8))

    for (teta0, w0), color in zip(itertools.product(teta0_values, w0_values), itertools.cycle(colors)):
        # Executar o programa Fortran com os valores atuais
        input_values = f"{alpha:.8f}d0\n{trans:.8f}d0\n{teta0:.8f}d0\n{w0:.8f}d0\n"
        subprocess.run(["./tarefa-4c.exe"], input=input_values.encode())

        # Ler os dados do arquivo
        theta, w = np.loadtxt('tarefa-4b-saida.dat', unpack=True)

        # Tamanho dos símbolos
        marker_size = 0.5 #if i < 3 else 1

        # Plotar os dados
        plt.plot(theta, w, 'o', color=color, markersize=marker_size)

    # Ajustar os limites dos eixos para os primeiros três alphas
    #if i < 3:
    #    plt.xlim(-np.pi, np.pi)
    #    plt.ylim(-1, 1)

    plt.xlabel('θ')
    plt.ylabel('w')
    plt.title(f'Seção de Poincaré para alpha={alpha} (gamma=0.15)')
    plt.tight_layout()
    plt.savefig(f'secao_poincare_0.15_alpha_{alpha}.png')
    plt.close()
