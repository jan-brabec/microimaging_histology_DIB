% Validate quality of coregistration if you did not do it in the previous
% step
%
% Select sample number and press run
%
% Click on one of the images in the upper row and zoom in the MD and FAIP
% as well as corresponding histology patch will be shown.

clear; clf; clc;

sample = 2;

data_path = fullfile('..','..','data');
o_pth    = fullfile(data_path,num2str(sample),'coreg_fine','ver1');

load(fullfile(o_pth,'HE.mat'))
load(fullfile(o_pth,'MR.mat'))

mn_check_result(HE,MR.MD,MR.FAIP)
