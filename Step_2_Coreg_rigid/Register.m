clear all

for sample = 1:16
    for contrast = 1:2
        clearvars -except sample contrast
        
        if sample == 1 && contrast == 2
            VEGF = [];
            continue;
        end
        
        if sample == 11 && contrast == 2
            VEGF = [];
            continue
        end
        
        sample
        contrast
        
        if contrast == 1
            c_name = 'HE';
        else
            c_name = 'VEGF';
        end
        
        i_pth_h  = fullfile('..','data',num2str(sample),'raw_histo');
        i_pth_mr = fullfile('..','data',num2str(sample),'init_MR','ver1');
        o_pth    = fullfile('..','data',num2str(sample),'coreg_rigid','ver1');
        
        H_ref(:,:,1) = imread(fullfile(i_pth_h,strcat(c_name,'.tif')),'Index',1);
        H_ref(:,:,2) = imread(fullfile(i_pth_h,strcat(c_name,'.tif')),'Index',2);
        H_ref(:,:,3) = imread(fullfile(i_pth_h,strcat(c_name,'.tif')),'Index',3);
        
        load(fullfile(i_pth_mr,'MR.mat'),'MR');
        
        H = get_H_transform(H_ref,sample,contrast);
        [Mp,Hp] = get_landmarks(sample,contrast);
        
        reg_fig1 = figure;
        set(reg_fig1, 'Position', get(0, 'Screensize'));
        clf;
        subplot(2,2,1); %MD
        imagesc(MR.MD); axis image off; hold on;
        plot(Mp(:,1), Mp(:,2), 'bo','LineWidth',8);
        caxis([0 1.5]);
        title('MD');
        colormap gray
        colorbar;
        
        subplot(2,2,2); %FA
        imagesc(MR.FA); axis image off; hold on;
        plot(Mp(:,1), Mp(:,2), 'bo','LineWidth',8);
        caxis([0 0.5]);
        title('FA');
        colormap gray
        colorbar;
        
        subplot(2,2,4);
        imagesc(H); axis image off; hold on;
        plot(Hp(:,1), Hp(:,2), 'ro','LineWidth',8);
        title('Histology original');
        
        % compute the affine transform between MP and HP
        % we know Mp = Hp * X, with X = [3x2], Hp = [Nx3], Mp = [Nx2]
        % see projective geometry and
        % https://math.stackexchange.com/questions/612006/decomposing-an-affine-transformation
        Hx = cat(2, Hp, ones(size(Hp,1),1));
        X = inv(Hx' * Hx) * Hx' * Mp;
        Mpr = Hx * X;
        
        subplot(2,2,1);
        plot(Mpr(:,1), Mpr(:,2), 'ro','LineWidth',8);
        subplot(2,2,2);
        plot(Mpr(:,1), Mpr(:,2), 'ro','LineWidth',8);
        
        % pull out the rotation
        theta = atan(X(2,1) / X(1,1));
        
        % now rotate histology image and reference points
        H_rot = imrotate(H, theta * 180/pi, 'nearest', 'crop');
        H_rot(H_rot(:) == 0) = max(H_rot(:));
        
        % define the same points in the rotated version
        R = [cos(theta) -sin(theta); sin(theta) cos(theta)];
        T = ((eye(2) - R) * [size(H,1); size(H,2)])/2;
        
        Hp3 = Hp * R + repmat([T(2) T(1)], size(Hp,1), 1);
        
        subplot(2,2,3);
        imagesc(H_rot); hold on;
        axis image off;
        plot(Hp3(:,1), Hp3(:,2), 'ro','LineWidth',8);
        title('Histology rotated');
        
        % compute the step mr-histology
        Mx = cat(2, Mp, ones(size(Mp,1),1));
        Y = inv(Mx' * Mx) * Mx' * Hp3;
        A = Y(1:2,1:2);
        
        % remaining rotation
        theta2 = atan(A(2,1) / A(1,1));
        
        if contrast == 1
            HE = H_rot;    
            mkdir(o_pth)
            save(fullfile(o_pth,'HE.mat'), 'HE', '-v7.3');
            clear HE H_rot
        elseif contrast == 2
            VEGF = H_rot;
            mkdir(o_pth)
            save(fullfile(o_pth,'VEGF.mat'), 'VEGF', '-v7.3');
            clear VEGF H_rot
        end
        
        saveas(reg_fig1,fullfile(fullfile('..',strcat(num2str(sample),'_correg_rigid_',c_name,'.png'))))
    end
    

     
    
end





