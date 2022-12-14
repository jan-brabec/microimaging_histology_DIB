% register VEGF to HE
% always register VEGF to HE so that it is same everywhere

clear all; %there are global variable, clear all
clf;
clc;

sample = 5;

path_to_data = '/Volumes/ExtHDD4/PhD/Meningioma_ex-vivo_manuscript/data';

pth_VEGF  = fullfile(path_to_data,num2str(sample),'coreg_rigid','ver1');
pth_HE    = fullfile(path_to_data,num2str(sample),'coreg_fine','ver1');
pth_lm_fn = fullfile(pth_HE,'VEGF2HE_lm_fine.mat');

load(fullfile(pth_HE,'HE.mat'),'HE','HE_mask');
load(fullfile(pth_VEGF,'VEGF.mat'),'VEGF');
load(fullfile(pth_lm_fn));


[coreg_VEGF,HE] = coregister_VEGF2HE(sample,HE,HE_mask,VEGF,lm_save);