% run('/Users/jb/OneDrive - Lund University/Documents/MATLAB/mdm/setup_paths')

clear; clc;

ex_vivo_slices;

i_pth = fullfile('..','Meningiomas_ex_vivo','data','processed');

for sample = 1:16
    
    o_pth = fullfile('..','data',num2str(sample),'raw_MR','ver1');
    
    %ROI
    MR.ROI = mdm_nii_read(fullfile('..','data/ROIs',strcat('ROI',num2str(sample),'.nii.gz')));
    MR.ROI = MR.ROI(:,:,s{sample,1});
    
    %S0
    MR.S0 = mdm_nii_read(fullfile(i_pth,s{sample,2},'dti_lls_s0.nii.gz'));
    MR.S0 = MR.S0 .* MR.ROI;
    MR.S0 = MR.S0(:,:,s{sample,1});
    MR.S0 = double(MR.S0);   
    
    %b-3000 image
    MR.b3000_pa = mdm_nii_read(fullfile(i_pth,s{sample,2},'b3000_pa.nii.gz'));
    MR.b3000_pa = MR.b3000_pa .* MR.ROI;
    MR.b3000_pa = MR.b3000_pa(:,:,s{sample,1});
    MR.b3000_pa = double(MR.b3000_pa);      
        
    %MD
    MR.MD = mdm_nii_read(fullfile(i_pth,s{sample,2},'dti_lls_md.nii.gz'));
    MR.MD = MR.MD .* MR.ROI;
    MR.MD = MR.MD(:,:,s{sample,1});
    MR.MD = double(MR.MD);
    
    %FA
    MR.FA = mdm_nii_read(fullfile(i_pth,s{sample,2},'dti_lls_fa.nii.gz'));
    MR.FA = MR.FA .* MR.ROI;
    MR.FA = MR.FA(:,:,s{sample,1});
    MR.FA = double(MR.FA);
    
    %FA2D
    load(fullfile(i_pth,s{sample,2},'dps.mat'),'dps');
    [MR.FA2D,MR.J_11,MR.J_12,MR.J_22] = create_FA_inplane(dps,s{sample,1},MR.ROI);
    
    MR.ROI  = permute(MR.ROI,  [2 1]);
    MR.MD   = permute(MR.MD,   [2 1]);
    MR.FA   = permute(MR.FA,   [2 1]);
    MR.FA2D = permute(MR.FA2D, [2 1]);
    MR.J_11 = permute(MR.J_11, [2 1]);
    MR.J_12 = permute(MR.J_12, [2 1]);
    MR.J_22 = permute(MR.J_22, [2 1]);
    
    mkdir(o_pth)
    save(fullfile(o_pth,'MR'),'MR','s','i_pth','o_pth')
    
    
end