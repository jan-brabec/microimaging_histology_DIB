function [FA2D,J_11,J_12,J_22] = create_FA_inplane(dps,slice,ROI)
% function FA_inplane = create_FA_inplane(dps,slice,ROI)
%

sz = size(dps.s0);
I = reshape(dps.fulldt, [sz(1:3) 6]);
I = I.*ROI;

I = I(:,:,slice,:);
sz(3) = 1;

% xx xy xz  1 2 3
% yx yy yz  4 5 6
% zx zy zz  7 8 9
% t = t([1 5 9 2 3 6]) .* [1 1 1 sqrt(2) sqrt(2) sqrt(2)];
% xx yy zz xy xz yz

c_dim = 2;
switch (c_dim)
    case 1  %xx, yy, xy = yx
        c = [1 2 4]; % first cos then sin to get directions
    case 2  %yy, xx, yx = xy
        c = [2 1 4]; %this one also works but then use first sin and then cos T0M = 1/2 * atan2(2 * MR_J_12,MR_J_11 - MR_J_22); %/pi*180 and imagesc(abs(cat(3,  FA .* sin(T0M),FA .* cos(T0M), zeros(size(T0M)))))        
    case 3 %xx, zz, xz = zx
        c = [1 3 5]; %not right
    case 4 %zz xx, zx = xz 
        c = [3 1 5]; %not right
    case 5 %yy, zz, zy = yz
        c = [2 3 6]; %not right
    case 6 %zz, yy, zy = yz
        c = [3 2 6]; %not right
end

I = double(I(:,:,:,c));
I = reshape(I, prod(sz), 3);

J_11 = reshape(I(:,1), sz); %11 1 xx
J_22 = reshape(I(:,2), sz); %22 2 yy
J_12 = reshape(I(:,3), sz); %12 3 xy = yx

addpath('../zAnalyze_FA2D');
FA2D  = get_FA2D_IA_from_J(J_11,J_12,J_22);



end

