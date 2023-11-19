import subprocess
import matplotlib.pyplot as plt
import numpy as np

# Usar um estilo predefinido
plt.style.use('ggplot')

# Lista dos valores de alpha
alphas = [0.5, 0.75, 1.0, 1.25, 1.4, 1.5]

# Compilar o código Fortran
subprocess.run(["gfortran", "-o", "tarefa-4a.exe", "tarefa-4a.f"])

for alpha in alphas:
    # Executar o programa Fortran com o valor atual de alpha
    subprocess.run(["./tarefa-4a.exe"], input=f"{alpha}".encode())

    # Ler os dados dos arquivos
    tau, theta = np.loadtxt('tarefa-4a-theta.dat', unpack=True)
    _, w = np.loadtxt('tarefa-4a-w.dat', unpack=True)
    _, e = np.loadtxt('tarefa-4a-e.dat', unpack=True)

    # Criar os gráficos
    plt.figure(figsize=(10, 6))

    # Gráfico de theta(tau)
    plt.subplot(311)
    plt.plot(tau, theta, label=f'θ(τ) para alpha={alpha}', color='blue')
    plt.xlabel('τ')
    plt.ylabel('θ(τ)')
    plt.legend()
    plt.grid(True)

    # Gráfico de w(tau)
    plt.subplot(312)
    plt.plot(tau, w, label=f'ω(τ) para alpha={alpha}', color='green')
    plt.xlabel('τ')
    plt.ylabel('ω(τ)')
    plt.legend()
    plt.grid(True)

    # Gráfico de e(tau)
    plt.subplot(313)
    plt.plot(tau, e, label=f'E(τ) para alpha={alpha}', color='red')
    plt.xlabel('τ')
    plt.ylabel('E(τ)')
    plt.legend()
    plt.grid(True)

    plt.tight_layout()
    plt.savefig(f'graficos_alpha_{alpha}.png')
    plt.close()
