function [f,P1]=readFFT(T,LFP)

    SamplePeriod = T(2)-T(1); % sampling period
    Fs = 1/SamplePeriod; % sampling frequency
    L = length(T);
    Fc = 200; % low pass at 200hz
    [b,a]=butter(3,Fc/(Fs/2));
    LFP_lowpass = filtfilt(b,a,LFP);
    fft_data = fft(LFP_lowpass);

    P2 = abs(fft_data/L);
    P1 = P2(1:L/2+1);
    P1(2:end-1) = 2*P1(2:end-1);
    f = Fs*(0:(L/2))/L;

end 