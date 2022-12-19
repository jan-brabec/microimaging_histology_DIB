% Collectively applies HE mask to all HE
% Needs first coregistered HE in HE.mat and HE_mask in HE_mask.mat

clear; clc;


for sample = 1:16
    
    clearvars -except sample
    
    sample
    
    load(fullfile('..','data',strcat(num2str(sample)),'coreg_fine','ver1','HE_mask.mat'));    
    load(fullfile('..','data',strcat(num2str(sample)),'coreg_fine','ver1','HE.mat'));
    
    
    r = HE(:,:,1);     g = HE(:,:,2);     b = HE(:,:,3);
    r(~HE_mask) = 255; g(~HE_mask) = 255; b(~HE_mask) = 255;
    mHE(:,:,1) = r;    mHE(:,:,2) = g;    mHE(:,:,3) = b;
    HE = mHE;
    
    save(fullfile('..','data',strcat(num2str(sample)),'coreg_fine','ver1','HE.mat'),'HE','-v7.3');

    
    
end