import requests

def hunterIo(first, last, domain):
    try:    
        req = requests.get("https://api.hunter.io/v2/email-finder?domain="+domain+"&first_name="+first+"&last_name="+last+"&api_key=9f189e87e011a1d2f3013ace7b14045dec60f62c")
        j=req.json()
        return j
    except:
        return None