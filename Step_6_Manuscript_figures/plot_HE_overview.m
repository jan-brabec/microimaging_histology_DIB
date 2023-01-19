clear all; clf; clc;

figure(115);

addpath(fullfile('..','Step_5_View_data'));

ha = tight_subplot(4,4,[.0,.0],[.0,.0],[.0,.0]);

for sample = 1:16
    
    data_path = fullfile('..','..','data');
    pth = fullfile(data_path,num2str(sample),'coreg_fine','ver1');
    load(fullfile(pth,'HE.mat'),'HE');
    
    axes(ha(sample));
    imagesc(HE)
    axis image off
    drawnow;
    
end

print(sprintf('Overview_HE.png'),'-dpng','-r500')
