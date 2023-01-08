clear all; clf; clc;

figure(112);

ha = tight_subplot(4,4,[.0,.0],[.0,.0],[.0,.0]);

for sample = 1:16
    
    %     if sample == 1 || sample == 11 || sample == 3
    %         axes(ha(sample));
    %         axis image off
    %         continue;
    %     end
    
    data_path = fullfile('..','..','data');
    pth = fullfile(data_path,num2str(sample),'coreg_fine','ver1');
    load(fullfile(pth,'VEGF.mat'),'VEGF');
    %     load(fullfile(pth,'HE.mat'),'HE');
    
    axes(ha(sample));
    %     imagesc(HE)
    imagesc(VEGF)
    axis image off
    drawnow;
    
end

print(sprintf('Overview.png'),'-dpng','-r500')
