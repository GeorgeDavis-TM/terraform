#!/usr/local/bin/python3

import re
import os

os.system('terraform graph > graph.tfstate.log')

f = open('graph.tfstate.log', 'r')
fileLines = f.readlines()
f.close()

orphansList = []

for line in fileLines:
    if "[root]" in line:
        if "(orphan)" in line:

            tempList = re.split(r"\s", line.strip())

            orphansList.append(str(tempList[tempList.index('(orphan)"')-1]))

orphansList = list(dict.fromkeys(orphansList))

f = open('orphans.tfstate.log', 'w')
for item in orphansList:
    f.write(str(item) + "\n")
f.close()

for orphan in orphansList:

    os.system('terraform state rm ' + str(orphan))