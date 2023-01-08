% register VEGF to HE
% always register VEGF to HE so that it is same everywhere

clear all; %there are global variable, clear all
clf; clc;

for sample = 10:10
    
    if sample == 1
        continue
    end
    if sample == 3
        continue
    end
    if sample == 11
        continue
    end
    
    data_path = fullfile('..','..','data');
    pth_VEGF  = fullfile(data_path,num2str(sample),'coreg_rigid','ver1');
    pth_HE    = fullfile(data_path,num2str(sample),'coreg_fine','ver1');
    pth_lm_fn = fullfile(pth_HE,'VEGF2HE_lm_fine.mat');
    
    load(fullfile(pth_HE,'HE.mat'),'HE');
    load(fullfile(pth_HE,'HE_mask.mat'),'HE_mask')
    load(fullfile(pth_VEGF,'VEGF.mat'),'VEGF');
    load(fullfile(pth_lm_fn),'lm_save');
    
    [coreg_VEGF,HE] = coregister_rigid_VEGF2HE(sample,HE,HE_mask,VEGF,lm_save,pth_HE);
    
end