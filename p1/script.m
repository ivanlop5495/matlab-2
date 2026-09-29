%% Ejercicio 1. Conversión del espacio de color RGB a YCbCr
%% 1.1
clc
close all

imagen = imread('arbol_640x426.jpg');
figure, imshow(imagen)
%% 1.2
clc
close all

[imagen_YCbCr] = RGBTOYCbCr(imagen);
Y_comp  = imagen_YCbCr(:, :, 1);
Cb_comp = imagen_YCbCr(:, :, 2);
Cr_comp = imagen_YCbCr(:, :, 3);

figure('Name', 'Componentes YCbCr', 'NumberTitle', 'off');

subplot(3, 1, 1);
imshow(Y_comp), axis auto;
title('Componente Y (Luminancia)');

subplot(3, 1, 2);
imshow(Cb_comp), axis auto;
title('Componente Cb');

subplot(3, 1, 3);
imshow(Cr_comp), axis auto;
title('Componente Cr');
%% Ejercicio 2. Cálculo de la entropía y representación con histograma.

%% 2.1
clc
close all
clear all

% 1. Cargar las imágenes en RGB
rgb_caballos = imread('caballos_640x427.jpg');
rgb_arbol = imread('arbol_640x426.jpg');
rgb_niebla = imread('niebla_640x456.jpg');

% 2. Convertir a escala de grises
gris_caballos = rgb2gray(rgb_caballos);
gris_arbol = rgb2gray(rgb_arbol);
gris_niebla = rgb2gray(rgb_niebla);

% 3. Calcular entropía usando nuestra función
H_caballos = CalculaEntropia(gris_caballos);
H_arbol = CalculaEntropia(gris_arbol);
H_niebla = CalculaEntropia(gris_niebla);

% Mostrar resultados en consola
fprintf('Entropía Caballos: %.4f bits/pixel\n', H_caballos);
fprintf('Entropía Árbol: %.4f bits/pixel\n', H_arbol);
fprintf('Entropía Niebla: %.4f bits/pixel\n', H_niebla);

% 4. Representación con histogramas en una figura
figure('Name', 'Histogramas y Entropía', 'NumberTitle', 'off');

subplot(1, 3, 1); imhist(gris_caballos); title(sprintf('Caballos (H=%.2f)', H_caballos));
subplot(1, 3, 2); imhist(gris_arbol); title(sprintf('Árbol (H=%.2f)', H_arbol));
subplot(1, 3, 3); imhist(gris_niebla); title(sprintf('Niebla (H=%.2f)', H_niebla));


%% 2.2
clc
close all

min_filas = 426; min_cols = 640;

img1_rec = gris_caballos(1:min_filas, 1:min_cols);
img2_rec = gris_arbol(1:min_filas, 1:min_cols);
img3_rec = gris_niebla(1:min_filas, 1:min_cols);

v1 = double(reshape(img1_rec, [], 1));
v2 = double(reshape(img2_rec, [], 1));
v3 = double(reshape(img3_rec, [], 1));

[~, ~, idx_conjunto] = unique([v1, v2, v3], 'rows');

frecuencias_conjuntas = groupcounts(idx_conjunto);

p_conjunta = frecuencias_conjuntas / length(v1);
p_conjunta(p_conjunta == 0) = [];
H_conjunta = -sum(p_conjunta .* log2(p_conjunta));

fprintf('\nEntropía Conjunta de las 3 imágenes: %.4f bits/pixel\n', H_conjunta);

%% EJERCICIO 3. Codificación Aritmética

%% 3.1. 

img_rgb = imread('icono_32x32.jpg');
img_gray = rgb2gray(img_rgb);

% Convertimos la matriz de la imagen a un vector columna
seq = double(img_gray(:));

%% 3.2.

[simbolos_unicos, ~, seq_indices] = unique(seq);

counts = groupcounts(seq);

codigo_aritmetico = arithenco(seq_indices, counts);

%% 3.3.

% Entropía teórica de la imagen 
H = entropy(img_gray);

% Cálculo de la longitud media del código (bits reales utilizados por píxel)
bits_totales = length(codigo_aritmetico);
pixeles_totales = numel(img_gray);
L_med = bits_totales / pixeles_totales;

% Entropia/Longitud media
eficiencia = H / L_med;

fprintf('Resultados Ejercicio 3: ');
fprintf('Entropía de la imagen: %.4f bits/píxel\n', H);
fprintf('Longitud media del código: %.4f bits/píxel\n', L_med);
fprintf('Eficiencia del codificador: %.2f%%\n\n', eficiencia * 100);


%% EJERCICIO 4. Decodificación Aritmética

%% 4.1.

seq_decodificada_indices = arithdeco(codigo_aritmetico, counts, pixeles_totales);
seq_reconstruida = simbolos_unicos(seq_decodificada_indices);

%% 4.2. 

% Volvemos a darle forma de matriz a la imagen (32x32)
img_decodificada = reshape(seq_reconstruida, size(img_gray));
img_decodificada = uint8(img_decodificada);

figure('Name', 'Codificación/Decodificación Aritmética', 'NumberTitle', 'off');

subplot(1, 2, 1);
imshow(img_gray);
title('Original en Escala de Grises');

subplot(1, 2, 2);
imshow(img_decodificada);
title('Imagen Decodificada');