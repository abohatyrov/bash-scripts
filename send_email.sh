#!/bin/bash

read -p "Enter your email : " SENDER
read -p "Enter recipient email : " RECIEVER
read -s -p "Enter your Google App Password: " GAPP
echo ""
read -p "Enter subject: " SUBJECT

echo "Enter the body of mail: "
cat > tempfile.txt
BODY=$(cat tempfile.txt)

rm tempfile.txt

if [ -z "$1" ]; then 

  curl -s --url 'smtps://smtp.gmail.com:465' --ssl-reqd \
    --mail-from $SENDER \
    --mail-rcpt $RECIEVER\
    --user $SENDER:$GAPP \
    -T <(echo -e "From: ${SENDER}
To: ${RECIEVER}
Subject:${SUBJECT}

 ${BODY=$(cat tempfile.txt)
}")
else
  file="$1"
    
  MIMEType=`file --mime-type "$file" | sed 's/.*: //'`
  curl -s --url 'smtps://smtp.gmail.com:465' --ssl-reqd \
    --mail-from $SENDER \
    --mail-rcpt $RECIEVER\
    --user $SENDER:$GAPP \
     -H "Subject: $sub" -H "From: $SENDER" -H "To: $RECIEVER" -F \
    '=(;type=multipart/mixed' -F "=$BODY;type=text/plain" -F \
      "file=@$file;type=$MIMEType;encoder=base64" -F '=)'   
fi
