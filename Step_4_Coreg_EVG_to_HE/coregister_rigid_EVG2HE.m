function [coreg_EVG,HE] = coregister_rigid_EVG2HE(sample,HE,HE_mask,EVG,lm,o_path)
% function [coreg_EVG,HE] = coregister_rigid_EVG2HE(sample,HE,HE_mask,EVG,lm)
%
% Performs a rigid-body coregistration of EVG to HE
% based on defined landmarks. Input is sample number.
% HE needs to be previously coregistered non-rigidly and EVG
% rigidly.

disp(['Starting coregistration of sample ',num2str(sample)])

for c = 1:lm.n_lm
    P_HE(c,:) = lm.lm.A{c}; %landmark points of HE
    P_EVG(c,:) = lm.lm.B{c}; %landmark points of EVG
    d(c,:) = lm.lm.A{c}-lm.lm.B{c}; %Their distances
end

t = estimateGeometricTransform(P_HE, P_EVG, 'affine');
t = maketform('affine', t.T);

coreg_EVG = imtransform(EVG, t, 'bilinear'); %Rotate

mv = round(median(d,1)); %By what it should move, take median - not so depedendent on extremes

%the rotation enlarges the image as well so this will ensure the cut the
%left and upper corners to translate the image by appropriate distance. The
%rotation creates black fillings that are recognized here.
tmp = rgb2gray(coreg_EVG);
for c = 1:size(tmp,1)
    if tmp(c,1) == 0
        continue
    else
        limx(1) = c;
        break
    end
end

for c = 1:size(tmp,1)    
    if tmp(c,end) == 0
        continue
    else
        limx(2) = c;
        break
    end    
end
limx = min(limx);

for c = 1:size(tmp,2)
    if tmp(1,c) == 0
        continue
    else
        limy(1) = c;
        break
    end
end

for c = 1:size(tmp,2)    
    if tmp(end,c) == 0
        continue
    else
        limy(2) = c;
        break
    end    
end
limy = min(limy);

coreg_EVG = imcrop(coreg_EVG,[limy limx size(coreg_EVG,2) size(coreg_EVG,1)]); %delete the extra image space up and left due to rotation
coreg_EVG = imtranslate(coreg_EVG,[mv(2) mv(1)]); %translate the image by the landmark distances
coreg_EVG = imcrop(coreg_EVG,[0 0 size(HE,2) size(HE,1)]); %crop image to the same size as HE image

if (1) %Mask on HE mask as well?
    r = coreg_EVG(:,:,1); g = coreg_EVG(:,:,2); b = coreg_EVG(:,:,3);
    r(~HE_mask) = 255;     g(~HE_mask) = 255;     b(~HE_mask) = 255;
    coreg_EVG(:,:,1) = r; coreg_EVG(:,:,2) = g; coreg_EVG(:,:,3) = b;
end

if (1) %Delete remaining black spots from rotation
    r = coreg_EVG(:,:,1); g = coreg_EVG(:,:,2); b = coreg_EVG(:,:,3);
    r(r==0) = 255;     g(g==0) = 255;     b(b==0) = 255;
    coreg_EVG(:,:,1) = r; coreg_EVG(:,:,2) = g; coreg_EVG(:,:,3) = b;
end


clear EVG;
EVG = coreg_EVG;

disp('Saving images')
save(fullfile(o_path,'EVG.mat'), 'EVG','HE_mask','-v7.3');

if (1) %plot test figure
    clf;
    subplot(2,1,1)
    imagesc(HE)
    axis image off
    
    subplot(2,1,2)
    imagesc(EVG)
    axis image off
    
    saveas(gcf,['Coreg_EVG_to_HE_' num2str(sample),'.png'])
end

disp('Done')

end



