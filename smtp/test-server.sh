#!/bin/bash

# Variables
MAILHOG_IP="192.168.1.197"
MAILHOG_PORT="30125"
FROM_EMAIL="test@example.com"
TO_EMAIL="fernandopobletearrau@gmail.com"
SUBJECT="Test Email"
BODY="This is a test email."

# Send email using telnet
{
  echo "open $MAILHOG_IP $MAILHOG_PORT"
  sleep 1
  echo "EHLO localhost"
  sleep 1
  echo "MAIL FROM:<$FROM_EMAIL>"
  sleep 1
  echo "RCPT TO:<$TO_EMAIL>"
  sleep 1
  echo "DATA"
  sleep 1
  echo "Subject: $SUBJECT"
  echo "$BODY"
  echo "."
  sleep 1
  echo "QUIT"
} | telnet