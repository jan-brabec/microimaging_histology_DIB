%Crop to align
clc
clear all

for sample = 3:3
    sample
    
    clearvars -except sample
    
    data_path = fullfile('..','data',num2str(sample));
    load(fullfile(data_path,'coreg_rough.mat'),'HE','VEGF');
    load(fullfile(data_path,'raw','MR.mat'),'MD','FA','FA2D');
    
    clf
    subplot(2,2,1)
    imagesc(MD); axis image; colormap gray;
    subplot(2,2,2)
    imagesc(FA); axis image; colormap gray;
    subplot(2,2,3)
    imagesc(HE); axis image; colormap gray;
    subplot(2,2,4)
    imagesc(VEGF); axis image; colormap gray;
    
    [p_mr,p_he,p_ve] = get_cropping_points(sample);
    
    m_x = 1; % margins
    m_y = 1;
    
    % cropped MD, FA
    C_MD   = MD( (p_mr(1,2) - m_y):(p_mr(2,2) + m_y), (p_mr(1,1) - m_x):(p_mr(2,1) + m_x));
    C_FA   = FA( (p_mr(1,2) - m_y):(p_mr(2,2) + m_y), (p_mr(1,1) - m_x):(p_mr(2,1) + m_x));
    C_FA2D = FA2D( (p_mr(1,2) - m_y):(p_mr(2,2) + m_y), (p_mr(1,1) - m_x):(p_mr(2,1) + m_x));
    
    % crop HE, VEGF
    f = @(x) x(2,:) - x(1,:);
    s_HE = round((f(p_he) ./ f(p_mr)));
    disp(s_HE);
    s_HE = round(mean(s_HE));
    
    C_HE = HE( ...
        (p_he(1,2) - s_HE*m_y):(p_he(2,2) + s_HE*m_y), (p_he(1,1) - s_HE*m_x):(p_he(2,1) + s_HE*m_x), :);
    
    if ~isempty(VEGF)
        s_VE = round((f(p_ve) ./ f(p_mr)));
        disp(s_VE);
        s_VE = round(mean(s_VE));
        
        C_VEGF = VEGF( ...
            (p_ve(1,2) - s_VE*m_y):(p_ve(2,2) + s_VE*m_y), (p_ve(1,1) - s_VE*m_x):(p_ve(2,1) + s_VE*m_x), :);
    else
        C_VEGF = [];
    end
    
    clf
    crop_fig = figure;
    set(crop_fig, 'Position', get(0, 'Screensize'));
    subplot(2,2,1)
    imagesc(MD); axis image; colormap gray;
    subplot(2,2,2)
    imagesc(FA); axis image; colormap gray;
    subplot(2,2,3)
    imagesc(HE); axis image; colormap gray;
    subplot(2,2,4)
    imagesc(VEGF); axis image; colormap gray;
    
    save(fullfile(data_path,'coreg_rigid.mat'), 'C_MD', 'C_FA','C_FA2D', 'C_HE', 'C_VEGF', '-v7.3');
    saveas(crop_fig,fullfile('..','data',strcat('cropped_',num2str(sample),'.png')))
    
end

