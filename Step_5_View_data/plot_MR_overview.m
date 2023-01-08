clear all; clf; clc;

figure(113);

ha = tight_subplot(3,3,[.01,.01],[.01,.01],[.01,.01]);

sample = 5;

data_path = fullfile('..','..','data');
pth = fullfile(data_path,num2str(sample),'coreg_fine','ver1');
load(fullfile(pth,'MR.mat'),'MR');

axes(ha(1));
lim = 2900;
imagesc(process_map(MR.S0,MR.ROI,lim,0))
colormap gray
caxis([0 lim])
axis image off

axes(ha(2));
lim = 1;
imagesc(process_map(MR.MD,MR.ROI,lim,0))
colormap gray
caxis([0 lim])
axis image off

axes(ha(3));
lim = 0.8;
imagesc(process_map(MR.FA,MR.ROI,lim,0))
colormap gray
caxis([0 lim])
axis image off

axes(ha(4));
lim = 0.8;
imagesc(process_map(MR.FAIP,MR.ROI,lim,0))
colormap gray
caxis([0 lim])
axis image off

axes(ha(5));
lim = 1.5;
imagesc(process_map(MR.AD,MR.ROI,lim,0))
colormap gray
caxis([0 lim])
axis image off

axes(ha(6));
lim = 1;
imagesc(process_map(MR.RD,MR.ROI,lim,0))
colormap gray
caxis([0 lim])
axis image off

axes(ha(7));
lim = 1;
imagesc(process_map(MR.J_11,MR.ROI,lim,0))
colormap gray
caxis([0 lim])
axis image off

axes(ha(8));
lim = 0.3;
imagesc(process_map(MR.J_12,MR.ROI,lim,0))
colormap gray
caxis([0 lim])
axis image off

axes(ha(9));
lim = 1;
imagesc(process_map(MR.J_22,MR.ROI,lim,0))
colormap gray
caxis([0 lim])
axis image off


print(sprintf('MRoverview.png'),'-dpng','-r500')
