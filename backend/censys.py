import json
from requests import get


def censys_ip(IP):
    try:
        dirty_response = get('https://censys.io/ipv4/%s/raw' % IP).text
        clean_response = dirty_response.replace('&#34;', '"')
        x = clean_response.split('<code class="json">')[1].split('</code>')[0]
        censys = json.loads(x)
        return censys
    except:
        return None