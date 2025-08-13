% peak value for vowels
%take 2d dft of an example and calculate

rushil = audiorecorder();

disp("Start Speaking")

recordblocking(rushil,1);

audioData = getaudiodata(rushil);
disp("Recording complete");

% Compute the FFT of the recorded audio data
N = length(audioData);
Y = fft(audioData);
Fs = rushil.SampleRate;
f = (0:N-1)*(Fs/N); % Frequency vector

threshold = max(abs(Y)) * 0.3; % Keep components > 5% of max magnitude
Y_filtered = zeros(size(Y));
Y_filtered(abs(Y) > threshold) = Y(abs(Y) > threshold);

reconstructed = real(ifft(Y_filtered));

reconstructed = reconstructed / max(abs(reconstructed));

disp('Playing original...');
sound(audioData, Fs);
pause(2);
disp('Playing reconstructed...');
sound(reconstructed, Fs);

% Time plots
t = (0:N-1)/Fs;
figure;
subplot(2,1,1);
plot(t, audioData);
title('Original Signal (Time Domain)');
xlabel('Time (s)');
ylabel('Amplitude');

subplot(2,1,2);
plot(t, reconstructed);
title('Reconstructed Signal (Time Domain)');
xlabel('Time (s)');
ylabel('Amplitude');

% Frequency plots
figure;
subplot(2,1,1);
plot(f, abs(Y));
title('Original FFT Magnitude');
xlabel('Frequency (Hz)');
ylabel('Magnitude');
xlim([0 Fs/2]); % one-sided spectrum

subplot(2,1,2);
plot(f, abs(Y_filtered));
title('Filtered FFT Magnitude');
xlabel('Frequency (Hz)');
ylabel('Magnitude');
xlim([0 Fs/2]); % one-sided spectrum
grid on;