vid = videoinput('winvideo',1);
set(vid,'ReturnedColorSpace','rgb');
set(vid,'TriggerRepeat',Inf);
vid.FrameGrabInterval = 1;
vid_src = getselectedsource(vid);
set(vid_src,'Tag','Intellicam setup');
figure(1);
start(vid)
%    vid.FramesAcquired<=400
while(vid.FramesAcquired<=400)
    data = getdata(vid,2);
    I1=flipdim(data(:,:,:,2),2);
    
    snap = I1;
    % imshow(I1);
    snap_red = imsubtract(snap(:,:,1), rgb2gray(snap));
    snap_blue = imsubtract(snap(:,:,3), rgb2gray(snap));
    snap_green = imsubtract(snap(:,:,2), rgb2gray(snap));
    
    %Filter out noise
    snap_red = medfilt2(snap_red, [3 3]);
    snap_blue = medfilt2(snap_blue, [3 3]);
    snap_green = medfilt2(snap_green, [3 3]);
    
    % Convert new snapshot to binary
    snap_red = im2bw(snap_red,0.18);
    snap_blue = im2bw(snap_blue,0.18);
    snap_green = im2bw(snap_green,0.18);
    
    %{
% Remove pixles less than 300px
snap_red = bwlabel(snap_red, 8);
snap_blue = bwlabel(snap_blue, 8);
snap_green = bwlabel(snap_green, 8);
    %}
    
    % Label all connected components
    bw_red = bwlabel(snap_red,8);
    bw_blue = bwlabel(snap_blue,8);
    bw_green = bwlabel(snap_green,8);
    
    
    imshow(bw_green), title('only green color is detected');
     % imshow(bw_red), title('only red color is detected');

    % imshow(bw_blue), title('only blue color is detedted');
    
    hold(imgca,'on');
    hold(imgca,'off');
end
stop(vid)
