clear all; clf; clc;

figure(113);

addpath('../Step_5_View_data');

ha = tight_subplot(3,3,[.01,.01],[.01,.01],[.01,.01]);

set(gcf,'color','w');

sample = 5;

data_path = fullfile('..','..','data');
pth = fullfile(data_path,num2str(sample),'coreg_fine','ver1');
load(fullfile(pth,'MR.mat'),'MR');

axes(ha(1));
lim = 3000;
imagesc(process_map(MR.PA(:,:,1),MR.ROI,lim,0))
colormap gray
caxis([0 lim])
axis image off

axes(ha(2));
lim = 2000;
imagesc(process_map(MR.PA(:,:,2),MR.ROI,lim,0))
colormap gray
caxis([0 lim])
axis image off

axes(ha(3));
lim = 1000;
imagesc(process_map(MR.PA(:,:,3),MR.ROI,lim,0))
colormap gray
caxis([0 lim])
axis image off


axes(ha(4));
lim = 0.8;
imagesc(process_map(MR.MD,MR.ROI,lim,0))
colormap gray
caxis([0 lim])
axis image off

axes(ha(5));
lim = 0.8;
imagesc(process_map(MR.FA,MR.ROI,lim,0))
colormap gray
caxis([0 lim])
axis image off

axes(ha(6));
lim = 0.8;
imagesc(process_map(MR.FAIP,MR.ROI,lim,0))
colormap gray
caxis([0 lim])
axis image off

axes(ha(7));
lim = 1.2;
imagesc(process_map(MR.AD,MR.ROI,lim,0))
colormap gray
caxis([0 lim])
axis image off

axes(ha(8));
lim = 0.6;
imagesc(process_map(MR.RD,MR.ROI,lim,0))
colormap gray
caxis([0 lim])
axis image off


delete(ha(9))



print(sprintf('MRoverview.png'),'-dpng','-r500')
