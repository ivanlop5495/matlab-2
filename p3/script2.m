clc; clear; close all;

archivo_ref = 'video_ref_raw.avi';
bitrates = [500, 1000, 2000]; % Valores en kbps (Eje X)

archivos_h264 = {'raw_h264_500k.avi', 'raw_h264_1M.avi', 'raw_h264_2M.avi'};
archivos_h265 = {'raw_h265_500k.avi', 'raw_h265_1M.avi', 'raw_h265_2M.avi'};

psnr_h264 = zeros(1, 3);
psnr_h265 = zeros(1, 3);

for i = 1:3
    psnr_h264(i) = calcular_psnr_video(archivo_ref, archivos_h264{i});
    fprintf('  H.264 a %d kbps: %.2f dB\n', bitrates(i), psnr_h264(i));
end

for i = 1:3
    psnr_h265(i) = calcular_psnr_video(archivo_ref, archivos_h265{i});
    fprintf('  H.265 a %d kbps: %.2f dB\n', bitrates(i), psnr_h265(i));
end

figure;
plot(bitrates, psnr_h264, '-o', 'LineWidth', 2, 'Color', 'b', 'MarkerSize', 8);
hold on;
plot(bitrates, psnr_h265, '-s', 'LineWidth', 2, 'Color', 'r', 'MarkerSize', 8);

title('Curvas Rate-Distortion: H.264 vs H.265');
xlabel('Bitrate (kbps)');
ylabel('Calidad Objetiva - PSNR (dB)');
legend('H.264 (AVC)', 'H.265 (HEVC)', 'Location', 'southeast');
grid on;

% FUNCIÓN AUXILIAR PARA CALCULAR EL PSNR TOTAL DE UN VIDEO
function psnr_total = calcular_psnr_video(ref_file, test_file)
vr_ref = VideoReader(ref_file);
vr_test = VideoReader(test_file);

numFrames = min(vr_ref.NumFrames, vr_test.NumFrames);
mse_total = 0;
max_I = 255;

for k = 1:numFrames
    frame_ref = double(read(vr_ref, k));
    frame_test = double(read(vr_test, k));

    num_pixels = numel(frame_ref); 
    mse_frame = sum((frame_ref(:) - frame_test(:)).^2) / num_pixels;
    mse_total = mse_total + mse_frame;
end

mse_avg = mse_total / numFrames;
if mse_avg == 0
    psnr_total = Inf;
else
    psnr_total = 10 * log10((max_I^2) / mse_avg);
end
end