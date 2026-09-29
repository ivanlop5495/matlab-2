clc; clear; close all;

raw = 'video_360_raw.avi';
h262 = 'video_360_h262_raw.avi';
h264 = 'video_360_h264_raw.avi';
vr_raw = VideoReader(raw);
vr_h262 = VideoReader(h262);
vr_h264 = VideoReader(h264);
numFrames = vr_raw.NumFrames;
psnr_h262_frames = zeros(1, numFrames);
psnr_h264_frames = zeros(1, numFrames);

mse_total_h262 = 0;
mse_total_h264 = 0;
max_I = 255;
for k = 1:numFrames

    frame_raw = double(read(vr_raw, k));
    frame_h262 = double(read(vr_h262, k));
    frame_h264 = double(read(vr_h264, k));
    num_pixels = numel(frame_raw); 
    mse_h262 = sum((frame_raw(:) - frame_h262(:)).^2) / num_pixels;
    mse_h264 = sum((frame_raw(:) - frame_h264(:)).^2) / num_pixels;
    if mse_h262 == 0
        psnr_h262_frames(k) = Inf; % Si los frames son idénticos
    else
        psnr_h262_frames(k) = 10 * log10((max_I^2) / mse_h262);
    end

    if mse_h264 == 0
        psnr_h264_frames(k) = Inf;
    else
        psnr_h264_frames(k) = 10 * log10((max_I^2) / mse_h264);
    end

    % Acumulamos el MSE para luego calcular el PSNR total del video
    mse_total_h262 = mse_total_h262 + mse_h262;
    mse_total_h264 = mse_total_h264 + mse_h264;
end

mse_avg_h262 = mse_total_h262 / numFrames;
mse_avg_h264 = mse_total_h264 / numFrames;
psnr_total_h262 = 10 * log10((max_I^2) / mse_avg_h262);
psnr_total_h264 = 10 * log10((max_I^2) / mse_avg_h264);

fprintf('PSNR total H.262 : %.2f dB\n', psnr_total_h262);
fprintf('PSNR total H.264: %.2f dB\n', psnr_total_h264);

% 3.2
figure;
plot(1:numFrames, psnr_h262_frames, 'r', 'LineWidth', 1.5);
hold on;
plot(1:numFrames, psnr_h264_frames, 'b', 'LineWidth', 1.5);
title('Evolución del PSNR por Frame (H.262 vs H.264)');
xlabel('Número de Frame');
ylabel('PSNR (dB)');
legend('H.262 (MPEG-2)', 'H.264', 'Location', 'best');
grid on;