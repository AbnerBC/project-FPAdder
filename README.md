# Objetivo Geral:
Esse projeto baseia-se na codificação de uma placa FPGA da Intel objetivando a implementação correta e segura de um somador de ponto flutuante simplificado. Como resultado, espera-se receber como saída o resultado da operação (soma ou subtração) no seguinte formato:
Sinal + 0 + . + Mantissa + E + Expoente
Obs: Assuma + como a operação de concatenação em Strings.
Um exemplo desse formato seria o número +0.53E2 que expressa um resultado positivo onde a mantissa e o expoente são números hexadecimais.
# Objetivos Específicos:
A implementação do somador de ponto-flutuante divide-se basicamente em três etapas distintas, são elas o recebimento dos dados, o processamento desses dados e por fim a saída desses dados nos seis displays de sete segmentos. O recebimento dos valores é realizado pelo arquivo “fp_adder_test.vhd”, onde os sinais, expoentes e mantissas dos dois números são recebidos a partir de um loop, onde os valores são digitados nos interruptores (SW), o botão KEY0 ativa o clock e por fim o botão KEY1 reseta a inserção dos dados. Após o recebimento desses dados, as operações aritméticas são realizadas no arquivo “fp_adder.vhd”, onde os sinais, expoentes e mantissas dos dois números são processados de modo a gerar uma resposta que esteja de acordo com as regras de normalização. Após esse processamento inicial, os dados são enviados para o arquivo “hex_to_sseg.vhd”, onde ocorre um processamento desses dados de modo a decidir quais LEDs vão acender em cada display de sete segmentos. Por fim, o arquivo “disp_mux.vhd” realiza o acendimento correto dos LEDs. Portanto, infere-se que:
* Input: “fp_adder_test.vhd”
* Processing: “fp_adder.vhd”
* Output: “disp_mux.vhd” e “hex_to_sseg.vhd”
# Justificativa:
A contribuição deste trabalho baseia-se na importância que esse projeto possui na compreensão da computação científica, onde operações de ponto-flutuante são cruciais para determinar a precisão dos valores envolvidos nos mais diferentes cálculos. Além disso, esse projeto serve como uma introdução para conceitos mais avançados, como multiplicadores e divisores de ponto flutuante que são componentes essenciais para unidades aritméticas mais complexas.
