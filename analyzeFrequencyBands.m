function [a,b,c,d,e1,e2] = analyzeFrequencyBands(f,p)
%     delta = []; % 0-4Hz
%     theta = []; % 4-8Hz
%     alpha = []; % 8-12Hz
%     beta = []; %12-24Hz
%     gamma = [];%24-100Hz 
    delta = find(f>4,1,'first');
    theta = find(f>8,1,'first');
    alpha = find(f>12,1,'first');
    beta = find(f>24,1,'first');
    slow_gamma = find(f>50,1,'first');
    fast_gamma = find(f>100,1,'first');

    a = mean(p(1:delta));
    b = mean(p(delta:theta));
    c = mean(p(theta:alpha));
    d = mean(p(alpha:beta));
    e1 = mean(p(beta:slow_gamma));
    e2 = mean(p(slow_gamma:fast_gamma));
end