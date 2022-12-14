function mn_reg_finetune(A,B,lm_fn, result_fn,MR,purpose, sample)
% function mn_reg_finetune(A,B,lm_fn)
%
% Landmark-based registration to A from B using landmarks in lm_fn and
% options in opt
%
% A - histology image
% B - MR image

% a - add landmark
% d - delete landmark
% n - go to next landmark
% p - go to previous landmark
% s - save landmark file
% l - load landmark file
% i - show the interpolation grid
% r - compute final results, store in result_fn

if (nargin == 0)
    % load the .mat file with H_rot and M_MD, and rename these as A and B
    global A B lm_fn;
    if (numel(A) == 0), error('images undefined'); end
    if (numel(B) == 0), error('images undefined'); end
    if (numel(lm_fn) == 0), error('landmark filename undefined'); end    
end

if (nargin < 4), result_fn = 'result.mat'; end

lm.A = {[NaN NaN]};
lm.B = {[NaN NaN]};

d.lm = lm;
d.c_lm = 1;
d.n_lm = 1;
d.MR = MR;
d.purpose = purpose;
d.sample = sample;

    function im_button_down(h_image, h_event)
        % entry point for all landmark definition clicks
        
        d = h_image.Parent.Parent.UserData;
        tag = h_image.Tag;
        
        p = round(h_event.IntersectionPoint(2:-1:1));
        d.lm.(tag){d.c_lm} = p;
        h_image.Parent.Parent.UserData = d;
        
        % update  content
        im_update_overview_content(d.h.(tag).h1);
        im_update_detailed_content(d.h.(tag).h2);
        
    end

    function im_update_detailed_content(h_image)
        % update zoomed-in images with landmark points

        tag = get(h_image, 'Tag');
        
        % Clear all existing points
        hold(h_image.Parent,'on');
        tmp = h_image.Parent.Children;
        for c = 1:numel(tmp)
            switch (class(tmp(c)))
                case 'matlab.graphics.chart.primitive.Line'
                    delete(tmp(c));
            end
        end        
        
        % Zoom in and add point
        p = d.lm.(tag){d.c_lm};
        if (~any(isnan(p)))
            sz = [max(h_image.XData) max(h_image.YData)];
            xlim(h_image.Parent, p(2) + [-1 1] * 0.05 * mean(sz));
            ylim(h_image.Parent, p(1) + [-1 1] * 0.05 * mean(sz));
        
        plot(h_image.Parent, p(2),p(1), 'o', ...
            'markersize', 8, ...
            'markeredgecolor','black', ...
            'markerfacecolor','yellow');
        end
    end


    function im_update_overview_content(h_image)
        % update overview images with all landmarks
        
        % delete all points
        hold(h_image.Parent,'on');
        tmp = h_image.Parent.Children;
        for c = 1:numel(tmp)
            switch (class(tmp(c)))
                case 'matlab.graphics.chart.primitive.Line'
                    delete(tmp(c));
            end
        end
        
        % plot all points
        tag = get(h_image, 'Tag');
        for c_lm = 1:d.n_lm
            p = d.lm.(tag){c_lm};
            
            if (c_lm == d.c_lm)
                col = 'yellow';
            else
                col = 'white';
            end
            
            plot(h_image.Parent, p(2),p(1), 'o', ...
                'markersize', 8, ...
                'markeredgecolor','black', ...
                'markerfacecolor',col);
        end
        
        % plot bounding box
        if (d.n_lm >= 2)
            [p_ul, p_lr] = mn_bounding_box(d.lm.(tag));
            plot(h_image.Parent, ...
                [p_ul(2) p_ul(2) p_lr(2) p_lr(2) p_ul(2)], ...
                [p_ul(1) p_lr(1) p_lr(1) p_ul(1) p_ul(1)], 'k-', ...
                'linewidth', 2, 'color', 'blue');
            
        end
        
        % set a new title
        title(h_image.Parent, sprintf('Landmark %i (%i)', ...
            d.c_lm, d.n_lm));
    end


    function lm_load(h_fig, varargin)
        % load landmarks from file
        
        d = h_fig.UserData;
        if (exist(lm_fn, 'file')), return; end
        
        q = questdlg('Proceed loading landmarks?', ...
                'Load landmarks', 'Yes', 'No', 'Yes');
        
        if (~strcmp(q, 'Yes')), return; end
        
        lm_save.lm = []; 
        lm_save.n_lm = -1;
        load(lm_fn);
        d.lm = lm_save.lm;
        d.c_lm = 1;
        d.n_lm = lm_save.n_lm;
        
        % update  content
        im_update_overview_content(d.h.A.h1);
        im_update_detailed_content(d.h.A.h2);        
        im_update_overview_content(d.h.B.h1);
        im_update_detailed_content(d.h.B.h2);        
        
    end

    function lm_save(h_fig, varargin)
        % save landmarks to file
        
        % compile data
        lm_save.lm = h_fig.UserData.lm;
        lm_save.n_lm = h_fig.UserData.n_lm;
        
        % save
        warning off; 
        delete(lm_fn);
        warning on;
        save(lm_fn, 'lm_save');
        
        % let the user know 
        msgbox('Landmarks saved');
    end


    function fig_keypress(h_fig, h_event)
        % deal with keypresses
        
        d = h_fig.UserData;
        
        switch (h_event.Key)
            
            case 'a' % add landmark
                d.n_lm = d.n_lm + 1;
                d.c_lm = d.n_lm;
                
                d.lm.A{d.n_lm} = [NaN NaN];
                d.lm.B{d.n_lm} = [NaN NaN];                
                
            case 'd' % delete current landmark
                if (d.n_lm > 1)
                    d.lm.A = d.lm.A(1:d.n_lm ~= d.c_lm);
                    d.lm.B = d.lm.B(1:d.n_lm ~= d.c_lm);
                    
                    d.n_lm = d.n_lm - 1;
                    if (d.c_lm == 1)
                        d.c_lm = d.n_lm;
                    else
                        d.c_lm = d.c_lm - 1;
                    end
                end
                
            case 'n' % next landmark
                d.c_lm = min(d.c_lm + 1, d.n_lm);
            case 'p' % previous landmark
                d.c_lm = max(1, d.c_lm - 1);
                
            case 'i'
                mn_show_grid(h_fig);
                
            case 'r'
                mn_result(h_fig);
                
            case 's'
                lm_save(h_fig);

            case 'l'
                lm_load(h_fig);
        end
                        
        h_fig.UserData = d;
        
        im_update_overview_content(d.h.A.h1);
        im_update_detailed_content(d.h.A.h2);
        im_update_overview_content(d.h.B.h1);
        im_update_detailed_content(d.h.B.h2);        
        
    end

    function mn_show_grid(h_fig)
        %  show grid to get a feeling for distortions
        
        d = get(h_fig, 'UserData');
        
        if (d.n_lm <= 2), return; end
        
        [A_ul, A_br] = mn_bounding_box(d.lm.A, 1);
        [B_ul, B_br] = mn_bounding_box(d.lm.B, 1);

        % zoom out a bit;
        zoom_out = 1.2;
        g = @(x) mean(x) + [-1 1] * (x(2)-x(1)) / 2 * zoom_out;        
        
        hA = subplot(2,3,3); cla(hA); hold(hA, 'off');
        imagesc(A); axis image off; hold(hA, 'on');
        xlim(g([A_ul(2) A_br(2)]));
        ylim(g([A_ul(1) A_br(1)]));
        
        hB = subplot(2,3,6); cla(hB); hold(hB, 'off');
        imagesc(B); axis image off; hold(hB, 'on');
        xlim(g([B_ul(2) B_br(2)]));
        ylim(g([B_ul(1) B_br(1)]));
        
        % scale of FOV
        s = (A_br(2) - A_ul(2)) / (A_br(1) - A_ul(1));                                
        ni = 10;
        nj = ni * round(s);
        
        % show the grid
        for i = 1:(ni+1)
            for j = 1:(nj+1)
                p = @(i,j)[...
                    A_ul(1) + (i) / ni * (A_br(1)-A_ul(1))
                    A_ul(2) + (j) / nj * (A_br(2)-A_ul(2))];
                
                p1 = p(i-1,j-1);
                p2 = p(i,j-1);
                p3 = p(i-1,j);
                
                if (i <= ni)
                    plot(hA, [p1(2) p2(2)], [p1(1) p2(1)], 'k-');
                end
                
                if (j <= nj)
                    plot(hA, [p1(2) p3(2)], [p1(1) p3(1)], 'k-');
                end
                
                p1 = coord_A_to_B(p1, d.lm);
                p2 = coord_A_to_B(p2, d.lm);
                p3 = coord_A_to_B(p3, d.lm);
                
                if (i <= ni)
                    plot(hB, [p1(2) p2(2)], [p1(1) p2(1)], 'r-');
                end
                
                if (j <= nj)
                    plot(hB, [p1(2) p3(2)], [p1(1) p3(1)], 'r-');
                end
                
            end
        end
    end


    function mn_result(h_fig)
        % this is where we use the landmarks to produce a final
        % interpolated image, and saving it
        
        d = h_fig.UserData;
        
        disp('Starting to save images');
        tic;
        mn_finalize(A, B, d, result_fn);
        disp('Done');
        toc;
        
    end


clf; 
set(gcf,'color','white', 'KeyPressFcn', @fig_keypress);
colormap gray;

% overview
subplot(2,3,1);
hA = imagesc(A); axis image off;
set(hA, 'ButtonDownFcn', @im_button_down, 'Tag', 'A');

% details
subplot(2,3,2);
hA_2 = imagesc(A); axis image off;
set(hA_2, 'ButtonDownFcn', @im_button_down, 'Tag', 'A');

subplot(2,3,4);
hB = imagesc(B); axis image off; 
set(hB, 'ButtonDownFcn', @im_button_down, 'Tag', 'B');

subplot(2,3,5);
hB_2 = imagesc(B); axis image off;
set(hB_2, 'ButtonDownFcn', @im_button_down, 'Tag', 'B');

d.h.A.h1 = hA;
d.h.A.h2 = hA_2;
d.h.B.h1 = hB;
d.h.B.h2 = hB_2;
set(gcf,'userdata',d);

end


