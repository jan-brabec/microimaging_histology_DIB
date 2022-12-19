function p_B = mn_coord_A_to_B(p_A, lm)
% function p_B = coord_A_to_B(p_A, lm)
% 
% compute coordinate in B's system from A's system using landmark
% points
%

T = cell2mat(lm.A);
X_A = T(1:2:end)';
Y_A = T(2:2:end)';

T = cell2mat(lm.B);
X_B = T(1:2:end)';
Y_B = T(2:2:end)';

F_X = scatteredInterpolant(X_A,Y_A,X_B);
F_Y = scatteredInterpolant(X_A,Y_A,Y_B);

p_B = [...
    F_X(p_A(1), p_A(2))
    F_Y(p_A(1), p_A(2))];

