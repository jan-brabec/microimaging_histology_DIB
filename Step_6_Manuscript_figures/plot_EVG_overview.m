clear all; clf; clc;

figure(112);

addpath(fullfile('..','Step_5_View_data'));

ha = tight_subplot(4,4,[.0,.0],[.0,.0],[.0,.0]);
set(gcf,'color','white')

for sample = 1:16
    
    if sample == 1 || sample == 11
        axes(ha(sample));
        axis image off
        continue;
    end
    
    data_path = fullfile('..','..','data');
    pth = fullfile(data_path,num2str(sample),'coreg_fine','ver1');
    load(fullfile(pth,'EVG.mat'),'EVG');
    
    axes(ha(sample));
    imagesc(EVG)
    axis image off
    drawnow;
    
end

print(sprintf('EVG_overview.png'),'-dpng','-r500')
