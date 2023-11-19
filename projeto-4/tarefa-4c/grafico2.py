import subprocess
import matplotlib.pyplot as plt
import numpy as np

# Configurar para tema escuro
plt.style.use('dark_background')

# Valor de alpha, t_trans, teta0 e w0
alpha = 1.2
t_trans = 0.0
teta0 = 0.0
w0 = 0.0

# Compilar o código Fortran
#subprocess.run(["gfortran", "-o", "tarefa-4c.exe", "tarefa-4c.f"])

# Executar o programa Fortran com os valores especificados
input_values = f"{alpha:.8f}d0\n{t_trans:.8f}d0\n{teta0:.8f}d0\n{w0:.8f}d0\n"
#subprocess.run(["./tarefa-4c.exe"], input=input_values.encode())

# Ler os dados do arquivo
theta, w = np.loadtxt('tarefa-4b-saida_grandona.dat', unpack=True)

# Criar o gráfico da seção de Poincaré
plt.figure(figsize=(8, 6))
plt.plot(theta, w, 'o', color='cyan', markersize=0.5)
plt.xlabel('θ')
plt.ylabel('w')
plt.title(f'Seção de Poincaré para alpha={alpha}')
plt.grid(True)
plt.tight_layout()
plt.savefig('secao_poincare_alpha_1_2.png')
plt.show()
