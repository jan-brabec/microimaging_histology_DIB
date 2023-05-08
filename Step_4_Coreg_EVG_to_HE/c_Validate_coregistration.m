% Validate quality of coregistration if you did not do it in the previous
% step
%
% Select sample number and press run
%
% Click on one of the images in the upper row
% Zoom in of the histology will be shown.
% 
% Sample 1 and 11 do not have EVG, only HE

clear all; clf; clc;

sample = 3;

data_path = fullfile('..','..','data');
pth = fullfile(data_path,num2str(sample),'coreg_fine','ver1');
load(fullfile(pth,'EVG.mat'),'EVG');
load(fullfile(pth,'MR.mat'),'MR');
load(fullfile(pth,'HE.mat'),'HE');

check_EVG2HE(HE,EVG)