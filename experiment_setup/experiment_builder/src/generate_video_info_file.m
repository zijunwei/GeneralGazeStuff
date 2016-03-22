clear all;
close all;
clc;

addpath( genpath('mmread') );

video_root_path = '../data/output';

files = dir(fullfile(video_root_path, '/*.mp4'));

%% check whether filename contains an unsupported character
disp('remove "-" from the name of the files\n');

fout = fopen('filename_info.txt', 'w');
for i=1:length(files)
    ori_filename = files(i).name;
    
    new_filename = strrep(ori_filename, '-', '_');
    
    fprintf(fout, '%s %s\n', ori_filename, new_filename);
    
    if ~strcmp(ori_filename, new_filename)
        movefile(fullfile(video_root_path, '/', ori_filename), fullfile(video_root_path, '/', new_filename));
    end
end

fclose(fout);

%% save the video information
width = [];
height = [];
totalDuration = [];
nrFramesTotal = [];
rate = [];
filenames = {};

for i=1:length(files)
    filename = files(i).name;
    fprintf('%s is processing...(%d/%d)\n', filename, i, length(files));
    
    video = mmread(sprintf('%s/%s', video_root_path, filename), [], [], false, true);
    
    filenames = [filenames; filename];
    width = [width; video.width];
    height = [height; video.height];
    totalDuration = [totalDuration; video.totalDuration];
    nrFramesTotal = [nrFramesTotal; video.nrFramesTotal];
    rate = [rate; video.rate]; 
end

fprintf('stat:\n')
fprintf('[duration] total: %.3f, avg: %.3f, min: %.3f, max: %.3f\n', sum(totalDuration), mean(totalDuration) , min(totalDuration), max(totalDuration));
fprintf('[width] avg: %.3f, min: %d, max: %d\n', mean(width) , min(width), max(width));
fprintf('[height] avg: %.3f, min: %d, max: %d\n', mean(height) , min(height), max(height));
fprintf('[# of frames] total: %d, avg: %.3f, min: %d, max: %d\n', sum(nrFramesTotal), mean(nrFramesTotal) , min(nrFramesTotal), max(nrFramesTotal));
fprintf('[frame rate] avg: %.3f, min: %.3f, max: %.3f\n', mean(rate) , min(rate), max(rate));

save('video_info.mat', 'filenames', 'width', 'height', 'totalDuration', 'nrFramesTotal', 'rate');

