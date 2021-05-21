import json
import requests


def phoneinfo(number):
    try:    
        req = requests.get("http://apilayer.net/api/validate?access_key=a33a6594dcb72a479f4b88c3a9e8d475&number="+number)
        j=req.json()
        return j
    except:
        return None