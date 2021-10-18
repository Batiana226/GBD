#! /bin/bash
gcc -c -DSMTP_OPENSSL example_simple.c -I/home/pi/Documents/smtp/smtp-client/src
gcc -o example_simple example_simple.o /home/pi/Documents/smtp/smtp-client/build/release/smtp.o -lssl -lcrypto

