#!/bin/bash

OS=$(uname -s)

if [ "$OS" = "Linux" ]; then
  if [ -f /etc/lsb-release ]; then

    if ! which ffmpeg 2>/dev/null; then
      sudo apt-get install -y ffmpeg
    else
      echo "ffmpeg is already installed."
    fi
  elif [ -f /etc/redhat-release ]; then


    if ! rpm -q ffmpeg 2>/dev/null; then
      sudo yum install -y ffmpeg
    else
      echo "ffmpeg is already installed."
    fi
  else
    echo "Unsupported Linux distribution. Please install ffmpeg manually."
  fi
elif [ "$OS" = "Darwin" ]; then


  if ! which ffmpeg 2>/dev/null; then
    brew install ffmpeg
  else
    echo "ffmpeg is already installed."
  fi
elif [ "$OS" = "Windows_NT" ]; then


  echo "Please install ffmpeg on Windows manually."
else
  echo "Unsupported operating system. Please install ffmpeg manually."
fi

for file in /home/mushu/Downloads/*.aac; do


  ffmpeg -i "$file" -acodec mp3 "${file%.aac}.mp3"


  tar cvfz "${file%.aac}.tgz" "${file%.aac}.mp3"



  aws s3 cp "${file%.aac}.tgz" s3://maximum1

  sleep 3
done

SUBJECT="the automation task is complete"
MESSAGE="the given automation task is successfully complete"
FROM="Musharraf Shaikh"
TO="affandeshmukh4@gmail.com"
SMTP="smtp.gmail.com"
USERNAME="zuberd302@gmail.com"
PASSWORD="xowramddsbvpqbxh"

echo -e "subject: $SUBJECT\n\n\$MESSAGE" | \
echo -e "To: $TO\nFROM: $FROM\nSubject: $SUBJECT\n\n$MESSAGE" | \
ssmtp -au $USERNAME -ap $PASSWORD $TO
