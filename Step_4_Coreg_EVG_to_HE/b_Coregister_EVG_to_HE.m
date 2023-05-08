% register EVG to HE
% always register EVG to HE so that it is same everywhere

clear all; %there are global variable, clear all
clf; clc;

for sample = 1:16

    if sample == 1
        continue
    end

    if sample == 11
        continue
    end

    disp(sample)

    data_path = fullfile('..','..','data');
    pth_EVG  = fullfile(data_path,num2str(sample),'coreg_rigid','ver1');
    pth_HE    = fullfile(data_path,num2str(sample),'coreg_fine','ver1');
    pth_lm_fn = fullfile(pth_HE,'EVG2HE_lm_fine.mat');

    load(fullfile(pth_HE,'HE.mat'),'HE');
    load(fullfile(pth_HE,'HE_mask.mat'),'HE_mask')
    load(fullfile(pth_EVG,'EVG.mat'),'EVG');
    load(fullfile(pth_lm_fn),'lm_save');

    [coreg_EVG,HE] = coregister_rigid_EVG2HE(sample,HE,HE_mask,EVG,lm_save,pth_HE);

end