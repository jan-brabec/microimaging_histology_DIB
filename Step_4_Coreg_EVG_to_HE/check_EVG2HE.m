function check_EVG2HE(HE,EVG)
% function check_result(A,B)
%
% Jan Brabec modified code that
% was written by Markus Nilsson (markus.nilsson@med.lu.se).

clf;
set(gcf,'color','white');
colormap gray;

subplot(2,2,3); cla; hold off;
h5 = imagesc(HE);
axis image off;

subplot(2,2,4);
h10 = imagesc(EVG);
axis image off;


subplot(2,2,1); cla; hold off;
h_im = imagesc(HE);
set(h_im, 'ButtonDownFcn', @im_click_A, 'userdata', [h5 h10]);
axis image off;

subplot(2,2,2);
h_im = imagesc(EVG);
set(h_im, 'ButtonDownFcn', @im_click_B, 'userdata', [h5 h10]);
axis image off;

A_sz = size(HE);
B_sz = size(EVG);

s = A_sz(1:2) ./ B_sz(1:2);
w = 800;

    function im_click_B(hx,hy)
        p = floor(hy.IntersectionPoint([2 1])) + 0.5;
        
        im_zoom_A(hx.UserData(1).Parent, (p-1) .* s);
        im_zoom_A(hx.UserData(2).Parent, p);
    end

    function im_click_A(hx,hy)
        p = floor(hy.IntersectionPoint([2 1])) + 0.5;
        
        p = floor(p ./ s) - 0.5;
        
        im_zoom_A(hx.UserData(1).Parent, (p-1) .* s);
        im_zoom_A(hx.UserData(2).Parent, p);
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
        
        plot(ht, ...
            p(2) + [ 0 0]  ,  ...
            p(1)  + [-w w+1] * s(1), ...
            'r', 'linewidth', 1);
        
        plot(ht, ...
            p(2)  + [-w w+1] * s(2), ...
            p(1)  + [0   0] * s(1), ...
            'r', 'linewidth', 1);        
    end


end