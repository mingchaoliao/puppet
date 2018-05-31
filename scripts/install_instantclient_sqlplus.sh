#!/bin/bash

rm -rf tmp/instantclient_12_2
rm -rf /usr/lib/oracle/12.1/client64
unzip tmp/instantclient-basic-linux.x64-12.2.0.1.0.zip -d tmp
unzip tmp/instantclient-sqlplus-linux.x64-12.2.0.1.0.zip -d tmp
unzip tmp/instantclient-sdk-linux.x64-12.2.0.1.0.zip -d tmp
mkdir -p /usr/lib/oracle/12.1/client64
cp -r tmp/instantclient_12_2 /usr/lib/oracle/12.1/client64/lib
ln -s /usr/lib/oracle/12.1/client64/lib/libclntsh.so.12.1 /usr/lib/oracle/12.1/client64/lib/libclntsh.so
ln -s /usr/lib/oracle/12.1/client64/lib/libocci.so.12.1 /usr/lib/oracle/12.1/client64/lib/libocci.so
ln -s /usr/lib/oracle/12.1/client64/lib/libclntshcore.so.12.1 /usr/lib/oracle/12.1/client64/lib/libclntshcore.so