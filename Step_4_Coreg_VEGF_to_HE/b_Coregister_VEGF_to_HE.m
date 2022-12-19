% register VEGF to HE
% always register VEGF to HE so that it is same everywhere

clear all; %there are global variable, clear all
clf; clc;

% sample = 6;

for sample = 16:16
    if sample == 11
        continue
    end
    
    pth_VEGF  = fullfile('..','data',num2str(sample),'coreg_rigid','ver1');
    pth_HE    = fullfile('..','data',num2str(sample),'coreg_fine','ver1');
    pth_lm_fn = fullfile(pth_HE,'VEGF2HE_lm_fine.mat');
    
    load(fullfile(pth_HE,'HE.mat'),'HE');
    load(fullfile(pth_HE,'HE_mask.mat'),'HE_mask')
    load(fullfile(pth_VEGF,'VEGF.mat'),'VEGF');
    load(fullfile(pth_lm_fn),'lm_save');
    
    [coreg_VEGF,HE] = coregister_rigid_VEGF2HE(sample,HE,HE_mask,VEGF,lm_save,pth_HE);
    
end