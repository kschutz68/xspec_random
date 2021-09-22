%% create DUT and set analysis parameters
H = tf([1 0 (2*pi*1e3)^2],[1 2*pi*1e3 (2*pi*1e3)^2]);
BW = 10e3; % Hz
OSR = 2.56;
Fs = OSR*BW; % 25.6 kHz
NFFT = 1024;
AvgFac = 1000;  
p = 1/AvgFac;
FF = 1 - p;
%% view analytical response
w = linspace(0,2*pi*BW,NFFT/OSR);
[mag,phz,wout] = bode(H,w);
mag = squeeze(mag);
phz = squeeze(phz);
figure;subplot(211);plot(w/(2*pi),20*log10(mag));grid
title('Magnitude Response');xlabel('Hz');ylabel('dB');
set(gca,'Ylim',[-50 10]);
subplot(212);plot(w/(2*pi),phz);grid
title('Phase Response');xlabel('Hz');ylabel('degrees');

if 0
%% using a repetitive noise excitation
% assumes data from a random source block in Simulink was
% logged to MATLAB workspace
n = squeeze(out.logsout{1}.Values.Data);
n1 = n(1:1024);
% next, instantiante a Signal From Workspace block in Simulink
% and configure it as follows:
% Signal = n1
% Sample Time = 1/Fs
% Samples per Frame = 1
% Cyclic Repetition (the key setting).
% The result will be a repetive noisy signal on an FFT by FFT
% frame basis. It will not have as flat of averaged spectrum as
% it would if the data were random from frame to frame. This
% could be a downside for some DUTs. But a benefit is that
% less averaging is required to get a good estimate.
end