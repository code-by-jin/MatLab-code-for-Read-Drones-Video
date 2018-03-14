clear; clc; close all;

% Get centers of two joysticks
vidobj = VideoReader('4_tablet_test.mp4');
vidobj.CurrentTime = 149;
Original = readFrame(vidobj);
I1 = rgb2gray(Original);
[C1, radii_start1] = imfindcircles(I1(1:300, 100:300),[25 35], 'ObjectPolarity','dark', 'Sensitivity',0.9);
[C2, radii_start2] = imfindcircles(I1(1:300, 800:1100),[25 35], 'ObjectPolarity','dark', 'Sensitivity',0.9);

% imtool(Original)
size(Original);
a = [215 215 215];
if a == Original(400, 400, :)
    disp(a);
end
