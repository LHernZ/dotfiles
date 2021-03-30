import random, os
import json
import sys
path = "/mnt/c/Users/luisf/OneDrive/Terminal"

random_filename = random.choice([
    x for x in os.listdir(path)
    if os.path.isfile(os.path.join(path, x))
])

with open('/mnt/c/Users/luisf/AppData/Local/Packages/Microsoft.WindowsTerminal_8wekyb3d8bbwe/LocalState/settings.json', 'r') as f:
    data = json.load(f)

t_path, f_name = str(data["profiles"]["defaults"]["backgroundImage"]).rsplit("\\",1)
data["profiles"]["defaults"]["backgroundImage"] = t_path + "\\" + str(sys.argv[1])

with open('settings.json', 'w') as f:
    json.dump(data, f)
