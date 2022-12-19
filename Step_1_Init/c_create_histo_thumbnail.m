clear; clc;

data_path = fullfile('..','data');
c_name = {'HE','VEGF'};

for sample = 1:16
    
    sample
    
    for c_n = 1:numel(c_name)
        
        clearvars -except sample c_name c_n data_path
        if sample == 1 && c_n == 2 %No VEGF for sample 1
            continue;
        end
        
        if sample == 11 && c_n == 2 %No VEGF for sample 11
            continue;
        end
        
        H_ref(:,:,1) = imread(fullfile(data_path,num2str(sample),'raw_histo',strcat(c_name{c_n},'.tif')),'Index',1);
        H_ref(:,:,2) = imread(fullfile(data_path,num2str(sample),'raw_histo',strcat(c_name{c_n},'.tif')),'Index',2);
        H_ref(:,:,3) = imread(fullfile(data_path,num2str(sample),'raw_histo',strcat(c_name{c_n},'.tif')),'Index',3);
        
        ss = 20;
        H_thumb = H_ref(1:ss:end,1:ss:end,:);
        
        fig = figure;
        set(fig, 'Position', get(0, 'Screensize'));
        imagesc(H_thumb);
        hold on;
        axis image off;
        
        saveas(fig,fullfile(data_path,num2str(sample),'raw_histo',strcat(c_name{c_n},'_thumbnail.tif')))
        
        
    end
    
end
