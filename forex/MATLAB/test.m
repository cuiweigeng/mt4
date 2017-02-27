t = linspace(1,10,1024);
x = -(t-5).^2  + 2;
y = awgn(x,0.5); 
Y = fft(y,1024);

r = 20; % range of frequencies we want to preserve

rectangle = zeros(size(Y));
rectangle(1:r+1) = 1;               % r+1
% y_half = ifft(Y.*rectangle,1024);   % +ve low-pass filtered signal
rectangle(end-r+1:end) = 1;         % r
y_rect = ifft(Y.*rectangle,1024);   % full low-pass filtered signal

hold on;
plot(t,y,'g--'); plot(t,x,'k','LineWidth',2); 
plot(t,y_rect,'r','LineWidth',2);
legend('noisy signal','true signal','+ve low-pass','full low-pass','Location','southwest')