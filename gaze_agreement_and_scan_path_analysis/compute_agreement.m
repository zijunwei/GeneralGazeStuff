% Author: Kiwon Yun (kyun@cs.stonybrook.edu)
% Created: Mar 15, 2016
% Modified: Mar 15, 2016
%
% compute_agreement(inputImg, gazeInfo, varargin) compute AUC value = ROC
% metric. It is often used to compute inter-subject agreement (similarity between multiple subjects). 
% Please have a look 'Agreement among observers' section in the 7th page of the following paper. 
% http://cvcl.mit.edu/Papers/EhingerHidalgoTorralbaOliva_VisCog2009.pdf
% NOTE: ROC does not consider the temporal information. It considers only spatial pattern of fixations. 
% However, you may able to consider the duration of fixations when you generate saliency map from fixations.

function score = compute_agreement(inputImg, gazeInfo)

    n_subjects = length(gazeInfo.subject_ids);
    for subject_id=1:n_subjects
        cur_subject_id = subject_id;

        %% compute fdm using all the fixations except for the fixations from the current subject
        fdm = cell(1, n_subjects-1);
        s = 1;
        for target_subject_id=1:n_subjects
            if target_subject_id == cur_subject_id
                continue;
            end

            cur_gazeInfo.fixation = gazeInfo.fixation(target_subject_id);
            fdm{s} = computeFDM(inputImg, cur_gazeInfo);
            
            s = s + 1;
        end

        %% average fdm (=accumulated fdm)
        avg_fdm = zeros(size(fdm{1}));
        for j=1:length(fdm)
            avg_fdm = avg_fdm + fdm{j};
        end
        avg_fdm = avg_fdm ./ max(avg_fdm(:));

        %% consider the fixations for the current subject
        cur_gazeInfo.fixation = deal(gazeInfo.fixation(cur_subject_id));
        
        fdm = zeros(size(fdm{1}));
        n_fixations = length(cur_gazeInfo.fixation{1}.fix_X);
        for i=1:n_fixations
            f.x = round(cur_gazeInfo.fixation{1}.fix_X(i));
            f.y = round(cur_gazeInfo.fixation{1}.fix_Y(i));

            fdm(f.y,f.x) = 1;
        end

        [areaUnderROC, ~, ~] = predictFixations(avg_fdm, fdm);

        agreement_score(cur_subject_id) = areaUnderROC;
    end

    score = mean(agreement_score); 
end