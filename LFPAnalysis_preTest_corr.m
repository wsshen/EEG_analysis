function LFPAnalysis_preTest_corr(mice)

    LFP_GlobalVariables
    my_cm = colormap(winter(16));  
    my_cm_seq = [16:-3:1];
    
    for i = 1:groupNum
       for j = 1:length(LFP_sites)
           for k = 1:length(subDir)
                group_char = char(i+64);
                site_id = num2str(str2num(LFP_sites{j})-4);
                if j == 1
                    group_id = ['group_' group_char ];
                else
                    group_id = ['group_' group_char '_alt'];
                end
                group_raw = ['group' group_char '.site' site_id '.' subDir{k} '.Raw'];

                eval([group_raw '= readLFPAnalysis_preTest(' group_id ',mice,[subDir{k} ''_site_'' site_id]);'])
                figure
                hold on
                for i_band=1:bandNum
                    eval(['scatter(' group_raw '(:,7),' group_raw '(:,i_band),[],my_cm(my_cm_seq(i_band),:,:),''MarkerFaceColor'',my_cm(my_cm_seq(i_band),:,:),''MarkerEdgeColor'',my_cm(my_cm_seq(i_band),:,:))'])
                    
                end
                legend('delta','theta','alpha','beta','slow gamma','fast gamma')
                xlabel('LFP magnitude during pre test')
                ylabel('LFP magnitude during social test')
                title(group_raw)
           end
       end
    end
    
end