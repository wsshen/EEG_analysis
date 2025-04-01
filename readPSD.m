function [pxx,w]=readPSD(LFP_data,hann_window,fs)
    [b,a] = butter(3,200/500,'low'); % apply butterworth filter 
    LFP_data_lowpassed = filter(b,a,LFP_data);
    [pxx,w] = pwelch(LFP_data_lowpassed,hann_window,[],[],fs);

end