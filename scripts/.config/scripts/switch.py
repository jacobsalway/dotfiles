#!/usr/bin/python

import i3, sys

to_swap = sys.argv[1]

outputs = [output for output in i3.get_outputs() if output['active']]
workspaces = i3.get_workspaces()

for w in workspaces:
    if w['focused']:
        current = w
    if w['output'] == to_swap and w['visible']:
        swap = w

i3.workspace(current['name'])
i3.command('move', 'workspace to output ' + swap['output'])

i3.workspace(swap['name'])
i3.command('move', 'workspace to output ' + current['output'])

i3.workspace(current['name'])
