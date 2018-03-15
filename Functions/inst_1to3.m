% LU Matrix decomosition caclulation
% Written by Felix Weingartner for 3200 Hw3

% ...
% 1) Compute the LU decomosition of the matrix A
% ...

% Define A
A = [ 4, 1, -2;  4, 4, -3;  8, 4, 0; ];
delim = ' ';
% Compute L and U
[ L, U ] = lu(A);

% Print L and U
addpath('Outputs');
dlmwrite('Outputs/LU_Decomp_Inst1_1.txt', L, 'delimiter', delim);
dlmwrite('Outputs/LU_Decomp_Inst1_1.txt', U', '-append', 'delimiter', delim);

% ...
% 2) Using this decomposition determine the solution using Ax
% ...

Ax = [ 0;  3;  16; ];
% LUx = Ax so Ly = Ax for some y with same dim as Ax
y = L\Ax;
% Ux = y find our final solution x
x = U\y;
dlmwrite('Outputs/LU_Decomp_Inst2.txt', x, 'delimiter', delim);

% ...
% 3) Compute the LU decompositions of B and C
% ...

B = [ 4, 1, -2;  4, 4, -3;  8, 4, 2; ];
C = [ 2, 1, -2;  4, 4, -3;  8, 4, 4; ];

[ L, U ] = lu(B);
dlmwrite('Outputs/LU_Decomp_Inst3.txt', L, 'delimiter', delim);
dlmwrite('Outputs/LU_Decomp_Inst3.txt', U, '-append', 'delimiter', delim);
[ L, U ] = lu(C);
dlmwrite('Outputs/LU_Decomp_Inst3.txt', L, '-append', 'delimiter', delim);
dlmwrite('Outputs/LU_Decomp_Inst3.txt', U, '-append', 'delimiter', delim);