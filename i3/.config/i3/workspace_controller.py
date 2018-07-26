#!/usr/bin/python3
import subprocess
import sys
import json
import math
import os

def get_workspace():
  handle = subprocess.Popen(["i3-msg","-t","get_workspaces"], stdout=subprocess.PIPE)
  output = handle.communicate()[0]
  data = json.loads(output.decode())
  data = sorted(data, key=lambda k: k['name'])
  for i in data:
    if(i['focused']):
      return i['name']

def move_to(num):
  subprocess.Popen(["i3-msg","move container to workspace "+str(num)], stdout=subprocess.PIPE)

def go_to(num):
  subprocess.Popen(["i3-msg","workspace "+str(num)], stdout=subprocess.PIPE)

if len(sys.argv) < 1:
  print("Error not enough arguements")
else:
  command = sys.argv[1]
  switch_number = 1 #default switch number
  if len(sys.argv) == 3:
    # they passed in a number to move to
    try:
      switch_number = int(sys.argv[2])
    except ValueError:
      pass
  # get the workspace number
  workspace_name = get_workspace()
  workspace_val = 1 # default value if name parseing fails
  workspace_prefix = ''
  try:
    match_set = '0123456789-'
    # only look for digits in the number
    workspace_val = int(''.join(filter(lambda x: x in match_set, workspace_name)))
    # include - in the ignore list incase it is a negative number
    workspace_prefix = ''.join(filter(lambda x: x not in match_set, workspace_name));
  except ValueError:
    pass
  # handle the commands
  if command == 'up':
    workspace_val += 3
  elif command == 'down':
    workspace_val -= 3
  elif command == 'next':
    workspace_val += 1
  elif command == 'prev':
    workspace_val -= 1
  elif command == 'go':
    # go to workspace in block
    workspace_rounded = max(math.ceil((workspace_val/3)-1),0)*3
    workspace_rounded += switch_number
    go_to(workspace_prefix + str(workspace_rounded))
  elif command == 'move':
    # move the current container to the selected workspace
    workspace_rounded = max(math.ceil((workspace_val/3)-1),0)*3
    workspace_rounded += switch_number
    move_to(workspace_prefix + str(workspace_rounded))
    # move foucs to workspace where window was moved
    go_to(workspace_prefix + str(workspace_rounded))

  if len(sys.argv) == 3:
    # not a go or move, command2 is argv2
    command2 = sys.argv[2]
    if command == 'up' or command == 'down' or command == 'prev' or command == 'next':
      if command2 == 'go':
        go_to(workspace_prefix + str(workspace_val))
      elif command2 == 'move':
        move_to(workspace_prefix + str(workspace_val))
        # move focus to workspace where window was moved
        go_to(workspace_prefix + str(workspace_val))
