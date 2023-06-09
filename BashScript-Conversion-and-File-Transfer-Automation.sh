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


  ffmpeg -i "$file" -acodec mp3 "${file%.aac}.mp3" -y



  tar cvfz "${file%.aac}.tgz" "${file%.aac}.mp3"




done


for file in /home/mushu/Downloads/*.mp3; do
  rm "$file"
done


for file in /home/mushu/Downloads/*.tgz; do
 filename="$(basename "$file")"

 if [[ "$filename" == saad* ]]; then
    dirname="saad_s"
  elif [[ "$filename" == miran* ]]; then
    dirname="miran_s"
  elif [[ "$filename" == mushu* ]]; then
    dirname="mushu_s"
  elif [[ "$filename" == talaiva* ]]; then
    dirname="talaiva_s"
  elif [[ "$filename" == dalla* ]]; then
    dirname="dalla_s"
  elif [[ "$filename" == tauseef* ]]; then
    dirname="tauseef_s"
  fi

    dirname="/home/mushu/Downloads/$dirname"

  if [ ! -d "$dirname" ]; then

    mkdir "$dirname"
  fi

  mv "$file" "$dirname/"
done

new_dir="/home/mushu/Downloads/finaldata"

if [ ! -d "$new_dir" ]; then
mkdir -p "$new_dir"
fi

for dir in /home/mushu/Downloads/saad_s /home/mushu/Downloads/miran_s /home/mushu/Downloads/mushu_s /home/mushu/Downloads/talaiva_s /home/mushu/Downloads/dalla_s /home/mushu/Downloads/tauseef_s; do
mv "$dir" "$new_dir/"
done


for dir in /home/mushu/Downloads/finaldata/*; do
  if [ -d "$dir" ]; then
    tar -czvf "${dir}.tar.gz" "$dir"
  fi
done


aws s3 sync /home/mushu/Downloads/finaldata/  s3://maximum1


SUBJECT="the automation task is complete"
MESSAGE="the given automation task is successfully complete"
FROM="Musharraf Shaikh"
TO="affandeshmukh4@gmail.com"
SMTP="smtp.gmail.com"
USERNAME="zuberd302@gmail.com"
PASSWORD="xowramddsbvpqbxh"

ATTACHMENT="/home/mushu/Downloads/finaldata/*"


echo -e "subject: $SUBJECT\n\n\$MESSAGE" | \
echo -e "To: $TO\nFROM: $FROM\nSubject: $SUBJECT\n\n$MESSAGE" | \
ssmtp -au $USERNAME -ap $PASSWORD $TO

