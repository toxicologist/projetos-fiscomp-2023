import subprocess
import matplotlib.pyplot as plt
import numpy as np

# Usar um estilo predefinido
plt.style.use('ggplot')

# Lista dos valores de alpha
alphas = [0.5, 0.75, 1.0, 1.25, 1.4, 1.5]

# Compilar o código Fortran
subprocess.run(["gfortran", "-o", "tarefa-4b.exe", "tarefa-4b.f"])

for alpha in alphas:
    # Executar o programa Fortran com o valor atual de alpha
    subprocess.run(["./tarefa-4b.exe"], input=f"{alpha}".encode())

    # Ler os dados do arquivo
    theta, w = np.loadtxt('tarefa-4b-saida.dat', unpack=True)

    # Criar o gráfico
    plt.figure(figsize=(6, 4))
    plt.plot(theta, w, label=f'w(θ) para alpha={alpha}', color='blue')
    plt.xlabel('θ')
    plt.ylabel('w')
    plt.title(f'Gráfico de w(θ) para alpha={alpha}')
    plt.legend()
    plt.grid(True)

    plt.tight_layout()
    plt.savefig(f'grafico_w_theta_alpha_{alpha}.png')
    plt.close()
