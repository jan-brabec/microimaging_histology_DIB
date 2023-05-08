% register MR to HE
%
% Select sample number and press run
%

clear all; clf; clc;

sample = 3;

data_path = fullfile('..','..','data');
i_pth_h  = fullfile(data_path,num2str(sample),'coreg_rigid','ver1');
i_pth_MR = fullfile(data_path,num2str(sample),'init_MR','ver1');
o_pth    = fullfile(data_path,num2str(sample),'coreg_fine','ver1');
lm_fn    = fullfile(o_pth,'HE_lm_fine');

load(fullfile(i_pth_h,'HE.mat'),'HE');
load(fullfile(i_pth_MR,'MR.mat'),'MR');

mn_reg_finetune(HE,MR.MD,lm_fn,o_pth,MR,'MR2HE',sample)

if (0)
    load(fullfile(o_pth,'SA_for_coreg.mat'),'SA')
    mn_reg_finetune(SA,MR.FAIP,lm_fn,o_pth,MR,'MR2HE',sample)
end
.
if (0)
    clearvars -except o_pth sample
    load(fullfile(o_pth,'HE.mat'))
    load(fullfile(o_pth,'MR.mat'))
    mn_check_result(HE,MR.MD,MR.FAIP)
end
