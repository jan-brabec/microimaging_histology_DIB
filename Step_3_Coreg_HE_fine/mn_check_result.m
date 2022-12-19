function mn_check_result(HE,MD,FA2D)
% function mn_check_result(A,B)
%
% Written by Markus Nilsson (markus.nilsson@med.lu.se).


clf;
set(gcf,'color','white');
colormap gray;

subplot(2,3,4); cla; hold off;
h5 = imagesc(HE);
axis image off;

subplot(2,3,5);
h10 = imagesc(MD);
axis image off;

subplot(2,3,6);
h15 = imagesc(FA2D);
axis image off;
caxis([0 0.5])

subplot(2,3,1); cla; hold off;
h_im = imagesc(HE);
set(h_im, 'ButtonDownFcn', @im_click_A, 'userdata', [h5 h10 h15]);
axis image off;

subplot(2,3,2);
h_im = imagesc(MD);
set(h_im, 'ButtonDownFcn', @im_click_B, 'userdata', [h5 h10 h15]);
axis image off;

subplot(2,3,3);
h_im = imagesc(FA2D);
set(h_im, 'ButtonDownFcn', @im_click_C, 'userdata', [h5 h10 h15]);
axis image off;
caxis([0 0.5])





A_sz = size(HE);
B_sz = size(MD);

s = A_sz(1:2) ./ B_sz(1:2);
w = 3;

    function im_click_B(hx,hy)
        p = floor(hy.IntersectionPoint([2 1])) + 0.5;
        
        im_zoom_A(hx.UserData(1).Parent, (p-1) .* s);
        im_zoom_B(hx.UserData(2).Parent, p);
        im_zoom_B(hx.UserData(3).Parent, p);
    end

    function im_click_C(hx,hy)
        p = floor(hy.IntersectionPoint([2 1])) + 0.5;
        
        im_zoom_A(hx.UserData(1).Parent, (p-1) .* s);
        im_zoom_B(hx.UserData(2).Parent, p);
        im_zoom_B(hx.UserData(3).Parent, p);
    end

    function im_click_A(hx,hy)
        p = floor(hy.IntersectionPoint([2 1])) + 0.5;
        
        p = floor(p ./ s) - 0.5;

        im_zoom_A(hx.UserData(1).Parent, (p-1) .* s);
        im_zoom_B(hx.UserData(2).Parent, p);   
        im_zoom_B(hx.UserData(3).Parent, p);
    end

    function im_zoom_A(h, p)
        
        xlim(h, p(2)  + [-w w+1] * s(2) );
        ylim(h, p(1)  + [-w w+1] * s(1) );
        
        % show pixel grid, but first delete points
        ht = h;
        
        hold(ht,'on');
        tmp = ht.Children;
        for c = 1:numel(tmp)
            switch (class(tmp(c)))
                case 'matlab.graphics.chart.primitive.Line'
                    delete(tmp(c));
            end
        end
        
        for i = -w:(w+1)
            for j = -w:(w+1)
                
                if (j <= w)
                    plot(ht, ...
                        p(2) + j * s(2) + [0 1] * s(2), ...
                        p(1) + i * s(1) + [0 0] * s(1), ...
                        'r', 'linewidth', 1);
                end
                
                if (i <= w)
                    plot(ht, ...
                        p(2) + j * s(2) + [0 0] * s(2), ...
                        p(1) + i * s(1) + [0 1] * s(1), ...
                        'r', 'linewidth', 1);
                end
                
            end
        end
    end


    function im_zoom_B(h, p)
        xlim(h, p(2) + [-w w+1]);
        ylim(h, p(1) + [-w w+1]);
    end



end