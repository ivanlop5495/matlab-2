function [H] = CalculaEntropia(img)

    vector_img = double(reshape(img, [], 1));

    frecuencias = groupcounts(vector_img);

    N = length(vector_img);
    p = frecuencias / N;

    p(p == 0) = [];

    H = -sum(p .* log2(p));
end