import requests
BASE = "http://192.168.1.3:5000/"

response = requests.get(BASE + "/59.89.84.167")

print(response.json())