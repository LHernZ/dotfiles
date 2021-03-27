import random, os
import json
path = "bgs"

random_filename = random.choice([
    x for x in os.listdir(path)
    if os.path.isfile(os.path.join(path, x))
])

with open('settings.json', 'r') as f:
    data = json.load(f)

t_path, f_name = str(data["profiles"]["defaults"]["backgroundImage"]).rsplit("\\",1)
data["profiles"]["defaults"]["backgroundImage"] = t_path + "\\" + random_filename

with open('settings.json', 'w') as f:
    json.dump(data, f)
