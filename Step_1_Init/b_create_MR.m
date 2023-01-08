% run setup paths from MDM framework first!

clear; clc;

ex_vivo_slices;

data_path = fullfile('..','..','data');
i_pth     = fullfile(data_path,'DTI_raw','processed');
ROI_path = fullfile(data_path,'DTI_raw','ROIs');

for sample = 1:16
    
    o_pth = fullfile('..','data',num2str(sample),'init_MR','ver1');
    
    %ROI
    MR.ROI = mdm_nii_read(fullfile(ROI_path,strcat('ROI',num2str(sample),'.nii.gz')));
    MR.ROI = MR.ROI(:,:,s{sample,1});
    MR.ROI = logical(MR.ROI);
    
    %S0
    MR.S0 = mdm_nii_read(fullfile(i_pth,s{sample,2},'dti_lls_s0.nii.gz'));
    MR.S0 = MR.S0 .* MR.ROI;
    MR.S0 = MR.S0(:,:,s{sample,1});
    MR.S0 = double(MR.S0);   
    
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
    
    %FAIP
    load(fullfile(i_pth,s{sample,2},'dps.mat'),'dps');
    [MR.FAIP,MR.J_11,MR.J_12,MR.J_22] = create_FA_inplane(dps,s{sample,1},MR.ROI);
    
    %AD
    MR.AD = mdm_nii_read(fullfile(i_pth,s{sample,2},'dti_lls_ad.nii.gz'));
    MR.AD = MR.AD .* MR.ROI;
    MR.AD = MR.AD(:,:,s{sample,1});
    MR.AD = double(MR.AD); 
    
    %RD
    MR.RD = mdm_nii_read(fullfile(i_pth,s{sample,2},'dti_lls_rd.nii.gz'));
    MR.RD = MR.RD .* MR.ROI;
    MR.RD = MR.RD(:,:,s{sample,1});
    MR.RD = double(MR.RD);    
    
    
    %Powder-averaged images
    MR.PA = mdm_nii_read(fullfile(i_pth,s{sample,2},strcat('DTI_',s{sample,2},'_mc_pa.nii.gz')));
    MR.PA = MR.PA .* MR.ROI;
    MR.PA = MR.PA(:,:,s{sample,1},:);
    MR.PA = squeeze(MR.PA);
    MR.PA = double(MR.PA);
    
    %All DWI images
    MR.DWI = mdm_nii_read(fullfile(i_pth,s{sample,2},strcat('DTI_',s{sample,2},'_mc.nii.gz')));
    MR.DWI = double(MR.DWI);
    MR.DWI = MR.DWI .* MR.ROI;
    MR.DWI = MR.DWI(:,:,s{sample,1},:); 
    MR.DWI = squeeze(MR.DWI);

    
    
    MR.ROI  = permute(MR.ROI,  [2 1]);
    MR.S0   = permute(MR.S0,   [2 1]);
    MR.MD   = permute(MR.MD,   [2 1]);
    MR.FA   = permute(MR.FA,   [2 1]);
    MR.FAIP = permute(MR.FAIP, [2 1]);
    MR.AD   = permute(MR.AD,   [2 1]);
    MR.RD   = permute(MR.RD,   [2 1]);
    MR.J_11 = permute(MR.J_11, [2 1]);
    MR.J_12 = permute(MR.J_12, [2 1]);
    MR.J_22 = permute(MR.J_22, [2 1]);
    MR.PA   = permute(MR.PA,   [2 1 3]);
    MR.DWI  = permute(MR.DWI,  [2 1 3]);
    
    mkdir(o_pth)
    save(fullfile(o_pth,'MR'),'MR','s','i_pth','o_pth')
    
    
end