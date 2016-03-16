figure;
imshow(I);
title(sprintf('score = %.3f', agreement_score);


addpath(genpath('lib'));

data_path = 'data';
filename = '2008_000053';

I = imread(sprintf('%s/%s.jpg', data_path, filename));
gazeInfo = ml_load(sprintf('%s/%s.mat', data_path, filename), 'fixations');
agreement_score = compute_agreement(I, gazeInfo);        

figure;
imshow(I);
title(sprintf('score = %.3f', agreement_score));

filename = '2008_001467';

I = imread(sprintf('%s/%s.jpg', data_path, filename));
gazeInfo = ml_load(sprintf('%s/%s.mat', data_path, filename), 'fixations');
agreement_score = compute_agreement(I, gazeInfo);

figure;
imshow(I);
title(sprintf('score = %.3f', agreement_score));
        