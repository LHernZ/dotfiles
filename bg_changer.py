import random, os
import json
import sys
path = "/mnt/c/Users/Apex/OneDrive/Terminal"

with open('/mnt/c/Users/Apex/AppData/Local/Packages/Microsoft.WindowsTerminalPreview_8wekyb3d8bbwe/LocalState/settings.json', 'r') as f:
    data = json.load(f)

t_path, f_name = str(data["profiles"]["defaults"]["backgroundImage"]).rsplit("\\",1)
data["profiles"]["defaults"]["backgroundImage"] = t_path + "\\" + str(sys.argv[1].rsplit('/',1)[1])

with open('/mnt/c/Users/Apex/AppData/Local/Packages/Microsoft.WindowsTerminalPreview_8wekyb3d8bbwe/LocalState/settings.json', 'w') as f:
    json.dump(data, f)
