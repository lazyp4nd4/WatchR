import requests
from bs4 import BeautifulSoup

def Facebook(username):
    search_string = "https://en-gb.facebook.com/" + username

    #response is stored after request is made
    response = requests.get(search_string)

    #Response is stored and parsed to implement beautifulsoup
    soup = BeautifulSoup(response.text, 'html.parser')

    #List that will store the data that is to be fetched

    ###Finding Name of the user
    #Min div element is found which contains all the information
    main_div = soup.div.find(id="globalContainer")
    print(main_div)
    name = main_div.find(id="fb-timeline-cover-name").get_text()
    print("\n"+"Name:"+name)
    return None