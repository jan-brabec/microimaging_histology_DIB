function H = get_H_transform(H_ref,sample,contrast)
% function [H,M_MD,M_FA] = transform_H_M(H_ref,M_MD_ref,M_FA_ref,sample,contrast)
%
% Transform H_ref and M_ref into the same coordinate system

if sample == 1 && contrast == 1
    H = H_ref;
    H = cat(2,repmat(ones(size(H,1),1000)*255,[1 1 3]),H);
end

% No VEGF for sample 1

if sample == 2 && contrast == 1
    H = rot90(H_ref,2);
    H = cat(1,repmat(ones(7000,size(H,2))*255,[1 1 3]),H);
end

if sample == 2 && contrast == 2
    H = rot90(H_ref,2);
    H = cat(1,repmat(ones(7000,size(H,2))*255,[1 1 3]),H);
    H = cat(2,repmat(ones(size(H,1),1000)*255,[1 1 3]),H);
end

if sample == 3 && contrast == 1
    H = rot90(H_ref,2);
    H = imtranslate(H,[5000, 0],'FillValues',255);
end

if sample == 3 && contrast == 2
    H = rot90(H_ref,2);
end

if sample == 4 && contrast == 1
    H = rot90(H_ref,2);
end

if sample == 4 && contrast == 2
    H = rot90(H_ref,2);
    H = rot90(H_ref,2);
end

if sample == 5 && contrast == 1
    H = H_ref;
    
    H = cat(2,H,repmat(ones(size(H,1),5000)*255,[1 1 3]));
    H = cat(1,repmat(ones(1000,size(H,2))*255,[1 1 3]),H);
end

if sample == 5 && contrast == 2
    H = H_ref;
    H = cat(2,H,repmat(ones(size(H,1),5000)*255,[1 1 3]));
end

if sample == 6 && contrast == 1
    H = H_ref;
end

if sample == 6 && contrast == 2
    H = H_ref;
end

if sample == 7 && contrast == 1
    H = H_ref;
end

if sample == 7 && contrast == 2
    H = H_ref;
end

if sample == 8 && contrast == 1
    H = H_ref;
end

if sample == 8 && contrast == 2
    H = H_ref;
end

if sample == 9 && contrast == 1
    H = H_ref;
end

if sample == 9 && contrast == 2
    H = H_ref;
end

if sample == 10 && contrast == 1
    H = rot90(H_ref,2);
    H = cat(2,repmat(ones(size(H,1),5000)*255,[1 1 3]),H);
    H = cat(2,H,repmat(ones(size(H,1),8000)*255,[1 1 3])); %6000
    H = cat(1,repmat(ones(5000,size(H,2))*255,[1 1 3]),H);
    H = imtranslate(H,[0,-5000],'FillValues',255);
end

if sample == 10 && contrast == 2
    H = rot90(H_ref,2);
end

if sample == 11 && contrast == 1
    H = H_ref;
end

% No VEGF for sample 11

if sample == 12 && contrast == 1
    H = rot90(H_ref,2);
    H = permute(H, [2 1 3]);
end

if sample == 12 && contrast == 2
    H = rot90(H_ref,2);
    H = permute(H, [2 1 3]);
end

if sample == 13 && contrast == 1
    H = rot90(H_ref,2);
end

if sample == 13 && contrast == 2
    H = rot90(H_ref,3);
end

if sample == 14 && contrast == 1
    H = H_ref;
    H = permute(H, [2 1 3]);
    H = cat(2,H,repmat(ones(size(H,1),3000)*255,[1 1 3]));     
end

if sample == 14 && contrast == 2
    H = H_ref;
    H = permute(H, [2 1 3]);
end

if sample == 15 && contrast == 1
    H = rot90(H_ref,1);
end

if sample == 15 && contrast == 2
    H = rot90(H_ref,1);
end

if sample == 16 && contrast == 1
    H = rot90(H_ref,3);
end

if sample == 16 && contrast == 2
    H = rot90(H_ref,3);
end

end

