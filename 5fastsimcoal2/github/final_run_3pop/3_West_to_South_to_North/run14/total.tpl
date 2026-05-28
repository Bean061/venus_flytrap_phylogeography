//Parameters for the coalescence simulation program : fsimcoal2.exe
3 samples to simulate :
//Population effective sizes (number of genes) 0 west, 1, South, 2, North
NCurrentPop0$
NCurrentPop1$
NCurrentPop2$
//Samples sizes and samples age 
40
70
60
//Growth rates	: negative growth implies population expansion
0
0
0
//Number of migration matrices : 0 implies no migration between demes
2
//Migration matrix 0
0 MIG10$ 0
MIG01$ 0 MIG21$
0 MIG12$ 0
//Migration matrix 1
0 0 0
0 0 0
0 0 0
//historical event: time, source, sink, migrants, new deme size, new growth rate, migration matrix index
5 historical event
Time0$ 0 0 0 botIntensity0$ 0 1
Time1$ 1 1 0 botIntensity1$ 0 1
Time2$ 2 2 0 botIntensity2$ 0 1
TDIV1$ 2 1 1 RESIZE1$ 0 1
TDIV2$ 1 0 1 RESIZE2$ 0 1
//Number of independent loci [chromosome] 
1 0
//Per chromosome: Number of contiguous linkage Block: a block is a set of contiguous loci
1
//per Block:data type, number of loci, per generation recombination and mutation rates and optional parameters
FREQ  1   0   6.95e-9 OUTEXP
