import matplotlib.pyplot as plt
import numpy as np

# Função para ler um arquivo .dat e retornar os dados como arrays numpy
def ler_arquivo_dat(nome_arquivo):
    dados = np.loadtxt(nome_arquivo)
    x = dados[:, 0]
    y = dados[:, 1]
    return x, y

# Lista de nomes dos arquivos .dat
arquivos = [
    'tarefa-1-saida-pec.dat',
    'tarefa-1-saida-vec.dat',
    'tarefa-1-saida-pverlet.dat',
    'tarefa-1-saida-verlet.dat'
]

# Lista de rótulos para os gráficos
rotulos = [
    'Posição - Euler-Cromer',
    'Velocidade - Euler-Cromer',
    'Posição - Verlet',
    'Velocidade - Verlet'
]

# Configuração do tamanho dos gráficos
plt.figure(figsize=(12, 12))

# Loop para criar os gráficos
for i, nome_arquivo in enumerate(arquivos):
    x, y = ler_arquivo_dat(nome_arquivo)
    plt.subplot(2, 2, i + 1)
    plt.plot(x, y)
    plt.title(rotulos[i])
    plt.xlabel('Tempo')
    plt.ylabel('Valor')
    plt.grid(True)

# Ajusta o layout dos subplots
plt.tight_layout()

# Exibe os gráficos
plt.show()
