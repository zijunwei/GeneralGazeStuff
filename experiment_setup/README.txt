Author: Kiwon Yun
Email: kyun@cs.stonybrook.edu
Created: Mar 16, 2016
Modified: Mar 16, 2016

################################################################
Introduction
################################################################

We usually use a tower mount eye tracker located at Psy A202. The room is shared with Greg's students, so if you have a scheduled subject, then it should be share via google calendar.
Please first read all the documents in 'docs' folder

################################################################
Eye tracking machine (Psy A202)
################################################################

1. Structure of the folders in the eye tracking machine (C:\Users\??\Desktop\Kiwon)
- builder: contains the package of experiment builder files for each experiment
- datasets: contains the videos or images for each experiment
- docs: contains documents of DataViewer, Experiment Builder and EyeLink
- experiments: contains the compiled version (executable version) of the experiments. This folder will be used for the actual experiments.
- result: contains the results after the experiments.
- backup: some backup files (e.g. recovered data from main server)

2. Software
- Experiment Builder from SR Research (http://www.sr-research.com/eb.html): allows you to create an experiment
- DataViewer: allows you to view the results, export law eye data to excel, etc.
- Split AVI: allows you to solve codec problem


################################################################
Step-by-step for VIDEO dataset
################################################################

	A) Prepare the list of videos, and the the required file for experiment builder
	
	1. add the original videos into 'data/original'
	2. run 'experiment_builder/start_resize_and_encode_xvid.sh' (It resizes the videos and solves codec problem. You can edit this file if it needs)
	3. run 'experiment_builder/src/generate_video_info_file.m'
	3. run 'experiment_builder/src/generate_datasource_file.m'
	4. copy 'experiment_builder/data/output' to the eye tracking machine (C:\Users\EyeLink\Desktop\kiwon\datasets\{project_name}). It contains the videos and the data source file (*.dat) you will use in experiment builder. 
	
	NOTE: '-' character is not supported. convert '-' into '_' for the file name
	
	B) Compress the videos with codec supported by eye tracker
	
	1. create a folder (C:\Users\EyeLink\Desktop\kiwon\datasets\{project_name}\original])
	2. open 'Split AVI'
	3. change the setting (View -> Options)
		Output Folder: C:\Users\EyeLink\Desktop\kiwon\datasets\{project_name}\ 
		Video Codec: Cinapak Codec by Radius
		uncheck Save audio output stream
	4. insert video files (File -> Add)
	5. click 'Start Compression'
	
	C) Create a project using experiment builder, and generate a executable experiment file.

	1. open a builder file in 'C:\Users\EyeLink\Desktop\kiwon\builder\video_demo', and duplicate it with the project name like 'C:\Users\EyeLink\Desktop\kiwon\builder\{project_name}'
	2. open 'library manager'
	3. click 'Video' tab
	3. delete all the previous videos (*.avi) in the list
	4. add the videos from the output of B).
	5. click Trial -> Data Source, delete all columns
	6. click 'Import Data', and import the data using the experiment builder file (*.dat) in 'C:\Users\EyeLink\Desktop\kiwon\datasets\{project_name}\original' 
	7. click 'randomization setting', check 'enable trial randomization'
	8. check whether 'Iteration Count' is same as the number of videos
	
	NOTE: if you want to split the data into multiple trials, then change the numbers 'Split By'. Each number indicates the number of videos in each trial.
		  Also, change 'Iteration Count' in 'BLOCK' as total # of splits
	
	9. check 'TRIAL -> Conditional -> Attribute of Trial.iteration -> Value' equals to total # of videos
	10. check if an error occurs in 'conditional', 'timer', 'start', etc
	11. check the duration of timer (should be maximum duration of the entire dataset)
	
	NOTE: For the more complex scenario of your experiment, see a good example, 'C:\Users\EyeLink\Desktop\kiwon\builder\msr_video_description'

	D) Build the experiment
	
	1. plug in the cable between server and client
	2. turn on the server of the eye tacker
	3. click 'Test Run'
	4. click 'Deploy'
	5. select directory as 'C:\Users\EyeLink\Desktop\kiwon\experiments'
	6. execute *.exe in 'C:\Users\EyeLink\Desktop\kiwon\experiments\{project_name}'
	
	
################################################################
Step-by-step for IMAGE dataset
################################################################

	1. prepare the list of images you need for the experiment (resize the images if it needs)
	2. generate datasource_file (*.dat) containing [filename, image_width, image_height, center_width]
	3. do similar process as C) and D) for video dataset
	
	NOTE: Start from 'C:\Users\EyeLink\Desktop\kiwon\builder\image_demo'
		  For the more complex scenario of your experiment, see a good example, 'C:\Users\EyeLink\Desktop\kiwon\builder\fashion_expert_1st' and 'fashion_expert_2nd'
		  
		  
################################################################
Step-by-step for the data extraction after the experiments
################################################################

	A) export excel reports from raw data
	
	1. open 'C:\Users\EyeLink\Desktop\kiwon\experiments\{project_name}\results\{subject_name}'
	2. open *.edf using DataViewer
	3. check eye movements for each trial. you are also able to see the eye movements as a video (View Trial Play Back Animation).
	4. 'Analysis -> Reports -> Fixation Report'
	5. click 'Import Variable Selection', and load variables using 'C:\Users\EyeLink\Desktop\kiwon\docs\reports\fixation_report_video.props'
	6. click 'next', and select ouptut directory in 'C:\Users\EyeLink\Desktop\kiwon\result\{project_name}'
	7. repeat 4-6 for 'Sample Report' and 'Message Report'
	
	# the following will be updated later
	
	B) generate mat files from excel reports
	
	1. Copy excel file to your local machine
	2. Run 'xxxxx' script
	3. Run 'xxxxx.m'
