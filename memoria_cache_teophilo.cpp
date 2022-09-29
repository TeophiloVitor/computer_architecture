import numpy as np
erros = 0
acertos = 0
enderecos = 11699
memoria = []
for i in range(enderecos):
  lista = [False, None]
  memoria.append(lista)
arq = open('./enderecos.dat', 'r')
for line in arq:
  num = np.binary_repr(int(line), width=16)
  tag_bin = num[0:6]
  endereco_bin = num[6:14]
  word_bin = num[14:16]
  endereco = int(endereco_bin, 2)
  tag = int(tag_bin, 2)
  if memoria[endereco][0] == False:
    memoria[endereco][0] = True
    memoria[endereco][1] = tag
    erros += 1
  elif memoria[endereco][1] != tag:
    memoria[endereco][1] = tag
    erros += 1
  else:
    acertos += 1
taxa_erros = erros/enderecos
taxa_acertos = acertos/enderecos
print(f'Taxa de erros:  {taxa_erros*100}%')
print(f'Taxa de acertos: {taxa_acertos*100}%')