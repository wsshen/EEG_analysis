function LFPAnalysis_crossfolders_legacy()

    day_0_dir = [directory filesep subDir{1} filesep dataFolder];
    pre_drug_dir = [directory filesep subDir{2} filesep dataFolder];
    day_0_DirContents = dir([day_0_dir filesep '*.mat']);
    pre_drug_DirContents = dir([pre_drug_dir filesep '*.mat']);


    [day_0_LFPBands_A_site1,day_0_LFPBands_B_site1]=readLFPAnalysis(group_A_alt,group_B_alt,day_0_DirContents);
    [day_0_LFPBands_A_site2,day_0_LFPBands_B_site2]=readLFPAnalysis(group_A,group_B,day_0_DirContents);

    [pre_drug_LFPBands_A_site1,pre_drug_LFPBands_B_site1]=readLFPAnalysis(group_A_alt,group_B_alt,pre_drug_DirContents);
    [pre_drug_LFPBands_A_site2,pre_drug_LFPBands_B_site2]=readLFPAnalysis(group_A,group_B,pre_drug_DirContents);


    day_0_LFPMean_A_site1 = mean(day_0_LFPBands_A_site1);
    day_0_LFPMean_A_site2 = mean(day_0_LFPBands_A_site2);

    day_0_LFPMean_B_site1 = mean(day_0_LFPBands_B_site1);
    day_0_LFPMean_B_site2 = mean(day_0_LFPBands_B_site2);

    pre_drug_LFPMean_A_site1 = mean(pre_drug_LFPBands_A_site1);
    pre_drug_LFPMean_A_site2 = mean(pre_drug_LFPBands_A_site2) ;

    pre_drug_LFPMean_B_site1 = mean(pre_drug_LFPBands_B_site1) ;
    pre_drug_LFPMean_B_site2 = mean(pre_drug_LFPBands_B_site2) ;

    day_0_LFPStd_A_site1 =  stderr(day_0_LFPBands_A_site1) ;
    day_0_LFPStd_A_site2 =  stderr(day_0_LFPBands_A_site2) ;

    day_0_LFPStd_B_site1 =  stderr(day_0_LFPBands_B_site1) ;
    day_0_LFPStd_B_site2 =  stderr(day_0_LFPBands_B_site2) ;

    pre_drug_LFPStd_A_site1 =  stderr(pre_drug_LFPBands_A_site1) ;
    pre_drug_LFPStd_A_site2 =  stderr(pre_drug_LFPBands_A_site2) ;

    pre_drug_LFPStd_B_site1 =  stderr(pre_drug_LFPBands_B_site1) ;
    pre_drug_LFPStd_B_site2 =  stderr(pre_drug_LFPBands_B_site2) ;

    groupA.site1.Day0.LFPMean = day_0_LFPMean_A_site1;
    groupA.site1.Day0.LFPStd = day_0_LFPStd_A_site1;
    groupA.site1.Day0.Raw = day_0_LFPBands_A_site1;
    groupA.site2.Day0.LFPMean = day_0_LFPMean_A_site2;
    groupA.site2.Day0.LFPStd = day_0_LFPStd_A_site2;
    groupA.site2.Day0.Raw = day_0_LFPBands_A_site2;

    groupA.site1.PreDrug.LFPMean = pre_drug_LFPMean_A_site1;
    groupA.site1.PreDrug.LFPStd = pre_drug_LFPStd_A_site1;
    groupA.site1.PreDrug.Raw = pre_drug_LFPBands_A_site1;

    groupA.site2.PreDrug.LFPMean = pre_drug_LFPMean_A_site2;
    groupA.site2.PreDrug.LFPStd = pre_drug_LFPStd_A_site2;
    groupA.site2.PreDrug.Raw = pre_drug_LFPBands_A_site2;

    groupB.site1.Day0.LFPMean = day_0_LFPMean_B_site1;
    groupB.site1.Day0.LFPStd = day_0_LFPStd_B_site1;
    groupB.site1.Day0.Raw = day_0_LFPBands_B_site1;

    groupB.site2.Day0.LFPMean = day_0_LFPMean_B_site2;
    groupB.site2.Day0.LFPStd = day_0_LFPStd_B_site2;
    groupB.site2.Day0.Raw = day_0_LFPBands_B_site2;

    groupB.site1.PreDrug.LFPMean = pre_drug_LFPMean_B_site1;
    groupB.site1.PreDrug.LFPStd = pre_drug_LFPStd_B_site1;
    groupB.site1.PreDrug.Raw = pre_drug_LFPBands_B_site1;

    groupB.site2.PreDrug.LFPMean = pre_drug_LFPMean_B_site2;
    groupB.site2.PreDrug.LFPStd = pre_drug_LFPStd_B_site2;
    groupB.site2.PreDrug.Raw = pre_drug_LFPBands_B_site2;

    writematrix(day_0_LFPBands_A_site1,'day_0_LFPBands_A_site1')
    writematrix(day_0_LFPBands_B_site1,'day_0_LFPBands_B_site1')
    writematrix(day_0_LFPBands_A_site2,'day_0_LFPBands_A_site2')
    writematrix(day_0_LFPBands_B_site2,'day_0_LFPBands_B_site2')
    writematrix(pre_drug_LFPBands_A_site1,'pre_drug_LFPBands_A_site1')
    writematrix(pre_drug_LFPBands_B_site1,'pre_drug_LFPBands_B_site1')
    writematrix(pre_drug_LFPBands_A_site2,'pre_drug_LFPBands_A_site2')
    writematrix(pre_drug_LFPBands_B_site2,'pre_drug_LFPBands_B_site2')
    plotCrossFolders('groupA',groupA,'groupB',groupB)
    


end