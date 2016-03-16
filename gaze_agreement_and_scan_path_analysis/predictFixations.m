% Tilke Judd
% May 2011

% This measures how well the saliencyMap of an image predicts the ground
% truth human fixations on the image.  

function [areaUnderROC, falseAlarms, precision] = predictFixations(saliencyMap, fixations)

% If there are no fixations to predict, return NaN
if ~any(fixations)
    areaUnderROC=NaN;
    falseAlarms=NaN;
    precision=NaN;
    disp('no fixations');
    return
end 

% make the saliencyMap the size of the image of fixations
% to make sure images are the same size (as when working with reduced imgs)
if size(saliencyMap, 1)~=size(fixations, 1) || size(saliencyMap, 2)~=size(fixations, 2)
    saliencyMap = imresize(saliencyMap, size(fixations));
end

S = saliencyMap(:);
F = fixations(:);

Sth = S(F>0);
Sth = sort(Sth, 'descend');
Nfixations = length(Sth);
Npixels = length(S);
precision = zeros(Nfixations+1,1);
falseAlarms = zeros(Nfixations+1, 1);
precision(1)=0;
falseAlarms(1)=0;
for i = 1:Nfixations
    aboveth = sum(S>=Sth(i));
    precision(i+1) = i / Nfixations;
    falseAlarms(i+1) = (aboveth-i) / (Npixels - Nfixations);
end
precision(end+1) = 1;
falseAlarms(end+1) = 1;
areaUnderROC = trapz(falseAlarms, precision);

showdetails = 0;
if nargout==0 || showdetails == 1
    figure(1)
    subplot(121); imagesc(saliencyMap); title('SaliencyMap with fixations to be predicted');
    hold on;
    [y, x] = find(fixations);
    plot(x, y, '.r');
    subplot(122); plot(falseAlarms, precision);   title(['Area under ROC curve: ', num2str(areaUnderROC)])
    pause;
end
