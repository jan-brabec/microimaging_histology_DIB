
% Slices
s{1,1} = 150;
s{2,1} = 133;
s{3,1} = 117;
s{4,1} = 100; %OK
s{5,1} = 83;  %84 better
s{6,1} = 67;
s{7,1} = 50;
s{8,1} = 34;
s{9,1}  = 143;
s{10,1} = 125;
s{11,1} = 109;
s{12,1} = 91;
s{13,1} = 76;
s{14,1} = 60;
s{15,1} = 43;
s{16,1} = 27;

for sample = 1:16     %first ones down, second ones up
    if sample < 9
        s{sample,2} = 'down';
    else
        s{sample,2} = 'up';
    end
end