function mn_finalize(A, B, d, result_fn)
% function mn_finalize(A, B, lm, result_fn)
%
% produce interpolated images within the boudning box of A, save in
% result_fn
% Written by Markus Nilsson (markus.nilsson@med.lu.se) and modified by Jan
% Brabec

lm = d.lm;

%A  = Histology
%B  = MRI

if strcmp(d.purpose,'VEGF2HE')
    disp('Coregistration of VEGF to HE by non-rigid deformable not possible.')
    disp('It takes too long.')
    disp('Define landmarks and run b_Coregister_VEGF_to_HE in Step_4_Coreg_VEGF_to_HE.')
    disp('This performs rigid coregistration.')
    disp('Not continuing...')
    return;
end

[A_ul, A_br] = mn_bounding_box(lm.A, 1.05);
A_ul = round(A_ul);
A_br = round(A_br);

% compute bounding box of B
B_ul = floor(mn_coord_A_to_B(A_ul, lm));
B_br = floor(mn_coord_A_to_B(A_br, lm));

% TB - transformed B, CB - just cropped
TB = mn_do_interpolation(B, lm, @(x,i,j) mn_coord_A_to_B(x, lm));
CB = mn_do_interpolation(B, lm, @(x,i,j) [B_ul(1) + i-1, B_ul(2) + j-1]);


% Also crop A before saving - make sure it fits in integerts
s = round(...
    [A_br(1) - A_ul(1)  A_br(2) - A_ul(2)] ./ ...
    [B_br(1) - B_ul(1)  B_br(2) - B_ul(2)]);

CA = A(...
    A_ul(1) - round(s(1)/2) + (1:size(TB,1) * s(1)), ...
    A_ul(2) - round(s(2)/2) + (1:size(TB,2) * s(2)), : );

MR.ROI  = mn_do_interpolation(d.MR.ROI,  lm, @(x,i,j) mn_coord_A_to_B(x, lm));
MR.S0   = mn_do_interpolation(d.MR.S0,   lm, @(x,i,j) mn_coord_A_to_B(x, lm));
MR.MD   = mn_do_interpolation(d.MR.MD,   lm, @(x,i,j) mn_coord_A_to_B(x, lm));
MR.FA   = mn_do_interpolation(d.MR.FA,   lm, @(x,i,j) mn_coord_A_to_B(x, lm));
MR.FAIP = mn_do_interpolation(d.MR.FAIP, lm, @(x,i,j) mn_coord_A_to_B(x, lm));
MR.AD   = mn_do_interpolation(d.MR.AD,   lm, @(x,i,j) mn_coord_A_to_B(x, lm));
MR.RD   = mn_do_interpolation(d.MR.RD,   lm, @(x,i,j) mn_coord_A_to_B(x, lm));
MR.J_11 = mn_do_interpolation(d.MR.J_11, lm, @(x,i,j) mn_coord_A_to_B(x, lm));
MR.J_12 = mn_do_interpolation(d.MR.J_12, lm, @(x,i,j) mn_coord_A_to_B(x, lm));
MR.J_22 = mn_do_interpolation(d.MR.J_22, lm, @(x,i,j) mn_coord_A_to_B(x, lm));

for sl = 1:size(d.MR.PA,3)
    MR.PA(:,:,sl)   = mn_do_interpolation(d.MR.PA(:,:,sl), lm, @(x,i,j) mn_coord_A_to_B(x, lm));
end
for sl = 1:size(d.MR.DWI,3)
    MR.DWI(:,:,sl)   = mn_do_interpolation(d.MR.DWI(:,:,sl), lm, @(x,i,j) mn_coord_A_to_B(x, lm));
end

HE      = CA;

save(fullfile(result_fn,'MR'), 'MR','-v7.3');
save(fullfile(result_fn,'HE'), 'HE','-v7.3');

end