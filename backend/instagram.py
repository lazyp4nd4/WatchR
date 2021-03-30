import requests
import json

def Instagram(username):

    try:
        print("hello")
        r = requests.get("https://www.instagram.com/"+ username +"/?__a=1", headers = {'User-agent': 'your bot 0.1'})
        print(r.status_code)
        re = r.text
        print(re)
        clean_response = re.replace('&#34;', '"')
        print(clean_response)
        x = clean_response.split('<code class="json">')[1].split('</code>')[0]
        res = json.loads(x)
        print(res)
        return res
    except:
        print("Error: Profile Not Found")
        return None