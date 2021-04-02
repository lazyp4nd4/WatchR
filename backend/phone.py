import json
import requests


def phoneinfo(number):
    try:    
        req = requests.get("https://demo.phoneinfoga.crvx.fr/api/numbers/"+number+"/scan/numverify")
        j=req.json()
        return j
    except:
        return None