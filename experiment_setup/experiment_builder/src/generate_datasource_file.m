function generate_datasource_file

    load('video_info.mat');
    
    fout = fopen('../data/output/datasource.dat', 'w');
    fprintf(fout, '$filename\t$width\t$height\t$n_frames\t$frame_rate\t$duration\n');
    
    files = dir('../data/output/*.mp4');
    for f=1:length(files)
        filename = files(f).name;
        
        idx = ismember(filenames, filename);
        
        v_width = width(idx);
        v_height = height(idx);
        n_frames = nrFramesTotal(idx);
        f_rate = rate(idx);
        t_duration = totalDuration(idx);

        fprintf(fout, sprintf('%sX.avi\t%d\t%d\t%d\t%.2f\t%.2f\n', filename(1:end-4), v_width, v_height, n_frames, f_rate, t_duration));
    end
    
    fclose(fout);
end