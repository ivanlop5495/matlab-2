%% Ejercicio 1: Resolución de Sistema de Ecuaciones
clear all
close all
clc
A_eq = [2 1 -1 1; -1 3 2 -1; 3 -1 1 2; 1 4 -1 1];
B_eq = [3; 1; 7; 5];

solucion = A_eq \ B_eq;

disp('Solución Ejercicio 1 (x, y, z, w):');
disp(solucion);

%% Ejercicio 2: Prueba de la Función OperacionesMatriz

A_test = [1 4 7; 2 5 8; 3 6 0];
B_test = [10; 20; 30];

OperacionesMatriz(A_test, B_test);

%% Ejercicio 3: Operaciones con Matrices Aleatorias

n = input('Indique el tamaño de la matriz: ');

A_rand = rand(n);

disp('Matriz aleatoria generada:');
disp(A_rand);

disp('Columnas impares de la matriz:');
disp(A_rand(:, 1:2:end));

disp('Diagonal principal:');
disp(diag(A_rand));

for i = 1:n
    fila = A_rand(i, :);

    v_max   = max(fila);
    v_min   = min(fila);
    v_media = mean(fila);
    v_std   = std(fila);

    mensaje = ['En la fila ', num2str(i), ': ', ...
               'el valor más alto es ', num2str(v_max, 2), ', ', ...
               'el más bajo es ', num2str(v_min, 2), ', ', ...
               'con una media de ', num2str(v_media, 2), ...
               ' y una desviación de ', num2str(v_std, 2), '.'];
    
    disp(mensaje);
end

%% Ejercicio 4: Cadenas de Caracteres y Concatenación
cadena_final = '';
for i = 1:25
    cadena_final = [cadena_final, num2str(i), ' '];
end

disp('Resultado de la concatenación (1 al 25):');
disp(cadena_final);

%% Ejercicio 5: Tiempo de Cómputo y Gráficas
tamanos = 1:100;
tiempos_rank = zeros(size(tamanos));
tiempos_det = zeros(size(tamanos));

for i = 1:length(tamanos)
    N = tamanos(i);
    M_bench = rand(N);

    tic;
    rank(M_bench);
    tiempos_rank(i) = toc;

    tic;
    det(M_bench);
    tiempos_det(i) = toc;
end

figure('Name', 'Análisis de Tiempos de Cómputo');

subplot(2,1,1);
plot(tamanos, tiempos_rank, 'r', 'LineWidth', 1.2);
title('Tiempo de cálculo: Rango');
xlabel('Tamaño de matriz (N)');
ylabel('Tiempo (s)');
grid on;

subplot(2,1,2);
plot(tamanos, tiempos_det, 'b', 'LineWidth', 1.2);
title('Tiempo de cálculo: Determinante');
xlabel('Tamaño de matriz (N)');
ylabel('Tiempo (s)');
grid on;

legend('Segundos');

%% Ejercicio 6: Matrices en 3D

matriz_3d = rand(2, 2, 50);

disp('Esta es la matriz que ocupa la posición 33 en la tercera dimensión:');
disp(matriz_3d(:, :, 33));

matriz_3d(:, :, 10) = [1, 2; 3, 4];
disp('La matriz número 10 ha sido actualizada con los valores [1,2; 3,4].');

vector_fila = reshape(matriz_3d, 1, []);
disp(['Ahora la matriz es un vector fila con un total de ', num2str(length(vector_fila)), ' elementos.']);

%% Ejercicio 7: Lectura de Imágenes

img = imread('niebla_640x456.jpg');
info = imfinfo('niebla_640x456.jpg');

bits_por_pixel = info.BitDepth;
disp(['La imagen utiliza ', num2str(bits_por_pixel), ' bits por cada píxel.']);

pixeles_bajos = sum(img(:) < 128);
disp(['Hay un total de ', num2str(pixeles_bajos), ' píxeles con una intensidad menor a 128.']);


%% Ejercicio 8: Representación gráfica en 3D

[X, Y] = meshgrid(-5:0.2:5, -5:0.2:5);

Z = Y .* sin(pi .* X ./ 5) + 5 .* cos((X.^2 + Y.^2) ./ 4) + cos(X + Y) .* cos(3.*X - Y) + sin(X + Y);

figure('Name', 'Representaciones de Superficie');

subplot(1, 3, 1);
surf(X, Y, Z);
title('Vista de Superficie (surf)');
xlabel('Eje X'); ylabel('Eje Y'); zlabel('Z');

subplot(1, 3, 2);
mesh(X, Y, Z);
title('Vista de Malla (mesh)');
xlabel('Eje X'); ylabel('Eje Y'); zlabel('Z');

subplot(1, 3, 3);
contourf(X, Y, Z);
title('Mapa de Contorno (contourf)');
xlabel('Eje X'); ylabel('Eje Y');

%% Ejercicio 9: Cálculo Simbólico
syms x

expresion = x^3 + 3*x - 5;

derivada = diff(expresion, x);
integral = int(expresion, x);

disp('Para la expresión x^3 + 3x - 5:');
disp(['- Su derivada es: ', char(derivada)]);
disp(['- Su integral es: ', char(integral)]);

soluciones_ec = solve(expresion == 0, x);
disp('Las soluciones de la ecuación son:');
disp(double(soluciones_ec)); 

syms x_s y_s z_s w_s
eq1 = 2*x_s + y_s - z_s + w_s == 3;
eq2 = -x_s + 3*y_s + 2*z_s - w_s == 1;
eq3 = 3*x_s - y_s + z_s + 2*w_s == 7;
eq4 = x_s + 4*y_s - z_s + w_s == 5;

solucion_sistema = solve([eq1, eq2, eq3, eq4], [x_s, y_s, z_s, w_s]);

disp('Solución simbólica del sistema del Ejercicio 1:');
fprintf('x = %s, y = %s, z = %s, w = %s\n', ...
    char(solucion_sistema.x_s), char(solucion_sistema.y_s), ...
    char(solucion_sistema.z_s), char(solucion_sistema.w_s));