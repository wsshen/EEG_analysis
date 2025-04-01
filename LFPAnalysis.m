
recording_sites = ['1','2'];
group_A = [54068,54070,43931,50507,50508,50509];
group_B = [54071,48490,48494,48495,54069,50505,50510,50511,50515];

LFPDir = [directory dataFolders{1}]; % where LFP data is stored
LFPDirContents = dir([LFPDir filesep '*.mat']);
num_frequency_bands = 6;
LFPMean_A = zeros(length(recording_sites),num_frequency_bands); % 5 frequency bands; storing mean values
LFPMean_B = zeros(length(recording_sites),num_frequency_bands); % 5 frequency bands; storing mean values
LFPStd_A = zeros(length(recording_sites),num_frequency_bands); % 5 frequency bands; storing std error values
LFPStd_B = zeros(length(recording_sites),num_frequency_bands); % 5 frequency bands; storing std error values

LFPBands_A = zeros(length(group_A)*2,num_frequency_bands);
LFPBands_B = zeros(length(group_B)*2,num_frequency_bands);

for i= 1:length(LFPDirContents)
    
    data_temp = load( LFPDirContents(i).name);
    underscore_pos = find( LFPDirContents(i).name == '_');
    mouse_ID = LFPDirContents(i).name(1:underscore_pos(1)-1);
    site_ID = LFPDirContents(i).name(underscore_pos(2)+1);
    if find(str2num(mouse_ID)==group_A)
        A_ind  = find(str2num(mouse_ID)==group_A);
        LFPBands_A((str2num(site_ID)-1)*length(group_A)+A_ind,:) = [data_temp.delta data_temp.theta ...
            data_temp.alpha data_temp.beta data_temp.slow_gamma data_temp.fast_gamma];
    end
    if find(str2num(mouse_ID)==group_B)
        B_ind  = find(str2num(mouse_ID)==group_B);

        LFPBands_B((str2num(site_ID)-1)*length(group_B)+B_ind,:) = [data_temp.delta data_temp.theta ...
            data_temp.alpha data_temp.beta data_temp.slow_gamma data_temp.fast_gamma];
    
    end
end 

LFPMean_A = [mean(LFPBands_A(1:length(group_A),:)) ; mean(LFPBands_A(length(group_A):end,:))];
LFPMean_B = [mean(LFPBands_B(1:length(group_B),:)) ; mean(LFPBands_B(length(group_B):end,:))];
LFPStd_A =  [stderr(LFPBands_A(1:length(group_A),:)) ; stderr(LFPBands_A(length(group_A):end,:))];
LFPStd_B =  [stderr(LFPBands_B(1:length(group_B),:)) ; stderr(LFPBands_B(length(group_B):end,:))];

figure
x = [1:6];
plot(x,LFPMean_A(1,:))
hold on
errorbar(x,LFPMean_A(1,:),LFPStd_A(1,:))
plot(x,LFPMean_B(1,:))
errorbar(x,LFPMean_B(1,:),LFPStd_B(1,:))

for i = 1:length(x)
   p = anova1([LFPBands_A(1:6,i)' LFPBands_B(1:9,i)'],...
       {'A','A','A','A','A','A','B','B','B','B','B','B','B','B','B'},'off')
   if p<0.05
       text(i,2500,'*')
   end
end
figure
x = [1:6];
plot(x,LFPMean_A(2,:))
hold on
errorbar(x,LFPMean_A(2,:),LFPStd_A(2,:))
plot(x,LFPMean_B(2,:))
errorbar(x,LFPMean_B(2,:),LFPStd_B(2,:))


for i = 1:length(x)
   p = anova1([LFPBands_A(7:12,i)' LFPBands_B(10:18,i)'],...
       {'A','A','A','A','A','A','B','B','B','B','B','B','B','B','B'},'off')
   if p<0.05
       text(i,2500,'*')
   end
end