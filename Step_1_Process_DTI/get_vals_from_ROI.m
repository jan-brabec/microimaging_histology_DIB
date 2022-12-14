clear
% run('/Users/jb/OneDrive - Lund University/Documents/MATLAB/mdm/setup_paths')

iter_no = 1;
clc

for i = 1:17
    
    switch i
        case 1;  to_process = '1_1';  name = '1-1';
        case 2;  to_process = '1_2';  name = '1-2';
        case 3;  to_process = '1_3';  name = '1-3';
        case 4;  to_process = '1_4';  name = '1-4';
        case 5;  to_process = '1_5';  name = '1-5';
        case 6;  to_process = '1_6';  name = '1-6';
        case 7;  to_process = '1_7';  name = '1-7';
        case 8;  to_process = '1_8';  name = '1-8';
        case 9;  to_process = '2_8';  name = '2-8';
        case 10; to_process = '2_9';  name = '2-9';
        case 11; to_process = '2_10'; name = '2-10';
        case 12; to_process = '2_11'; name = '2-11';
        case 13; to_process = '2_12'; name = '2-12';
        case 14; to_process = '2_13'; name = '2-13';
        case 15; to_process = '2_14'; name = '2-14';
        case 16; to_process = '2_15'; name = '2-15';
        case 17; to_process = '2_16'; name = '2-16';
    end
    
    if i < 9
        op = fullfile('../data/processed/down'); %1_ = down
    else
        op = fullfile('../data/processed/up'); %2_ = up
    end
    rp = '../data/ROI';
    
    FA_im_file   = fullfile(op,'dti_lls_fa.nii.gz' );
    MD_im_file   = fullfile(op,'dti_lls_md.nii.gz' );
    roi_file     = fullfile(rp,strcat(to_process,'.nii.gz'));
    
    I_FA  = mdm_nii_read(FA_im_file);
    I_MD  = mdm_nii_read(MD_im_file);
    I_ROI = mdm_nii_read(roi_file);%mdm_nii_read, use this
    
    MD = I_MD(I_ROI>0);
    FA = I_FA(I_ROI>0);
    
    disp(iter_no)
    disp(to_process)
    disp(FA_im_file)

    dat_ex_vivo(iter_no).holder_pos = name;
    dat_ex_vivo(iter_no).MD    = MD;
    dat_ex_vivo(iter_no).FA    = FA;
    dat_ex_vivo(iter_no).I_MD  = I_MD;
    dat_ex_vivo(iter_no).I_FA  = I_FA;
    dat_ex_vivo(iter_no).I_ROI = I_ROI;
    
    iter_no = iter_no + 1; 
end

load('../../analysis/data_in_ex_vivo.mat')

histo_source_ex_vivo;

for c_exp = 1:numel(dat_ex_vivo)
    dat_ex_vivo(c_exp).info.holder_pos = histo{c_exp,1};
    dat_ex_vivo(c_exp).info.bof = histo{c_exp,3};
    dat_ex_vivo(c_exp).info.type = histo{c_exp,4};
    dat_ex_vivo(c_exp).info.consistency = histo{c_exp,5};
    dat_ex_vivo(c_exp).info.grade = histo{c_exp,6};
    dat_ex_vivo(c_exp).info.vascularized = histo{c_exp,7};
end

clearvars -except dat_in_vivo dat_ex_vivo
save('../../Analysis/data_in_ex_vivo')