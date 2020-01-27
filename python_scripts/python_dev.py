#!/usr/bin/python

import sys, os

def main():
  os.system("echo Hello!")
  exec_os_cmd("echo Hello!!")

def exec_os_cmd(command):
  exit_value = os.system( command )
  if exit_value != 0:
  	raise Exception( "Error! The command [" + command + "] exited with error code " + repr(exit_value) )

### Invoke main
main()