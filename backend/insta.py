import requests
import json
try:
    from urllib.parse import urlparse
except ImportError:
    from urlparse import urlparse

def instgrm(usr):
    try:

        BASE_URL = 'https://www.instagram.com/'
    

        session = requests.Session()
        session.headers = {'user-agent':"user", 'Referer': BASE_URL}
        session.cookies.set('ig_pr', '1')
        req = session.get(BASE_URL)
        session.headers.update({'X-CSRFToken': req.cookies['csrftoken']})

        url = f"https://www.instagram.com/{usr}/?__a=1"
        
        response = session.get(url, cookies="", headers={'Host': urlparse(url).hostname}, stream=False, timeout=90)
        if(response.status_code==200):
            return response.json()
           

    except:
        return None


    
   

