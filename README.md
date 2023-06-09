Bash Script - Audio Conversion and File Transfer Automation

Prerequisites:
- FFmpeg: Install FFmpeg on your system before running the script.

Usage:

1. Clone the repository:
   git clone https://github.com/your-username/your-repository.git

2. Move into the project directory:
   cd your-repository

3. Update the script:
   - Open the 'audio_conversion_automation.sh' file in a text editor.
   - Provide appropriate values for the variables 'FROM', 'TO', 'SMTP', 'USERNAME', 'PASSWORD' for email notification setup.
   - Update the 'ATTACHMENT' variable with the correct path to the files to be attached in the email.

4. Make the script executable:
   chmod +x audio_conversion_automation.sh

5. Run the script:
   ./audio_conversion_automation.sh

   The script will perform the following actions:
   - Check the operating system and install FFmpeg if not already installed.
   - Convert AAC files to MP3 format and create tar.gz archives.
   - Organize the files into directories based on their names.
   - Transfer the files to an AWS S3 bucket.
   - Send an email notification with the attached files.

6. Monitor the script execution for any errors or messages.

Notes:
- Ensure that you have the necessary permissions and credentials set up.

Backup & compression automation 
So basically this is made for those people who want to save there time & energy
this script automates the conversion of audio files from .aac to .mp3, the creation of compressed .tgz files and the organization of these files into specific directories.
It also notify you by sending a mail upon the completion of the task
 
Installation of ffmpeg 
 In the installation the script first checks the type of operating system and installs the ffmpeg accordingly.
Ffmpeg is used to convert the media file format eg. if the file is aac. And you want it in mp3 it will be done by it 
Compression into tar.gz

File takes too much space for getting it low on space we have to compress it .

After converting the acc file into mp3 it will compress the mp3 file into tar.gz and will delete the mp3 file for more space after all the motive is to getting a backup file with less size.

Organization of .tgz  files 

After the compression of the files , the files will sorted by their names and they will saved in the respective directory
 
And then the directories will be compress and will be uploaded in the s3 bucket
 
Completion of Email
Using smtp system will send mail  
After all this process the user will get a notification through an Email mention which files are uploaded 
