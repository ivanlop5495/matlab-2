%% Ejercicio 2. 

load('lum_video.mat', 'lum_3d');
[filas, columnas, numFrames] = size(lum_3d);
error_matrix = zeros(filas, columnas, numFrames, 'double');

% Calcular la matriz de error
for k = 1:numFrames
    frame_actual = lum_3d(:, :, k);
    frame_error = zeros(filas, columnas, 'double');
    
    for i = 1:filas
        for j = 1:columnas
            if i == 1 && j == 1
                frame_error(i, j) = frame_actual(i, j);
            elseif j == 1
                frame_error(i, j) = frame_actual(i, j) - frame_actual(i - 1, columnas);
            else
                frame_error(i, j) = frame_actual(i, j) - frame_actual(i, j - 1);
            end
        end
    end
    
    error_matrix(:, :, k) = frame_error;
end

%% Ejercicio 3.

matriz_dct_cuantificada = zeros(filas, columnas, numFrames, 'double');

% Aplicar la transformada 2D-DCT y cuantificar
for k = 1:numFrames
    dct_frame = dct2(error_matrix(:, :, k));
    
    % Cuantificar redondeando a 1 decimal
    matriz_dct_cuantificada(:, :, k) = round(dct_frame, 1);
end

% Cálculo y comparación de la entropía
vector_original = lum_3d(:);
vector_procesado = matriz_dct_cuantificada(:);

% Calcular entropías
entropia_original = entropy(vector_original);
entropia_procesada = entropy(vector_procesado);

% Calcular la reducción de la entropía
reduccion_entropia = entropia_original - entropia_procesada;

fprintf('Resultados de Entropía: ');
fprintf('Entropía de la matriz original: %.4f\n', entropia_original);
fprintf('Entropía de la matriz procesada: %.4f\n', entropia_procesada);
fprintf('La entropía se ha reducido en: %.4f\n', reduccion_entropia);

%% Ejercicio 4.
% 4.1. Aplicamos RLE y almacenamos en una estructura
codificacion = struct('vector_rle', cell(1, numFrames));
total_pixeles_codificados = 0;

for k = 1:numFrames
    frame_dct = matriz_dct_cuantificada(:, :, k);
    vector_coeficientes = frame_dct(:)';
    vector_comprimido = rle(vector_coeficientes);
    codificacion(k).vector_rle = vector_comprimido;
    total_pixeles_codificados = total_pixeles_codificados + length(vector_comprimido);
end

% 4.2. Comparación de número de píxeles
total_pixeles_sin_codificar = filas * columnas * numFrames;
ratio_compresion = total_pixeles_sin_codificar / total_pixeles_codificados;

fprintf('\n Resultados de Codificación RLE: \n');
fprintf('Número de píxeles sin codificar (original): %d\n', total_pixeles_sin_codificar);
fprintf('Número de valores codificados (RLE): %d\n', total_pixeles_codificados);
fprintf('Tasa de compresión: %.2f:1\n', ratio_compresion);

%% Ejercicio 5.

% 5.1. Decodificación, IDCT y reconstrucción espacial
video_recuperado = zeros(filas, columnas, numFrames, 'double');

for k = 1:numFrames
    vector_decodificado = irle(codificacion(k).vector_rle);
    frame_dct_recuperado = reshape(vector_decodificado, [filas, columnas]);
    frame_residuo_recuperado = idct2(frame_dct_recuperado);
    frame_rec = zeros(filas, columnas, 'double');
    
    for i = 1:filas
        for j = 1:columnas
            if i == 1 && j == 1
                frame_rec(i, j) = frame_residuo_recuperado(i, j);
            elseif j == 1
                frame_rec(i, j) = frame_residuo_recuperado(i, j) + frame_rec(i - 1, columnas);
            else
                frame_rec(i, j) = frame_residuo_recuperado(i, j) + frame_rec(i, j - 1);
            end
        end
    end
    video_recuperado(:, :, k) = max(0, min(1, frame_rec));
end

% 5.2. Representación en matriz de 2x2 subfiguras
figure('Name', 'Comparativa Vídeo Original vs Recuperado', 'NumberTitle', 'off');

% Primer frame original
subplot(2, 2, 1);
imshow(lum_3d(:, :, 1));
title('Primer Frame Original');

% Primer frame recuperado 
subplot(2, 2, 2);
imshow(video_recuperado(:, :, 1));
title('Primer Frame Recuperado');

% Último frame original
subplot(2, 2, 3);
imshow(lum_3d(:, :, numFrames));
title('Último Frame Original');

% Último frame recuperado
subplot(2, 2, 4);
imshow(video_recuperado(:, :, numFrames));
title('Último Frame Recuperado');


