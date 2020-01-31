% David Talson 
% Student number: 101022690
% ELEC4700 PA 4700

% Matrix V of size (rows x columns)
rows = 5;
columns = 5;

% Inital guess
Vmatrix = zeros(rows,columns);

% Set boundary condition on left 
Vmatrix(:,1) = 1;

% Set boundary condition on right
Vmatrix(:,columns) = 1;

% Meshgrid for surf 
[r,c] = meshgrid(1:size(Vmatrix,2),1:size(Vmatrix,1));

for numIterations = 1:50
    figure(1)
    surf(r,c,Vmatrix)
    zlim([0,2])
%     figure(2)
%     [dx,dy] = gradient(V,1,1);
    %quiver(r,c,dx,dy) 
    pause(0.2)
    for matrixCol = 2: columns-1
        for matrixRow  = 1: rows
            
            % Solution for top boundary condition 
            if matrixRow == 1
                 Vmatrix(matrixRow,matrixCol) = (V(matrixRow+1,matrixCol)+V(matrixRow,matrixCol-1)+V(matrixRow,matrixCol+1))/3;
                 % Vmatrix(matrixRow,matrixCol) = 0;
                 
            % Solution for bottom boundary condition
            elseif matrixRow == rows
                 Vmatrix(matrixRow,matrixCol) = (V(matrixRow-1,matrixCol)+V(matrixRow,matrixCol-1)+V(matrixRow,matrixCol+1))/3;
                 % Vmatrix(matrixRow,matrixCol) = 0;  
                 
            % Solution for interior of matrix
            else
                Vmatrix(matrixRow,matrixCol) = (Vmatrix(matrixRow+1,matrixCol)+Vmatrix(matrixRow-1,matrixCol)+Vmatrix(matrixRow,matrixCol-1)+Vmatrix(matrixRow,matrixCol+1))/4;
            end
        end
    end
    % Another method of solution
    Vmatrix_new = imboxfilt(Vmatrix,3);
end

[dx,dy] = gradient(Vmatrix,1,1);
figure(2)
% Vector field
quiver(r,c,dx,dy) 
figure(3)
surf(r,c,Vmatrix_new);
