%% Ejercicio 1. 
video = 'video_test_80x80.mp4';
v = VideoReader(video);

numFrames = v.NumFrames;
alto = v.Height;
ancho = v.Width;

lum_3d = zeros(alto, ancho, numFrames, 'double');

% Leer cada frame y procesar
for k = 1:numFrames

    frame_rgb = read(v, k); 
    frame_ycbcr = rgb2ycbcr(frame_rgb); 
    componente_lum = frame_ycbcr(:, :, 1); 
    lum_3d(:, :, k) = im2double(componente_lum);
end

save('lum_video.mat', 'lum_3d');