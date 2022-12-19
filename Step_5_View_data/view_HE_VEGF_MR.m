function view_HE_VEGF_MR(sample)
% function view_HE_VEGF_MR(sample)


% Load data
pth_VEGF_HE = fullfile('..','data',num2str(sample),'coreg_fine','ver1');

load(fullfile(pth_VEGF_HE,'MR.mat'),'MR');
load(fullfile(pth_VEGF_HE,'HE.mat'),'HE');
if sample ~= 1 && sample ~=11
    load(fullfile(pth_VEGF_HE,'VEGF.mat'),'VEGF');
else
    warning('Samples 1 and 11 do not have coregistered VEGF')
    warning('Loading H&E as VEGF instead')
    VEGF = HE;
end

%Define limits of caxes
lims_FAIP = 0.8;
lims_MD   = 1.2;

%Process maps outside of ROI
FAIP = process_map(MR.FAIP,MR.ROI,lims_FAIP,0);
MD   = process_map(MR.MD  ,MR.ROI,lims_MD  ,0);


figure(202);
clf;
set(gcf,'color','white');
colormap gray;

ha = tight_subplot(2,3,[.01,.01],[.01,.01],[.01,.01]);

axes(ha(4)); cla; hold off;
h5 = imagesc(HE);
hold on;
axis image off;

axes(ha(5)); cla; hold off;
h10 = imagesc(VEGF);
hold on;
axis image off;

axes(ha(1)); cla; hold off;
h_im = imagesc(HE);
set(h_im, 'ButtonDownFcn', @im_click_A, 'userdata', [h5 h10]);
axis image off;

axes(ha(2)); cla; hold off;
h_im = imagesc(VEGF);
set(h_im, 'ButtonDownFcn', @im_click_A, 'userdata', [h5 h10]);
axis image off

axes(ha(3)); cla; hold off;
h_im = imagesc(MD);
set(h_im, 'ButtonDownFcn', @im_click_B, 'userdata', [h5 h10]);
colormap(ha(3), 'gray');
caxis([0 lims_MD])
axis image off

axes(ha(6)); cla; hold off;
h_im = imagesc(FAIP);
set(h_im, 'ButtonDownFcn', @im_click_B, 'userdata', [h5 h10]);
colormap(ha(4), 'gray');
caxis([0 lims_FAIP])
axis image off

A_sz = size(HE);
B_sz = size(MR.MD);

s = A_sz(1:2) ./ B_sz(1:2);
w = 2;

    function im_click_B(hx,hy)
        p = floor(hy.IntersectionPoint([2 1])) + 0.5;
        
        im_zoom_A(hx.UserData(1).Parent, (p-1) .* s);
        im_zoom_B(hx.UserData(2).Parent, (p-1) .* s);
    end

    function im_click_A(hx,hy)
        p = floor(hy.IntersectionPoint([2 1])) + 0.5;
        p = floor(p ./ s) - 0.5;
        
        im_zoom_A(hx.UserData(1).Parent, (p-1) .* s);
        im_zoom_B(hx.UserData(2).Parent, (p-1) .* s);
    end

    function im_zoom_A(h, p)
        xlim(h, p(2)  + [-w w+1] * s(2) );
        ylim(h, p(1)  + [-w w+1] * s(1) );
    end

    function im_zoom_B(h, p)
        xlim(h, p(2)  + [-w w+1] * s(2) );
        ylim(h, p(1)  + [-w w+1] * s(1) );
    end

end