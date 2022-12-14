function [coreg_VEGF,HE] = coregister_VEGF2HE(sample,HE,HE_mask,VEGF,lm)
% function [coreg_VEGF,HE] = coregister_VEGF2HE(sample)
%
% Performs a rigid-body coregistration of VEGF to HE
% based on defined landmarks. Input is sample number.
% HE needs to be previously coregistered non-rigidly and VEGF
% rigidly.

for c = 1:lm.n_lm
    P_HE(c,:) = lm.lm.A{c}; %landmark points of HE
    P_VEGF(c,:) = lm.lm.B{c}; %landmark points of VEGF
    d(c,:) = lm.lm.A{c}-lm.lm.B{c}; %Their distances
end

t = estimateGeometricTransform(P_HE, P_VEGF, 'affine');
t = maketform('affine', t.T);

coreg_VEGF = imtransform(VEGF, t, 'bilinear'); %Rotate

%By what it should move, take median - not so depedendent on extremes
mv = round(median(d,1));

coreg_VEGF = imtranslate(coreg_VEGF,[mv(2) mv(1)]); %move image
coreg_VEGF = imcrop(coreg_VEGF,[0 0 size(HE,2) size(HE,1)]); %crop the right and bottom parts

if (1) %Mask on HE mask as well?
    r = coreg_VEGF(:,:,1); g = coreg_VEGF(:,:,2); b = coreg_VEGF(:,:,3);
    r(~HE_mask) = 255;     g(~HE_mask) = 255;     b(~HE_mask) = 255;
    coreg_VEGF(:,:,1) = r; coreg_VEGF(:,:,2) = g; coreg_VEGF(:,:,3) = b;
end

clear VEGF;
VEGF = coreg_VEGF;
save(fullfile(pth_HE,'VEGF.mat'), 'VEGF','HE_mask','-v7.3');

if (1) %plot test figure
    clf;
    subplot(2,1,1)
    imagesc(HE)
    axis image off
    
    subplot(2,1,2)
    imagesc(VEGF)
    axis image off
    
    saveas(gcf,['Coreg_VEGF_to_HE_' num2str(sample),'.png'])
end

end



