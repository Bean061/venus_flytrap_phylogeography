//Parameters for the coalescence simulation program : fsimcoal2.exe
4 samples to simulate :
//Population effective sizes (number of genes) 0 West1, 1 West, 2, South, 3, North
NCurrentPop0$
NCurrentPop1$
NCurrentPop2$
NCurrentPop3$
//Samples sizes and samples age 
20
20
70
60
//Growth rates	: negative growth implies population expansion
0
0
0
0
//Number of migration matrices : 0 implies no migration between demes
3
//Migration matrix 0
0 0 0 0
0 0 0 0
0 0 0 0
0 0 0 0
//Migration matrix 1
0 0 0 0
0 0 MIG21$ 0
0 MIG12$ 0 MIG32$
0 0 MIG23$ 0
//Migration matrix 2
0 0 0 0
0 0 0 0
0 0 0 0
0 0 0 0
//historical event: time, source, sink, migrants, new deme size, new growth rate, migration matrix index
7 historical event
Time0$ 0 0 0 botIntensity0$ 0 1
Time1$ 1 1 0 botIntensity1$ 0 1
Time2$ 2 2 0 botIntensity2$ 0 1
Time3$ 3 3 0 botIntensity3$ 0 1
TDIV1$ 1 2 1 RESIZE1$ 0 2
TDIV2$ 0 2 1 RESIZE2$ 0 2
TDIV3$ 3 2 1 RESIZE3$ 0 2
//Number of independent loci [chromosome] 
1 0
//Per chromosome: Number of contiguous linkage Block: a block is a set of contiguous loci
1
//per Block:data type, number of loci, per generation recombination and mutation rates and optional parameters
FREQ  1   0   6.95e-9 OUTEXP
