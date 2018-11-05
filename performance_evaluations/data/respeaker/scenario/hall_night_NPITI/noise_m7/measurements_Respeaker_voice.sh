#!/bin/bash

clear
echo -e "\nScript Record Respeaker\n================================\n\n"
read -p "Name of the recording file (without extension): " nfile
read -p "Duration (seconds): " duration

echo -e "\n\n**     CHANGE THE OUTPUT AUDIO TO RESPEAKER      **\n"
amixer cset numid=3 1 #Change the output audio to Respeaker
arecord -Dac108 -f S32_LE -r 48000 -c 4 -d $duration  $nfile.wav #Record audio
#With duration of the audio

echo -e "\n The file $nfile was created"

echo -e "\n\n**     CHANGE THE OUTPUT AUDIO TO HDMI      **\n"
amixer cset numid=3 2  #Change the output audio to HDMI

#install
sudo apt-get install sox #install sox

echo -e "\nSlipt channels...\n\n"
#Split the recorded audio to 4 different audios with each 4 different channels 

sox $nfile.wav channel1_$nfile.wav remix 1
sox $nfile.wav channel2_$nfile.wav remix 2
sox $nfile.wav channel3_$nfile.wav remix 3
sox $nfile.wav channel4_$nfile.wav remix 4


echo -e "\nConverting files .wav to .dat ...\n\n"
#converting .wav to .dat
sox channel1_$nfile.wav channel1_$nfile.dat
sox channel2_$nfile.wav channel2_$nfile.dat
sox channel3_$nfile.wav channel3_$nfile.dat
sox channel4_$nfile.wav channel4_$nfile.dat

#create a audio information file

echo -e "Creating information file ...\n\n" >> audioinfo_$nfile.txt
echo -e "\n Audio Info $nfile \n================================\n\n" >> audioinfo_$nfile.txt
soxi $nfile.wav >> audioinfo_$nfile.txt
echo -e "\n\nDetail audio information: \n\n" >> audioinfo_$nfile.txt
sox $nfile.wav -n stat >> audioinfo_$nfile.txt

