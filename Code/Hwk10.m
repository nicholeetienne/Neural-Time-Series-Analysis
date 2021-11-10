%Nichole Etienne 
%BMI 500 Homework 10 
%adapted from matlab examples from the Signal Processing Toolbox and 
%(https://www.mathworks.com/matlabcentral/answers/36428-sine-wave-plot)


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Problem A %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%part1 : 4 sine waves 

%%Time specifications:
Fs = 100;                   % samples per second
dt = 1/Fs;                  % seconds per sample
StopTime = 10;              % seconds
t = (0:dt:StopTime-dt)';    % seconds

%%Sine wave:
Fc1 = 2;                    % hertz
Fc2 = 4;
Fc3 = 8;
Fc4 = 10;

x1 = sin(2*pi*Fc1*t);
x2 = sin(2*pi*Fc2*t);
x3 = sin(2*pi*Fc3*t);
x4 = sin(2*pi*Fc4*t);
xs = x1 + x2 + x3 + x4;         %sum

% Plot
stackedplot(t, [x1, x2, x3, x4, xs]);

%part2 : Fourier analysis

xf = fft(xs);
f = (0:length(xf)-1)*Fs/length(xf);
%plot 
plot(f,abs(xf))
xlabel('Frequencies')
ylabel('Non-Zero Power')
xlim([0 30])

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Problem B %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%part 1 : add noise 
%add random  small noise 
smallnoise = xs + 0.001 * gallery('normaldata',size(t), 4);
%add large noise 
largenoise = xs + 100 * gallery('normaldata',size(t), 4);
%plot 
stackedplot(t, [xs, smallnoise, largenoise]);

%Part 2: Fourier analysis on the two noisy signals
fa1 = fft(smallnoise);
fa2 = fft(largenoise);
f = (0:length(x1)-1)*Fs/length(fa2);
plot(f,abs(fa2));
xlabel('Frequencies')
ylabel('Non Zero Power')
xlim([0 30])


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Problem C %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%part 1: create a nonstationary time series
a = 0:5/(length(x1)-1):5;
xnon = [a' .* x1; a' .* x2; a' .* x3; a' .* x4];
plot(xnon);
xlabel('Time');

%part 2: Fourier analysis on the entire signal
x = fft(xnon);
f = (0:length(x)-1)*Fs/length(x);
plot(f,abs(x))
xlabel('Frequencies')
ylabel('Non Zero Power')
xlim([0 30])

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Problem D %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Short Fourier Transform with different windows
%20,40,80,100,200,400,800,1000)
stft(xnon, seconds(1e-2), 'Window', kaiser(20));
stft(xnon, seconds(1e-2), 'Window', kaiser(40));
stft(xnon, seconds(1e-2), 'Window', kaiser(80));
stft(xnon, seconds(1e-2), 'Window', kaiser(100));
stft(xnon, seconds(1e-2), 'Window', kaiser(200));
stft(xnon, seconds(1e-2), 'Window', kaiser(400));
stft(xnon, seconds(1e-2), 'Window', kaiser(800));
stft(xnon, seconds(1e-2), 'Window', kaiser(1000));


