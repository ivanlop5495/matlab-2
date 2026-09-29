function OperacionesMatriz(A, B)
    % Función que realiza operaciones diversas entre matrices A y B
    
    % 1. Traspuestas
    disp('--- Traspuestas ---');
    disp('A'':'), disp(A');
    disp('B'':'), disp(B');
    
    % 2. Inversa de A
    disp('--- Inversa de A ---');
    if det(A) ~= 0
        disp(inv(A));
    else
        disp('La matriz A es singular (no tiene inversa).');
    end
    
    % 3. Determinante y Rango de A

    valor_det = det(A); 
    valor_rank = rank(A);
    mensaje_analisis = ['El determinante es ', ...
                    num2str(valor_det, 2), ' y su rango actual es ', ...
                    num2str(valor_rank), '.']; 
disp("---Determinante y rango---")
disp(mensaje_analisis);
    
    % 4. Producto matricial
    disp('--- Producto matricial A * B ---');
    try
        disp(A * B);
    catch
        disp('Error: Dimensiones no compatibles para producto matricial.');
    end
    
    % 5. Producto elemento a elemento
    disp('--- Producto elemento a elemento (A(:,1) .* B(:,1)) ---');
    try
        disp(A(:,1) .* B(:,1));
    catch
        disp('Error: Las columnas no tienen la misma longitud.');
    end
    
    % 6. Concatenación de filas
    disp('--- Vector fila (1ª fila A + 1ª fila B) ---');
    disp([A(1,:), B(1,:)]);
    
    % 7. Concatenación de columnas
    disp('--- Vector columna (1ª col A + 1ª col B) ---');
    disp([A(:,1); B(:,1)]);
end