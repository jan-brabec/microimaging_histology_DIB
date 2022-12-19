function dHE_mask = downsample_histo_ROI_to_MR_res(HE_mask,MR_ROI)
% function dHE_mask = downsample_histo_ROI_to_MR_res(HE_mask,MR_ROI)
%
%   Downsamples HE mask from histology to resolution of MR.

sx = floor(size(HE_mask,1)/size(MR_ROI,1));
sy = floor(size(HE_mask,2)/size(MR_ROI,2));

dHE_mask = zeros(floor(size(HE_mask,1)/sx),floor(size(HE_mask,2)/sy));

if numel(dHE_mask) ~= numel(MR_ROI)
    error('Check sizes')
end

for i = 1:size(dHE_mask,1)
    for j = 1:size(dHE_mask,2)
        idx = (i*sx-sx+1) : sx*i;
        idy = (j*sy-sy+1) : sy*j;
        tmp(i,j) = nansum(nansum(HE_mask(idx,idy),1),2);
        tmp(i,j) = tmp(i,j)/(numel(idx(~isnan(idx)))*numel(idy(~isnan(idy))));
    end
end

dHE_mask = round(tmp);

end
