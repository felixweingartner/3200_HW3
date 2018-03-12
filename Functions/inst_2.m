% Implementation of Guassian Integration
% Written by Felix Weingartner for 3200 Hw2

function inst_2(f, NLim)
addpath('Outputs');
file1 = fopen('Outputs/Gauss_Inst2.txt','wt');
format = "N:%d\tXi:%0.5f\tW:%0.5f\n";
for N = 1:NLim
    a = -1;
    b = 1;
        % Calc x and w
        if (N == 1)
            pair = [0,2;];
        elseif (N == 2)
            pair = [-1/sqrt(3), 1; 1/sqrt(3), 1];
        elseif (N == 3)
            pair = [-sqrt(3/5), 5/9; 0, 8/9; sqrt(3/5), 5/9];
        elseif (N == 4)
            pair = [-sqrt(3+2*sqrt(6/5)/7), (18-sqrt(30))/36; -sqrt(3-2*sqrt(6/5)/7), (18+sqrt(30))/36; sqrt(3-2*sqrt(6/5)/7), (18+sqrt(30))/36; sqrt(3+2*sqrt(6/5)/7), (18-sqrt(30))/36;];
        elseif (N == 5)
            pair = [-sqrt(5+2*sqrt(10/7))/3, (322-13*sqrt(70))/900; -sqrt(5-2*sqrt(10/7))/3, (322+13*sqrt(70))/900; 0, 128/255; sqrt(5-2*sqrt(10/7))/3, (322+13*sqrt(70))/900; sqrt(5+2*sqrt(10/7))/3, (322-13*sqrt(70))/900;];
        end
        rows = size(pair,1);
        sum = 0;
        % Gaussian pairs
        for p = 1:rows
            X = pair(p, 1);
            Y = f(X);
            W = pair(p, 2);
            sum = sum + (Y * W);
            fprintf(file1, format, [N,X,W]); 
        end
        integ = integral(f, -1, 1);
        fprintf(file1, '\nActual:%0.5f\tGaussian:%0.5f\n', [integ, sum]);
end
fclose(file1);
end
