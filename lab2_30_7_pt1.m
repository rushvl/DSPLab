x%sinusoid of length n
%randn of length n
%add both
%apply moving average filter on them by using a window of length m
%plot histogram of randn vector

nexttile;

% assign parameters
n = 5000;
m = 500;

%generate sinusoid
t = linspace(0, 2*pi, n);
sinusoid = sin(t);

%generate and plot histograms
sigma = [1,5,10];

for i=1:3
    noise = sigma(i) * randn(1, n);
    hold on
    dname = "sigma = " + sigma(i);
    histogram(noise, DisplayName=dname);
end

legend();

%generate noise
sigma = 1;
noise = sigma*randn(1,n);

%combine the signal
combinedSignal = sinusoid + noise;

% implement moving average
MovingAverageSignal = zeros(1,n);

for i = 1:n
    if i<m
        MovingAverageSignal(i) = sum(combinedSignal(1:i))/i;
    else
        MovingAverageSignal(i) = sum(combinedSignal(i-m+1:i))/m;
    end
end

%plot moving average filter
nexttile;
plot(combinedSignal, DisplayName='Noisy Signal');
hold on
plot(MovingAverageSignal, LineWidth=2.5, DisplayName='Moving Average');
plot(sinusoid, DisplayName='Original Signal');

legend();

%high pass filter

highFilteredSignal = zeros(1,n);

for i = 2:n
    highFilteredSignal(i) = combinedSignal(i)-combinedSignal(i-1);
end

%plot high pass filtered signal(noise)

nexttile;

hold on
plot(combinedSignal, DisplayName='Noisy Signal');
plot(highFilteredSignal, DisplayName='Noise Part');

legend();
%{
%moving average impulse response dtft
%after applying dtft show the magnitude and phase

% Compute the DTFT of the moving average signal
N = 1024; % Number of points in the DTFT
f = linspace(0, 1, N); % Frequency range
H = zeros(1, N); % Initialize DTFT

% Calculate the DTFT
for k = 1:N
    H(k) = sum(MovingAverageSignal .* exp(-1j * 2 * pi * f(k) * (0:n-1) / n));
end

% Plot the magnitude and phase
nexttile;
subplot(2, 1, 1);
plot(f, abs(H), 'DisplayName', 'Magnitude');
title('Magnitude of DTFT');
xlabel('Frequency (normalized)');
ylabel('Magnitude');
legend();

subplot(2, 1, 2);
plot(f, angle(H)*180/pi, 'DisplayName', 'Phase');
title('Phase of DTFT');
xlabel('Frequency (normalized)');
ylabel('Phase (radians)');
legend();
%}