import requests
from bs4 import BeautifulSoup
#using neweggs listing of GPU's for super computer build
url = "https://www.newegg.com/Product/ProductList.aspx?Submit=ENE&N=100007709%204814%20601201888%20601203793%20601204369%20601296707%20601301599&IsNodeId=1&cm_sp=Cat_video-Cards_1-_-Visnav-_-Gaming-Video-Cards_2"
Egg = requests.get(url)
print(Egg.status_code)
#full HTML text from website
Egg.text
#put egg.text through beautiful soup
Egg_soup = BeautifulSoup(Egg.text, 'html.parser')
#cleans up HTML file
print(Egg_soup.prettify())
#search for tag in HTML
#print(Egg_soup.findAll('TAG HERE', {'class': 'item-title'}))
#count, should match items per page on website
count = len(Egg_soup.findAll("div", {'class': 'item-info'}))
print(count)
containers = Egg_soup.findAll('div', {'class': 'item-info'})
#set up loop
container = containers[0]

filename = "NewEggGPU.csv"
f = open(filename, "w")
headers = "brand, product_name, \n"
f.write(headers)


for container in containers:
    brand = container.div.a.img["title"]

    title_container = container.findAll("a", {"class":"item-title"})
    product_name = title_container[0].text

    #The price property below was scrambled due to the sites HTML, thus I left it out of the final pro
    #price = container.findAll("li", {"class":"price-current"})
    #product_price = price[0].text.strip()

    print("brand: " + brand)
    print("product_name: " + product_name)
    #print("product_price: " + product_price)

    f.write(brand + "," + product_name.replace(",","|") + "\n")

f.close
