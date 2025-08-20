% Given data
frequencies = [-250, -100, 0, 100, 250]; % Hz
amplitudes  = [4, 7, 10, 7, 4];
phases      = [-pi/2, pi/3, 0, -pi/3, pi/2];

% Sampling settings
Fs = 8000;         % Sampling frequency (Hz)
T  = 0.05;            % Signal duration (seconds)
t  = 0:1/Fs:T;     % Time vector

% Reconstruct the signal
x = zeros(size(t));
for k = 1:length(frequencies)
    x = x + amplitudes(k) * cos(2*pi*frequencies(k)*t + phases(k));
end

% Normalize to prevent clipping in playback
x = x / max(abs(x));

% Play the audio
sound(x, Fs);

% Optional: Save to file
audiowrite('signal.wav', x, Fs);

% Plot the waveform
figure;
plot(t, x);
xlabel('Time (s)');
ylabel('Amplitude');
title('Reconstructed Signal');
grid on;
