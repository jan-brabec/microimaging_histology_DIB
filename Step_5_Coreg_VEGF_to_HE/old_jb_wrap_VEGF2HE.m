% register VEGF to HE
% always register VEGF to HE so that it is same everywhere

clear all; %there are global variable, clear all
clf;
clc;

sample = 3;

path_to_data = '/Volumes/ExtHDD4/PhD/Meningioma_ex-vivo_manuscript/data';

i_pth_VEGF = fullfile(path_to_data,num2str(sample),'coreg_rigid','ver1');
i_pth_HE   = fullfile(path_to_data,num2str(sample),'coreg_fine','ver1');
i_pth_MR   = fullfile(path_to_data,num2str(sample),'raw_MR','ver1');
o_pth      = fullfile(path_to_data,num2str(sample),'coreg_fine','ver1');
lm_fn      = fullfile(o_pth,'VEGF2HE_lm_fine');

load(fullfile(i_pth_HE,'HE.mat'),'HE','HE_mask');
load(fullfile(i_pth_VEGF,'VEGF.mat'),'VEGF');
load(fullfile(i_pth_MR,'MR.mat'),'MR');

mn_reg_finetune(HE,VEGF,lm_fn,o_pth,MR,'VEGF2HE',sample)

if (0)
    load(fullfile(o_pth,'aniso2coreg.mat'),'cFA')
    mn_reg_finetune(cFA,MR.FA2D,lm_fn,o_pth,MR)
end

if (0)
    clearvars -except o_pth sample
    load(fullfile(o_pth,'HE.mat'))
    load(fullfile(o_pth,'MR.mat'))
    mn_check_result(HE,VEGF,HE)
end

if (0)
    coreg_VEGF = coregister_VEGF2HE(sample,HE,HE_mask,VEGF);
end