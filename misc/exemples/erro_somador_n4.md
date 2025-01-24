


#---------------------------------------------------------------#
# Resultado em Python das mesmas equações usadas para o código  #
# CUDA, com o resultado correto                                 #
#---------------------------------------------------------------#

new_n34: 0
new_n20: 1
new_n23: 0
new_n27: 0
new_n24: 0
new_n26: 1
new_n17: 0
new_n18: 1
new_n21: 1
new_n30: 1
new_n32: 0
new_n35: 0
new_n22: 0
new_n25: 1
new_n16: 1 🫠
new_n19: 0
new_n29: 0
new_n31: 1
new_n33: 1
1 0 0 0 0

#---------------------------------------------------------------#
# Resultado do somados usando o código com entrada única, debug #
# para entrada 0011 1101, com resultado certo                   #
#---------------------------------------------------------------#

❯ nvcc somador_n4.cu -o somador_n4
❯ ./somador_n4
new_n34=0 new_n20=1 new_n23=0 new_n27=0
new_n24=0 new_n26=1 new_n17=0 new_n18=1
new_n21=1 new_n30=1 new_n32=0 new_n35=0
new_n22=0 new_n25=1 new_n16=1 🫠 new_n19=0
new_n29=0 new_n31=1 new_n33=1
Final outputs: z0=1 z1=0 z2=0 z3=0 z4=0
CUDA Error: no error

Final results from host:
z0=1 z1=0 z2=0 z3=0 z4=0


#---------------------------------------------------------------#
# Resultado do somador usando o código completo, debugando para #
# entrada 0011 1101, com o resultado esperado 16, mas dando 0   #
#---------------------------------------------------------------#

❯ nvcc somador_n4_completo.cu -o somador_n4
❯ ./somador_n4
new_n34=0 new_n20=1 new_n23=0 new_n27=0
new_n24=0 new_n26=1 new_n17=0 new_n18=1
new_n21=1 new_n30=1 new_n32=0 new_n35=0
new_n22=0 new_n25=1 new_n16=0 🫠 new_n19=0
new_n29=0 new_n31=1 new_n33=1
Final outputs: z0=0 z1=0 z2=0 z3=0 z4=0

GPU Execution time: 16.252 milliseconds

Invalid Results:
Inputs		-> Output | Expected
0 0 1 1 1 1 0 1 	-> 00000 | Expected: 16, Got: 0
0 0 1 1 1 1 1 1 	-> 00010 | Expected: 18, Got: 2
0 1 0 1 1 1 0 0 	-> 00001 | Expected: 17, Got: 1
0 1 0 1 1 1 0 1 	-> 00010 | Expected: 18, Got: 2
0 1 0 1 1 1 1 0 	-> 00011 | Expected: 19, Got: 3
0 1 1 1 1 1 0 0 	-> 00011 | Expected: 19, Got: 3
0 1 1 1 1 1 0 1 	-> 00100 | Expected: 20, Got: 4
0 1 1 1 1 1 1 1 	-> 00110 | Expected: 22, Got: 6
1 0 0 1 1 1 0 0 	-> 00101 | Expected: 21, Got: 5
1 0 0 1 1 1 0 1 	-> 00110 | Expected: 22, Got: 6
1 0 0 1 1 1 1 0 	-> 00111 | Expected: 23, Got: 7
1 0 1 1 1 1 0 0 	-> 00111 | Expected: 23, Got: 7
1 0 1 1 1 1 0 1 	-> 01000 | Expected: 24, Got: 8
1 0 1 1 1 1 1 0 	-> 01001 | Expected: 25, Got: 9
1 0 1 1 1 1 1 1 	-> 01010 | Expected: 26, Got: 10
1 1 0 1 1 1 0 0 	-> 01001 | Expected: 25, Got: 9
1 1 0 1 1 1 0 1 	-> 01010 | Expected: 26, Got: 10
1 1 0 1 1 1 1 0 	-> 01011 | Expected: 27, Got: 11
1 1 0 1 1 1 1 1 	-> 01100 | Expected: 28, Got: 12
1 1 1 1 1 1 0 0 	-> 01011 | Expected: 27, Got: 11
1 1 1 1 1 1 0 1 	-> 01100 | Expected: 28, Got: 12
1 1 1 1 1 1 1 0 	-> 01101 | Expected: 29, Got: 13
1 1 1 1 1 1 1 1 	-> 01110 | Expected: 30, Got: 14

