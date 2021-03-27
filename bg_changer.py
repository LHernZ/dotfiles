import random, os
import json
path = "bgs"


with open('settings.json', 'r') as f:
    random_filename = random.choice([
        x for x in os.listdir(path)
        if os.path.isfile(os.path.join(path, x))
    ])
    print(random_filename)
    data = json.load(f)
    t_path, f_name = str(data["profiles"]["defaults"]["backgroundImage"]).rsplit("\\",1)
    data["profiles"]["defaults"]["backgroundImage"] = t_path + "\\" + random_filename

