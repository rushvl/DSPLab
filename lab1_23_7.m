%q1
%x = 20*cos(2*pi*40*t-0.4*pi);

nexttile

fplot(@(t) 20*cos(2*pi*40*t-0.4*pi), [-1/40,1/40]);
hold on
n = [-1/40:1/80:1/40];
y = 20*cos(2*pi*40*n-0.4*pi);

stem(n,y);


%q2
%x1=5*cos(2*pi*100*t+pi/3);
%x2=4*cos*2*pi*100*t-pi/4);

nexttile

%t=linspace(-1/100,1/100);
x1=@(t) 5*cos(2*pi*100*t+pi/3);
x2=@(t) 4*cos(2*pi*100*t-pi/4);

x3=@(t) x1(t)+x2(t);

xint = [-1/100,1/100];

fplot(x1,xint,'DisplayName','x1');
hold on
fplot(x2,xint,'DisplayName','x2');
fplot(x3,xint,'LineWidth',1.2,'DisplayName','x3');

legend('Location','Best');