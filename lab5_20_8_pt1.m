% Hz = 0.5 + 0.5z^-1

num1 = [1 1];
den1 = [2 0];

[h1,w1] = freqz(num1, den1);
phi1 = 180*unwrap(angle(h1))/pi;

subplot(2,2,1);
plot(w1,abs(h1));

subplot(2,2,2);
plot(w1,phi1);

% Yz = Xz/(1+0.5z^-1)

num2 = [1 0];
den2 = [1 0.5];

[h2,w2] = freqz(num2, den2);
phi2 = 180*unwrap(angle(h2))/pi;

subplot(2,2,3);
plot(w2,abs(h2));

subplot(2,2,4);
plot(w2,phi2);

