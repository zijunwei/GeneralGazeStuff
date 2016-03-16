function [sigma, pixel] = get_fdm_sigma(visual_angle, varargin)

    ratio = set_options(varargin, 'ratio', [1 1]);

    screen_width = 1024;
    screen_height = 768;
    
    screen_width_mm = 360;
    screen_height_mm = 270;
    
    distance_to_subject = 700;
    
    w_pixel = tan(deg2rad(visual_angle/2))*2*distance_to_subject*screen_width/screen_width_mm;
    h_pixel = tan(deg2rad(visual_angle/2))*2*distance_to_subject*screen_height/screen_height_mm;
    
    pixel = h_pixel * ratio(1);
    
    % 1 degree of angle -> ~0.5 sigma
    sigma = pixel / 34.7523 / 1.9;
end


