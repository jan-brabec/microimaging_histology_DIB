% Define landmarks only, do not coregister by pressing r
% After saving landmarks run b_Coregister_VEGF_to_HE on the same sample
%
% Samples 1 and 11 do not have VEGF, all others do

clear all; clc; clf;

sample = 15;

data_path = fullfile('..','..','data');

i_pth_VEGF = fullfile(data_path,num2str(sample),'coreg_rigid','ver1');
i_pth_HE   = fullfile(data_path,num2str(sample),'coreg_fine','ver1');
i_pth_MR   = fullfile(data_path,num2str(sample),'init_MR','ver1');
o_pth      = fullfile(data_path,num2str(sample),'coreg_fine','ver1');
lm_fn      = fullfile(o_pth,'VEGF2HE_lm_fine');

load(fullfile(i_pth_HE,'HE.mat'),'HE');
load(fullfile(i_pth_VEGF,'VEGF.mat'),'VEGF');
load(fullfile(i_pth_MR,'MR.mat'),'MR');

addpath(fullfile('..','Step_3_Coreg_HE_fine'))
mn_reg_finetune(HE,VEGF,lm_fn,o_pth,MR,'VEGF2HE',sample);