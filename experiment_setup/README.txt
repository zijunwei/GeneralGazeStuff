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
Step-by-step for the data extraction after the experiments
################################################################

	1. Copy excel file to your local machine
	2. Run 'xxxxx' script
	3. Run 'xxxxx.m'

################################################################
Step-by-step for IMAGE dataset
################################################################

	1. Prepare the list of images you need for the experiment
	2. Create a folder in builder
	3. Copy 'xxxxx' to 'xxxxx'
	4. Modify 'xxxxx'

################################################################
Step-by-step for VIDEO dataset
################################################################

	* Prepare the list of videos, and the the required file for experiment builder
	
	1. add the original videos into 'data/original'
	2. run 'experiment_builder/start_resize_and_encode_xvid.sh' (It resizes the videos and solves codec problem. You can edit this file if it needs)
	3. run 'experiment_builder/src/generate_video_info_file.m'
	3. run 'experiment_builder/src/generate_datasource_file.m'
	4. copy 'experiment_builder/data/output' to the eye tracking machine (C:\Users\EyeLink\Desktop\kiwon\datasets\{project_name}). It contains the videos and the data source file (*.dat) you will use in experiment builder. 
	
	* Create a project using experiment builder, and generate a executable experiment file.

	1. create a folder (C:\Users\EyeLink\Desktop\kiwon\builder\{project_name}\original])
	2. open 'Split AVI'
	3. change the setting (View -> Options)
		Output Folder: C:\Users\EyeLink\Desktop\kiwon\builder\{project_name}\ 
		Video Codec: Cinapak Codec by Radius
		uncheck Save audio output stream
	4. click 'Start Compression'
	
	# more editing will come soon by kiwon
	5. open a builder file in 'C:\Users\EyeLink\Desktop\kiwon\experiments\msr_video_description', and duplicate it with the project name like 'C:\Users\EyeLink\Desktop\kiwon\experiments\{project_name}'
	6. open library manager
	7. delete the previous files, and add new video files to the library manager
	8. click Trial -> Data Source, delete all columns, and import the experiment builder file in '/Desktop/Kiwon/YouTube_descriptions/datasets' 
	9. Click 'randomization setting', check 'enable trial randomization'
	10. Click Trial -> Recording -> Display Screen -> Add video -> align center, the name should be VIDEO_RESOURCE
	11. Check all errors in conditional, timer, start, etc
	12. check the duration of timer (should be maximum duration of the entire dataset)

