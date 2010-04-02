#!/bin/bash -x
#
# Utility to help set up new production server access
# To be run from weg01.wm.orbitz.com and assumes the .ssh/id_dsa.pub exists
# Run this before running this setup script
# ssh-keygen -t dsa
# Creates public key in ~rsarma/.ssh/id_dsa.pub, 
#         private key in ~rsarma/.ssh/id_dsa
# Copy public key to ./ssh/authorized_keys2 on SERVER
#


# run on local machine first
# :ssh-keygen -t dsa

#for SERVER in `echo wmwl{0,1,2,3,4,5}{1,2,3,4,5,6,7,8,9,0}pp`
for SERVER in `echo nkrimm@viewpoints.dev`
do
  # Server being setup
  echo ${SERVER}

  # Create the .ssh directory on the remote server
  ssh -2 ${SERVER} mkdir .ssh

  # Copy the identity.pub for ssh agent access
  scp ~/.ssh/id_dsa.pub ${SERVER}:.ssh/authorized_keys2

  # Copy the .inputrc for command line vi-mode editing
  #scp .inputrc ${SERVER}:

  # Copy the .bash_profile for the proper command prompt, etc.
  #scp ~/.bash_profile ${SERVER}:
#  scp ~/.bashrc ${SERVER}:
#
  #ssh -2 ${SERVER} mkdir bin
  #scp -r ${HOME}/bin ${SERVER}:
#
  #scp ${HOME}/.vimrc ${SERVER}:

done;
