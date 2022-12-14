% register MR to HE

clear all;clf; clc;

sample = 2;

i_pth_h  = fullfile('..','data',num2str(sample),'coreg_rigid','ver1');
i_pth_MR = fullfile('..','data',num2str(sample),'raw_MR','ver1');
o_pth    = fullfile('..','data',num2str(sample),'coreg_fine','ver1');
lm_fn    = fullfile(o_pth,'HE_lm_fine');

load(fullfile(i_pth_h,'HE.mat'),'HE');
load(fullfile(i_pth_MR,'MR.mat'),'MR');

mn_reg_finetune(HE,MR.MD,lm_fn,o_pth,MR,'MR2HE',sample)

if (0)
    load(fullfile(o_pth,'aniso2coreg.mat'),'cFA')
    mn_reg_finetune(cFA,MR.FA2D,lm_fn,o_pth,MR,sample)
end

if (0)
    clearvars -except o_pth sample
    load(fullfile(o_pth,'HE.mat'))
    load(fullfile(o_pth,'MR.mat'))
    mn_check_result(HE,MR.MD,MR.FA2D)
end
