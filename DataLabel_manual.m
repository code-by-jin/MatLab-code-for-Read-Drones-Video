
clear; clc; close all;
C1 = [72.9032  239.7032]; C2 = [182.7417  239.7342]; 

v = VideoReader('02_crashed_for_unknown_reason.mp4');
% numFrames = ceil(v.FrameRate*v.Duration);
fileID = fopen('02_crashed_for_unknown_reason.txt', 'wt');
time_start = "00:00 s"; op_left_last = ''; op_right_last = ''; swap_situation_last = 'Mini-map';

while hasFrame(v)
    frame = readFrame(v);
    if ~isequal(reshape(frame(500, 400, :), 1, 3), [237 237 237])
        op_left_last = ''; op_right_last = ''; 
        continue;
    end
    txt_time = ocr(frame(430:470,550:670));
    time = strtrim(string(txt_time.Text));
    flag_print = 0;
    
    if time == time_start
        continue;
    end
        
%     txt_altitude = ocr(frame(430:470,750:850));
%     altitude = strtrim(string(txt_altitude.Text));
    
    I = rgb2gray(frame);
    [center_left, rad_left] = imfindcircles(I(1:300, 100:300),[25 35], 'ObjectPolarity','dark', 'Sensitivity', 0.9);
    [center_right, rad_right] = imfindcircles(I(1:300, 800:1100),[25 35], 'ObjectPolarity','dark', 'Sensitivity', 0.9);
    
    if ~isempty(center_left)
        d1 = pdist([C1; center_left]);
        if d1 > 10
            if center_left(2)- C1(2) < -5
                op_left = 'Rise';
            elseif center_left(2)- C1(2) > 5
                op_left = 'Descent';
            elseif center_left(1)- C1(1) < -5
                op_left = 'Rotate Left';
            elseif center_left(1)- C1(1) > 5
                op_left = 'Rotate Right';
            end
        end
    else
        op_left = '';
    end
    if ~strcmp(op_left, op_left_last) && ~strcmp(op_left, '')
        disp(op_left);%%%
        fprintf(fileID, '%s ', op_left);
        flag_print = 1;
    end
    
    if ~isempty(center_right)
        d2 =pdist([C2; center_right]);
        if d2 > 10
            degree = get_direction(center_right, C2);
            op_right = num2str(degree);
        end
    else
        op_right = '';
    end
    if ~strcmp(op_right, op_right_last) && ~strcmp(op_right, '')
        disp(op_right); %
        fprintf(fileID, '%s ', op_right);
        flag_print = 1;
    end
    
    if isequal(reshape(frame(400, 400, :), 1, 3), [215 215 215])
        swap_situation = 'Mini-map';
    else
        swap_situation = 'Main Camera';
    end 
    if ~strcmp(swap_situation, swap_situation_last)
        fprintf(fileID, 'View Switching');
        flag_print = 1;
    end
    
    if flag_print == 1
        fprintf(fileID, '\n');
    end
    
    op_left_last = op_left; op_right_last = op_right; swap_situation_last = swap_situation;
end

fclose(fileID);
