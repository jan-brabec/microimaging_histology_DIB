function [p_ul, p_lr] = mn_bounding_box(A, s)
% function [p_ul, p_lr] = mn_bounding_box(A, s)
%
% Computes the bounding box from the landmarks
% Written by Markus Nilsson (markus.nilsson@med.lu.se).

if (nargin < 2), s = 1; end

% compute bounding box of A
tmp = [inf inf -inf -inf];
for c = 1:numel(A)
    tmp = [...
        min(tmp(1), A{c}(1)) ...
        min(tmp(2), A{c}(2)) ...
        max(tmp(3), A{c}(1)) ...
        max(tmp(4), A{c}(2))];
end

g = @(x,s) mean(x) + [-1 1] * (x(2)-x(1)) / 2 * s;

tmp([1 3]) = g(tmp([1 3]), s);
tmp([2 4]) = g(tmp([2 4]), s);

p_ul = tmp(1:2);
p_lr = tmp(3:4);

end