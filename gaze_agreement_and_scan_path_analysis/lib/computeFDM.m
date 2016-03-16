function fdm = computeFDM(inputImg, gazeInfo, varargin)

opts.visualangle=3.0;
opts.useWeights=false;
opts=vl_argparse(opts,varargin);
im_size=size(inputImg);
[sigma,~]=get_fdm_sigma(opts.visualangle);

%get all fixation positions:
[fix_x,fix_y,fix_weights]=deal(cell(1,length(gazeInfo.fixation)));
for i=1:1:length(gazeInfo.fixation)
    fix_x{i}=gazeInfo.fixation{i}.fix_X;
    fix_y{i}=gazeInfo.fixation{i}.fix_Y;
    
    if opts.useWeights
        fix_weights{i}=gazeInfo.fixation{i}.duration*1/sum(gazeInfo.fixation{i}.duration);
    else
        fix_weights{i}=ones(1,length(gazeInfo.fixation{i}.duration));   
    end
    
end


fix_weights=cat(2,fix_weights{:});
fix=[cat(2,fix_x{:});cat(2,fix_y{:})];


fdm = zeros(im_size(1), im_size(2));

covariance = [sigma^2*im_size(1) 0; 0 sigma^2*im_size(1)];

[X1,X2] = meshgrid(1:im_size(2), 1:im_size(1));
X = [X1(:) X2(:)];
for N=1:size(fix,2)
    Y = mvnpdf(X, fix(:,N)', covariance);
    Y = (reshape(Y, im_size(1), im_size(2)));
    fdm = fdm + Y*fix_weights(N);
end

fdm = fdm / max(fdm(:));


end