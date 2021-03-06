# LLVM_CAT
LLVM Code Analysis and Transformation

## Prerequisites
LLVM 8.0.0

## Build
Copy a version of CatPass from passes/ into CAT-c/catpass/CatPass.cpp, i.e.
```
cp passes/Catpass-1.cpp CAT-c/catpass/Catpass.cpp
```
Compile and install your code at ```CAT-c/catpass/Catpass.cpp``` with ```cd CAT-c; ./run_me.sh```
The script run_me.sh compiles and installs an LLVM-based compiler that includes your CAT in the directory ~/CAT

## Run
1) Add your compiler cat-c in your PATH, i.e.
```
export PATH=~/CAT/bin:$PATH
```

2) Invoke your compiler to compile a C program, i.e.
```
cat-c program_to_analyse.c -o mybinary
```
    
```
cat-c -O3 program_to_analyse.c -o mybinary
```

```
cat-c -O0 program_to_analyse.bc -o mybinary
```

## Tests
To compile the provided sample tests and compare Catpass output with oracle output for correctness:
```
cd tests; make
```

## Performance
To compile the provided performance test and measure compilation-time and #CAT invocations:
```
cd performance; make
```
	
## CAT API library
CAT API provides an abstraction to prevent LLVM from using any default optimizations on the source code intended to be optimized by CatPass.
Source files for CAT API (CAT.c & CAT.h) can be found at performance/misc/ and tests/misc/ 

## Passes
Here is a brief description of each version of CatPass found at passes/. Please visit the course's webpage https://users.cs.northwestern.edu/~simonec/CAT.html for more information.

### CatPass-0.cpp 
Prints function name and body for every bitcode function in a program.

### CatPass-1.cpp 
Prints CAT-API function name and number of instructions that invoke it for each bitcode function in a program.

### CatPass-2.cpp 
Computes and prints GEN and KILL sets (analyzed for only CAT variables) for every bitcode instruction of a program under the following assumptions:
#### Assumptions
1. A C variable used to store the return value of CAT_new (i.e., reference to a CAT variable) is defined statically not more than once in the C function it has been declared.
2. A C variable that includes a reference to a CAT variable cannot be copied to other C variables (no aliasing).
3. A C variable that includes a reference to a CAT variable cannot be copied into a data structure.
4. A C variable that includes a reference to a CAT variable does not escape the C function where it has been declared.

### CatPass-3.cpp 
Computes and prints IN and OUT sets (analyzed for only CAT variables) for every bitcode instruction of a program under previously stated assumptions.

### CatPass-4.cpp 
Performs intra-procedural Constant Propagation, Constant Folding, and Dead Code Elimination for CAT variables under previously stated assumptions.

### CatPass-5.cpp 
Performs intra-procedural Constant Propagation, Constant Folding, and Dead Code Elimination for CAT variables while removing all assumptions stated above.

### CatPass-6.cpp 
Reduces the conservativeness of the previous pass by using AliasAnalyis to compute reaching definitions.

### CatPass-7.cpp 
Added Function Inlining to perform inter-procedural Constant Propagation, Constant Folding, and Dead Code Elimination for CAT variables. Also added a naive constant folding pass for non-CAT variables.

### CatPass-8.cpp 
Added Function Cloning, Loop Unrolling and Loop Peeling. Made the reaching definition analysis inter-procedural to enable constant propagation to function input parameters and function return value propagation to call site. 

### CatPass-9.cpp 
Various optimizations to considerably improve compilation time of the pass. Replaces unnecessary conditional branches with unconditional branches to further enable Constant Propagation and Constant Folding passes.

### CatPass-final.cpp 
Added Loop Rotation to enable/unblock further loop optimizations such as Loop Peeling which in-turn unblocks Constant Propagation and Constant Folding passes. 
