# Author: Kiwon Yun
# Email: kyun@cs.stonybrook.edu
# Created: Oct 4, 2013
# Modified: Mar 16, 2016

#!/bin/bash

for files in ./data/original/*.mp4
do
    full_filename=$(basename "$files")
    filename=${full_filename%.*}
	echo $full_filename;
	echo $filename;

	mkdir ./data/temp;
	mkdir ./data/output;
	
	# the resolution depends on the average resolution of all the videos in your dataset
	width=640;
	height=480;
	
	cd data;
	
	# resize videos and add padding
	ffmpeg -i ./original/$full_filename -y -an -c:v libx264 -crf 18 -filter:v "scale=iw*min($width/iw\,$height/ih):ih*min($width/iw\,$height/ih), pad=$width:$height:($width-iw*min($width/iw\,$height/ih))/2:($height-ih*min($width/iw\,$height/ih))/2:white" ./temp/$filename.avi;
	
	# solve codec problem 
	ffmpeg -i ./temp/$filename.avi -y -c:v mpeg4 -vtag xvid -q:v 1 ./output/$filename.avi;

	rm -rf ./temp;
	cd ..
done
