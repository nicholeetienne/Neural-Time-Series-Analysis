%Nichole Etienne 
%This sections covers Problem E using the EGG data. 

%Problem A : observing the trials 
load('dataset.mat')
Fs=260; 
eeg = eeg';
t = (0:1/fs:(length(eeg)-1)/fs)';
%plot 
%plot(t,eeg)

%Fourier analysis
%f = (0:length(y)-1)*fs/length(y);
x = fft(eeg);
f = (0:length(x)-1)*fs/length(x);
%plot 
plot (f,abs(x))
xlabel('Frequency')
ylabel('Power')

%Part B : Random Noise 
%part 1 : add noise 
%add random  small noise 
smallnoise = eeg + 0.001 * gallery('normaldata',size(t), 4);
%add large noise 
largenoise = eeg + 100 * gallery('normaldata',size(t), 4);
%plot 
stackedplot(t, [eeg, smallnoise, largenoise]);

%Part 2 
%Part 2: Fourier analysis on the two noisy signals
fa1 = fft(smallnoise);
fa2 = fft(largenoise);

%plot
plot(f,abs(fa2));
xlabel('Frequencies')
ylabel('Non Zero Power')

%Part C: 
%part 1: create a nonstationary time series
a = 0:10/(length(fa1)-1):10;
xnon = [a' .* fa1; a' .* fa2];
ynon = 1:length(xnon);
plot(ynon,xnon);
xlabel('Time');

%part 2: Fourier analysis on the entire signal
x = fft(xnon);
f = (0:length(x)-1)*Fs/length(x);
plot(f,abs(x))
xlabel('Frequencies')
ylabel('Non Zero Power')
xlim([0 30])

%Part C: 
stft(eeg, fs);
stft(eeg, fs, 'Window', kaiser(20));
stft(eeg, fs, 'Window', kaiser(200));
stft(eeg, fs, 'Window', kaiser(1000));

