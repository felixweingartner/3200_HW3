% Solving ill-conditioned matrix problem using iterative refinement
% Written by Felix Weingartner for 3200 Hw3

NValues = [ 21, 41, 81, 161 ];
aValues = [ 1.0, 1.0e-1, 1.0e-3, 1.0e-5, 1.0e-7, 1.0e-9, 1.0e-11, 1.0e-13, 1.0e-15 ];
dx = 1;
H1 = 8;
Hr = 4;

file1 = fopen('Outputs/Inst4.txt', 'wt');
format = "N:%d\ta:%d\tCond:%0.5f\tSol:%s\n";


for n = NValues
   for a = aValues
       
      % Generate matrix G
      
      c = 1/dx^2;
      G = zeros(n, n);
      % glob vars
      i = 0;
      value = 0;
      
      % Top rows
      
      for i = 1:n/2
          
          % Column
          
          for j = 1:n
              
              % -2 and 1
              
              if (mod(i, 2) == 1)
                  
                % Odd columns are -2 and even columns are 1
                
                if (mod(j, 2) == 1)
                    value = -2;
                else
                    value = 1;
                end
              else
                  
                % Odd columns are 1 and even columns are -2
                
                if (mod(j, 2) == 1)
                    value = 1;
                else
                    value = -2;
                end
              end
              
              G(i, j) = value;
              
          end
      end
      
      % Middle row
      if (mod(n/2, 2) == 1)
          
          i = i + 1;
          
          for j = 1:n  
            % 3-1 columns are 1, 3-2 columns are -(1+a), and 3-3
            % columns are a

            if (mod(j, 3) == 1)
                value = 1;
            elseif (mod(j, 3) == 2)
                value = (-1)*(1+a);
            else
                value = a;
            end
            
            G(i, j) = value;
          end
      end
      
      % Bottom rows
      for i = i+1 : n
          
        % Column
          
          for j = 1:n
              
              % a, -2a
              
              if (mod(i, 2) == 1)
                  
                % Odd columns are a and even columns are -2a
                
                if (mod(j, 2) == 1)
                    value = a;
                else
                    value = -2*a;
                end
              else
                  
                % Odd columns are -2a and even columns are a
                
                if (mod(j, 2) == 1)
                    value = -2*a;
                else
                    value = a;
                end
              end
              
              G(i, j) = value;
              
          end
      end
      
      % Generate result matrix Gh with dimensions nx1
      Gh = zeros(n,1);
      Gh(1,1) = -H1;
      Gh(n,1) = -a*Hr;
      
      % We have cG(h) = Gh with h solutions unknown
      G = c.*G;
      % Generate h
      H = linsolve(G, Gh);
      % Generate h as a string
      hStr = mat2str(H);
      % Generage Condition number
      mCond = cond(G);
      
      % Print values
      fprintf(file1, format, [n, a, mCond, hStr]);
      

   end
end


