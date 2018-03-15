% Solving ill-conditioned matrix problem ujng iterative refinement
% Written by Felix Weingartner for 3200 Hw3

clear;


nValues = [ 21, 41, 81, 161 ];
nValuesSize = numel(nValues);
nCondTime = 0.0;

aValues = [ 1.0, 1.0e-1, 1.0e-3, 1.0e-5, 1.0e-7, 1.0e-9, 1.0e-11, 1.0e-13, 1.0e-15 ];
aValuesSize = numel(aValues);


dx = 1;
H1 = 8;
Hr = 4;

addpath('Outputs');
file1 = fopen('Outputs/Inst4.txt', 'wt');
format1 = "\nN:%d\ta:%0.2e\n";
format2 = "Cond:%0.5e\tSol:%s\n";



for nIndex = 1:numel(nValues)
    n = nValues(nIndex);
    for aIndex = 1:numel(aValues)
        a = aValues(aIndex);
        % Generate matrix G
        
        c = 1/dx^2;
        G = zeros(n, n);
        % glob vars
        value = 0;
        
        % First row
        
        i = 1;
        G(1,1) = -2;
        g(1,2) = 1;
        
        % Top rows
        
        for i = 2:int32(n/2)
            % Get start index for 1 -2 1 seq
            
            j_start = i - 1;
            
            for j = j_start:j_start+3
                if (j == j_start || j == j_start+2)
                    value = 1;
                else
                    value = -2;
                end
                G(i, j) = value;
            end
        end
        
        % Middle row
        
        i = i + 1;
        % Get start index for the 1 -(1+a) a seq
        j_start = int32(n/2);
        for j = j_start:j_start+3
            if (j == j_start)
                value = 1;
            elseif (j == j_start + 1)
                value = (-1)*(1+a);
            else
                value = a;
            end
            
            G(i, j) = value;
        end
        
        % Bottom rows
        for i = i+1 : n
            
            % Get start index for the a -2a a seq
            j_start = i - 1;
            for j = j_start:j_start+3
                if (j == j_start || j == j_start+2)
                    value = a;
                else (j == j_start + 1)
                    value = (-1)*(1+a);
                end
                
                G(i, j) = value;
            end
        end
        
        % Generate result matrix Gh with dimenjons nx1
        Gh = zeros(n,1);
        Gh(1,1) = -H1;
        Gh(n,1) = -a*Hr;
        
        % We have cG(h) = Gh with h solutions unknown
        G = c*G;
        % Generate h
        
        H = linsolve(G, Gh);
        % Generate h as a string
        hStr = mat2str(H);
        % Generage Condition number
        tic;
        nCond = cond(G);
        nCondTime = toc;
        disp(nCondTime);
        fprintf(file1, format1, [n, a]);
        
        % Print values
        fprintf(file1, format2, [nCond, hStr]);
        fmt = [repmat('%0.4e ', 1, size(H, 2)-1), '%0.4e\n'];
        fprintf(file1, fmt, H.');
        
    end
end
fclose(file1);
