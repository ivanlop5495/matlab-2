function [YCbCr] = RGBTOYCbCr(RGB)

    RGB_d = double(RGB);

    R = RGB_d(:, :, 1);
    G = RGB_d(:, :, 2);
    B = RGB_d(:, :, 3);

    Y  = 0.2126 * R + 0.7152 * G + 0.0722 * B + 16;
    Cb = 0.5389 * (B - Y) + 128;
    Cr = 0.6350 * (R - Y) + 128;
    
    YCbCr_double = cat(3, Y, Cb, Cr);

    YCbCr = uint8(YCbCr_double);
end