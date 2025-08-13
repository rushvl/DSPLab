tiledlayout(3,4);  % 3 rows, 4 columns

image_1 = imread("https://sipi.usc.edu/database/misc/4.1.04.tiff");
image_1_gray = im2gray(image_1);

image_2 = imread("https://sipi.usc.edu/database/misc/4.2.03.tiff");
image_2 = imresize(image_2, [256 256]);
image_2_gray = im2gray(image_2);


function [mag, mag_log, phase] = MagPhase(img)
    F = fft2(img);
    F_shifted = fftshift(F);
    F_real = real(F_shifted);
    F_imag = imag(F_shifted);
    mag = sqrt(F_real.^2 + F_imag.^2);   % true magnitude
    mag_log = log(1 + mag);              % log scaling for display
    phase = atan2(F_imag, F_real);       % manual phase
end

[mag1, mag1_log, phase1] = MagPhase(image_1_gray);
[mag2, mag2_log, phase2] = MagPhase(image_2_gray);

function img_rec = reconstruct(mag, phase)
    F_real = mag .* cos(phase);
    F_imag = mag .* sin(phase);
    F = F_real + 1i * F_imag;
    img_rec = real(ifft2(ifftshift(F)));
end


img1 = reconstruct(mag2, phase1); % Phase 1 + Mag 2
img2 = reconstruct(mag1, phase2); % Phase 2 + Mag 1
img3 = reconstruct(mag1, phase1); % Phase 1 + Mag 1
img4 = reconstruct(mag2, phase2); % Phase 2 + Mag 2

nexttile; imshow(image_1_gray, []); title('Image 1 (Gray)');
nexttile; imshow(mag1_log, []);     title('Image 1 Magnitude');
nexttile; imshow(phase1, []);       title('Image 1 Phase');

nexttile; imshow(image_2_gray, []); title('Image 2 (Gray)');
nexttile; imshow(mag2_log, []);     title('Image 2 Magnitude');
nexttile; imshow(phase2, []);       title('Image 2 Phase');

nexttile; imshow(img1, []);         title('Phase 1 + Mag 2');
nexttile; imshow(img2, []);         title('Phase 2 + Mag 1');
nexttile; imshow(img3, []);         title('Phase 1 + Mag 1');
nexttile; imshow(img4, []);         title('Phase 2 + Mag 2');