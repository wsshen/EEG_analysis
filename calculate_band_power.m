function [f,delta,theta,alpha,beta,slow_gamma,fast_gamma,fullBand] = calculate_band_power(LFP_data_meanRemoved,eventInd,varargin)
    
    assignVar(varargin)

    delta = 0; % 0-4Hz
    theta = 0; % 4-8Hz
    alpha = 0; % 8-12Hz
    beta = 0; % 12-24Hz
    slow_gamma = 0;%24-50Hz
    fast_gamma = 0;%50-100Hz
%     totalPower = 0;
    fullBand = [];

    for k = 1:size(eventInd,1)
        [P1,f] = readPSD(LFP_data_meanRemoved(eventInd(k,1):eventInd(k,2)),hann(64),1000);

        [a,b,c,d,e1,e2] = analyzeFrequencyBands(f,P1); %10*log10(P1)
        if isnan(a+b+c+d+e1+e2)

            break
        end

        delta = delta+a;
        theta = theta+b;
        alpha = alpha+c;
        beta = beta+d;
        slow_gamma = slow_gamma + e1;
        fast_gamma = fast_gamma + e2;
        fullBand(end+1,:) = P1';
%         totalPower = totalPower + mean(10*log10(P1));
    end
%     totalPower = totalPower/size(eventInd,1);
    
    delta = delta/size(eventInd,1);
    theta = theta/size(eventInd,1);
    alpha = alpha / size(eventInd,1);
    beta = beta/size(eventInd,1);
    slow_gamma = slow_gamma/size(eventInd,1);
    fast_gamma = fast_gamma/size(eventInd,1);
    fullBand = mean(fullBand);

    if exist('totalPower')
        [P1,f] = readPSD(LFP_data_meanRemoved(:),hann(64),1000);
        [meanPower_a,meanPower_b,meanPower_c,meanPower_d,meanPower_e1,meanPower_e2] = analyzeFrequencyBands(f,P1);
%         totalPower = mean(P1);

        delta = delta/ meanPower_a;
        theta = theta/ meanPower_b;
        alpha = alpha / meanPower_c;
        beta = beta/ meanPower_d;
        slow_gamma = slow_gamma/ meanPower_e1;
        fast_gamma = fast_gamma/ meanPower_e2; 
    end
        

end