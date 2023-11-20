import subprocess
import matplotlib.pyplot as plt
import numpy as np
import scipy.optimize as opt
from scipy.signal import find_peaks

# Configurar o estilo do gráfico
plt.style.use('ggplot')

# Parâmetros
alphas = [0.5, 0.75, 1.0, 1.25, 1.4, 1.5]
total_taus = [100, 100, 500, 50, 200, 200]
w0news = [1e-2, 1e-2, 1e-2, 1e-5, 1e-5, 1e-5]
t_trans = [20, 50, 30, 0, 0, 0]

# Compilar o código Fortran
subprocess.run(["gfortran", "-o", "tarefa-4d.exe", "tarefa-4d.f"])

def exponential_fit(x, lamb):
    return np.exp(lamb * x)

for total_tau, alpha, t_tran, w0new in zip(total_taus, alphas, t_trans, w0news):
    # Executar o programa Fortran com os valores atuais
    input_values = f"{total_tau:.8f}\n{alpha:.8f}\n{t_tran:.8f}\n{w0new:.8f}\n"
    subprocess.run(["./tarefa-4d.exe"], input=input_values.encode())

    # Ler os dados dos arquivos
    tempo, dteta = np.loadtxt('tarefa-4d-teta.dat', unpack=True)
    _, dw = np.loadtxt('tarefa-4d-w.dat', unpack=True)

    plt.figure(figsize=(10, 5))

    # Plotar dteta x tempo
    plt.subplot(211)
    plt.plot(tempo, dteta, label='Diferença em θ')

    # Plotar dw x tempo
    plt.subplot(212)
    plt.plot(tempo, dw, label='Diferença em ω')

    # Calcular e plotar a curva exponencial para os primeiros três alphas
    if alpha in alphas[:3] or alpha==1.5:
        # Encontrar picos/máximos locais
        peaks_dteta, _ = find_peaks(dteta)
        peaks_dw, _ = find_peaks(dw)

        # Ajustar a uma exponencial e plotar
        if len(peaks_dteta) > 1 and len(peaks_dw) > 1:
            popt_dteta, _ = opt.curve_fit(exponential_fit, tempo[peaks_dteta], dteta[peaks_dteta], p0=[0.1])
            popt_dw, _ = opt.curve_fit(exponential_fit, tempo[peaks_dw], dw[peaks_dw], p0=[0.1])

            lambda_teta = popt_dteta[0]
            lambda_w = popt_dw[0]

            plt.subplot(211)
            plt.plot(tempo, exponential_fit(tempo, lambda_teta), label=f'Fit Exponencial θ (λ={lambda_teta:.2f})')

            if alpha != 1.5:
                plt.subplot(212)
                plt.plot(tempo, exponential_fit(tempo, lambda_w), label=f'Fit Exponencial ω (λ={lambda_w:.2f})')

    plt.subplot(211)
    plt.xlabel('Tempo')
    plt.ylabel('dteta')
    plt.legend()

    plt.subplot(212)
    plt.xlabel('Tempo')
    plt.ylabel('dw')
    plt.legend()

    plt.tight_layout()
    plt.savefig(f'diferencas_alpha_{alpha}.png')
    plt.close()

    # Imprimir os expoentes de Lyapunov calculados
    if alpha in alphas[:3]:
        print(f"Alpha: {alpha}, Lambda_theta: {lambda_teta:.2f}, Lambda_omega: {lambda_w:.2f}")
