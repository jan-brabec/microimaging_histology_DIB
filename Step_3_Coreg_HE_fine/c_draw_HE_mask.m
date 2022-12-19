clear; clc; clf;

sample = 14;

load(fullfile('..','data',strcat(num2str(sample)),'coreg_fine','ver1','HE.mat'));
load(fullfile('..','data',strcat(num2str(sample)),'coreg_fine','ver1','MR.mat'));


if (0) %When ready draw a first mask around the whole tumor sample
    ax = imagesc(HE);
    axis image off
    roi = images.roi.AssistedFreehand(ax);
    draw(roi);
    
    
    %When ready, create mask as an array
    HE_mask = createMask(roi);
end

if (0) %Additional ROI to subtract from the first ROI if needed
    
    %Draw mask
    roi = images.roi.AssistedFreehand(ax);
    draw(roi);
    
    %Create mask as an array
    HE_mask2 = createMask(roi);
    
    %Potentially HE_mask3 etc
    
    %Modify according to the number of ROI drawn.
    HE_mask = HE_mask > 0 & HE_mask2 < 1 & HE_mask3 < 1 &...
        HE_mask5 < 1 & HE_mask6 < 1 &...
        HE_mask7 < 1 & HE_mask8 < 1 &...
        HE_mask9 < 1 & HE_mask10 < 1 &...
        HE_mask11 < 1 & HE_mask12 < 1 &...
        HE_mask13 < 1;
end

if (0) %Save when happy
    
    %Filter out stuff outside HE mask in the HE histology image
    r = HE(:,:,1);     g = HE(:,:,2);     b = HE(:,:,3);
    r(~HE_mask) = 255; g(~HE_mask) = 255; b(~HE_mask) = 255;
    mHE(:,:,1) = r;    mHE(:,:,2) = g;    mHE(:,:,3) = b;
    HE = mHE;
    
    %Downsample the mask to MRI resolution
    dHE_mask = downsample_histo_ROI_to_MR_res(HE_mask,MR.ROI);
    
    %Save to HE_mask and overwrite HE with masked HE.
    save(fullfile('..','data',strcat(num2str(sample)),'coreg_fine','ver1','HE_mask.mat'),'HE_mask','dHE_mask','roi');
    save(fullfile('..','data',strcat(num2str(sample)),'coreg_fine','ver1','HE.mat'),'HE','-v7.3');
end