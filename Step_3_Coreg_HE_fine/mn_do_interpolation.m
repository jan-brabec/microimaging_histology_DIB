function I = mn_do_interpolation(B, lm, f_A_to_B)
% function I = mn_do_interpolation(B, lm, f_A_to_B)
%
% Written by Markus Nilsson (markus.nilsson@med.lu.se).

% first produce interpolated images within the boudning box of A
[A_ul, A_br] = mn_bounding_box(lm.A, 1.05);

% compute bounding box of B
B_ul = floor(mn_coord_A_to_B(A_ul, lm));
B_br = floor(mn_coord_A_to_B(A_br, lm));

% I - interpolated, I2 - just cropped
I = zeros(B_br(1) - B_ul(1), B_br(2) - B_ul(2));

for i = 1:size(I,1)
    for j = 1:size(I,2)
        
        p_A = [...
            A_ul(1) + (i-1) / size(I,1) * (A_br(1) - A_ul(1))
            A_ul(2) + (j-1) / size(I,2) * (A_br(2) - A_ul(2))];
        
        % where in B should be look?
        p_B = f_A_to_B(p_A, i, j);
        
        % here we could implement an interpolation eventually
        % for now, just round the coordinate
        p_B = round(p_B);
        
        try
            I(i,j) = B(p_B(1), p_B(2));
        catch
            1;
        end
    end
end

