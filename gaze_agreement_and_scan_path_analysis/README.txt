% Author: Kiwon Yun
% Email: kyun@cs.stonybrook.edu
% Created: Mar 15, 2016
% Modified: Mar 15, 2016

################################################################
Introduction
################################################################
In general, measuring the similarity of scan paths are summarized well in the following paper.
- [1] O. Le Meur and T. Baccino, “Methods for comparing scanpaths and saliency maps: strengths and weaknesses,” Behavior Research Methods, 2012
- Link: https://hal.inria.fr/hal-00757615/document

################################################################
Fixation Agreement
################################################################

1) AUC analysis = ROC metric
Use 'predictFixations.m'

ROC metric is also one of the most popular methods. It is often used to compute inter-subject agreement (similarity between multiple subjects). 

You can check Section 3.1 and 3.4 of [1]. Also, please have a look 'Agreement among observers' section in the 7th page of the following paper. 
http://cvcl.mit.edu/Papers/EhingerHidalgoTorralbaOliva_VisCog2009.pdf

NOTE: ROC does not consider the temporal information. it considers only spatial pattern of fixations. 
However, you may able to consider the duration of fixations when you generate saliency map from fixations.

2) Entropy
It measures the “focus”; i.e., is the user focused on a small part of the page or is the focus more distributed?
'Entropy' is often used for. More detail can be found as the following paper.
http://people.csail.mit.edu/tjudd/WherePeopleLook/index.html

step 1: generate fixation density map (gray scale image).
step 2: you may resize the extracted fdm. For example, Judd et al. resized the image 200x200 (http://people.csail.mit.edu/tjudd/WherePeopleLook/index.html).)
step 3: put into matlab built-in function for computing entropy. 

E = entropy(I) - reference: http://www.mathworks.com/help/images/ref/entropy.html

################################################################
Scan Path Analysis
################################################################



2) Measure the similarity between two sets of gaze points
A) If you have different predefined sections (ROIs), you may consider string-edit metric (Section 2.1 of [1]). 

B) To consider the duration of fixations, you may consider vector-based metric (Section 2.3 of [1]). It first aligns two scan paths, then compare them. More detail can be found in the following paper.
 
Jarodzka, H., Holmqvist, K., & Nystr, M. (2010). A vector-based, multidimensional scanpath similarity measure. In Proceedings of the Symposium on Eye-Tracking Research Applications, pp.211-218, Austin, Texas
- Link: http://lup.lub.lu.se/luur/download?func=downloadFile&recordOId=1539209&fileOId=1539210
