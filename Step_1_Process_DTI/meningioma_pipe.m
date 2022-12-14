% run ../../../MATLAB/mdm/setup_paths

c_case = 'down';

switch c_case
    case 'up'
        sp =     '../data/processed/up/E23.nii';
        tp_xps = '../data/processed/up/E23_xps.mat';
        tp =     '../data/processed/up';
        opf =    '../data/processed/up/E23_mc.nii.gz';
        
    case 'down'
        
        sp =     '../data/processed/down/E36.nii';
        tp_xps = '../data/processed/down/E36_xps.mat';
        tp =     '../data/processed/down';
        opf =    '../data/processed/down/E36_mc.nii.gz';
        
end

opt = mdm_opt;
opt.do_overwrite = 1;
opt.verbose      = 1;
opt.filter_sigma = 0.2;

opt = dti_lls_opt(opt);
opt.dti_lls.fig_maps = {'s0','fa', 'md', 'ad', 'rd' 'fa2d'};

%% Make xps
bt_from_bruker_E36and23 = [...
    23.6121694294649 23.6121694294649 23.6922887981891 23.6121694294649...
    23.6121694294649 23.6922887981891 23.6922887981891 23.6922887981891...
    23.7728672298471 88.878600336796 -54.795069454463 281.766670974899...
    -54.795069454463 37.4779020125573 -173.739978379101 281.766670974899...
    -173.739978379101 893.268905735012 266.635801010388 -128.330102194428...
    845.189424500582 -128.330102194428 62.0569765079773 -406.791665927921...
    845.189424500582 -406.791665927921 2679.1048319925 382.146530864892...
    -201.585645357718 -442.30502880444 -201.585645357718 106.338195252791...
    233.319780437913 -442.30502880444 233.319780437913 511.934206977257...
    1146.43959259468 -604.756936073153 -1326.68577481217 -604.756936073153...
    319.014585758372 699.838377433732 -1326.68577481217 699.838377433732...
    1535.27109899497 234.459812627739 338.671764744359 -254.680152219908...
    338.671764744359 489.203514024683 -367.879576593475 -254.680152219908...
    -367.879576593475 276.644712679805 703.379437883218 1016.01529423308...
    -763.860840555374 1016.01529423308 1467.61054207405 -1103.37927848106...
    -763.860840555374 -1103.37927848106 829.543223759491 959.303258618495...
    154.10322922072 207.283307496015 154.10322922072 30.9418706189199...
    36.6516314410887 207.283307496015 36.6516314410887 46.6070951894829...
    2877.90977585549 343.856668329327 523.312457719999 343.856668329327...
    43.3923090897894 62.5469220262366 523.312457719999 62.5469220262366...
    95.1583004882609 82.0283348124823 234.028500808227 143.367940738963...
    234.028500808227 667.688053350705 409.031639028183 143.367940738963...
    409.031639028183 250.576792935704 246.085004437447 702.08550242468...
    429.997581005556 702.08550242468 2003.06416005211 1226.79180875657...
    429.997581005556 1226.79180875657 751.358304012145 253.183160704691...
    -423.779994905539 112.166302430985 -423.779994905539 709.326337432089...
    -187.744852147646 112.166302430985 -187.744852147646 51.0568663983027...
    759.549482114074 -1271.33998471662 292.025160101929 -1271.33998471662...
    2127.97901229627 -488.794043473648 292.025160101929 -488.794043473648...
    112.275736884264];

bt_from_bruker = reshape(bt_from_bruker_E36and23, [3 3 13]);
bt = zeros(13,6);
for c = 1:13
    bt(c,:) = tm_3x3_to_1x6(bt_from_bruker(:,:,c)) * 1e6;
end
xps = mdm_xps_from_bt(bt);
mdm_xps_save(xps, tp_xps);

%% Motion correction
s = mdm_s_from_nii(sp, 1); % connect to data
p_fn = elastix_p_write(elastix_p_affine(200), fullfile(tp, 'p.txt')); % motion correction of reference
s_lowb = mdm_s_subsample(s, s.xps.b < 1.1e9, tp, opt);
s_mec  = mdm_mec_b0(s_lowb, p_fn, tp, opt);
s_mc   = mdm_mec_eb(s, s_mec, p_fn, tp, opt); % extrapolation-based motion correction

%% Do DTI
s = mdm_s_from_nii(opf); %do DTI on motion corrected images

paths.dps_fn = fullfile(tp,'dps');
paths.mfs_fn = tp;
paths.nii_path = tp;

dti_lls_pipe(s, paths, opt);




