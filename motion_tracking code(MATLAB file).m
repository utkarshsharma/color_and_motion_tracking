vid = videoinput('winvideo',1);
set(vid,'ReturnedColorSpace','rgb');
set(vid,'TriggerRepeat',Inf);
vid.FrameGrabInterval = 1;
vid_src = getselectedsource(vid);
set(vid_src,'Tag','Intellicam setup');
figure; 
start(vid)
%    vid.FramesAcquired<=400
while(vid.FramesAcquired<=400) 
    data = getdata(vid,3);
    I1=flipdim(data(:,:,:,1),2);
    I2=flipdim(data(:,:,:,2),2);
    diff_im = imabsdiff(I1,I2);
    diff = rgb2gray(diff_im);
    diff_range = rangefilt(diff);
    diff_bw = im2bw(diff,0.15);
    noi_red = medfilt2(diff_bw,[3 3]); %reduces the noise still mainting the edge quality
    bw2 = imfill(noi_red,'holes');
    
    %imshow(I1);
    %imshow(diff_im);
    imshow(noi_red);
    %imshow(bw2);
    
    hold(imgca,'on');
    hold(imgca,'off');
end
stop(vid)
