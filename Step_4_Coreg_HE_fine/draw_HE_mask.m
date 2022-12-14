clear; clc; clf;

sample = 16;

load(fullfile('..','local_data',strcat(num2str(sample)),'coreg_fine','ver1','HE.mat'));
load(fullfile('..','local_data',strcat(num2str(sample)),'coreg_fine','ver1','MR.mat'));

ax = imagesc(HE);
axis image off
roi = images.roi.AssistedFreehand(ax);
draw(roi);

if (0) %Copy-paste this afterwards
    
    HE_mask = createMask(roi);
    
    %Filter out stuff around already at this step, not useful anyway
    r = HE(:,:,1);     g = HE(:,:,2);     b = HE(:,:,3);
    r(~HE_mask) = 255; g(~HE_mask) = 255; b(~HE_mask) = 255;
    mHE(:,:,1) = r;    mHE(:,:,2) = g;    mHE(:,:,3) = b;
    HE = mHE;
    
    dHE_mask = downsample_histo_ROI_to_MR_res(HE_mask,MR.ROI);
    
    save(fullfile('..','data',strcat(num2str(sample)),'coreg_fine','ver1','HE.mat'),'HE_mask','dHE_mask','roi','HE','-v7.3');
end



if (0) %Second ROI to factor out!
    
    HE_mask2 = createMask(roi);
    
    HE_mask_tmp = HE_mask > 0 & HE_mask2 < 1 & HE_mask3 < 1 &...
                                HE_mask5 < 1 & HE_mask6 < 1 &...
                                HE_mask7 < 1 & HE_mask8 < 1 &...
                                HE_mask9 < 1 & HE_mask10 < 1 &...
                                HE_mask11 < 1 & HE_mask12 < 1 &...
                                HE_mask13 < 1;
    HE_mask = HE_mask_tmp;
    
    %Filter out stuff around, not useful anyway
    r = HE(:,:,1);     g = HE(:,:,2);     b = HE(:,:,3);
    r(~HE_mask) = 255; g(~HE_mask) = 255; b(~HE_mask) = 255;
    mHE(:,:,1) = r;    mHE(:,:,2) = g;    mHE(:,:,3) = b;
    HE = mHE;
    
    dHE_mask = downsample_histo_ROI_to_MR_res(HE_mask,MR.ROI);
    
    save(fullfile('..','data',strcat(num2str(sample)),'coreg_fine','ver1','HE.mat'),'HE_mask','dHE_mask','roi','HE','-v7.3');
end
