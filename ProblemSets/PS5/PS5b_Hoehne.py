"""
virtualenv -p python 3 "folder_name" && cd "folder_name"
source bin/activate
python --version
pip install requests bs4
pip install python-twitter
"""
import twitter

consumer_key= '4pTMlfX5q9KOKbWh7i0W47be8'
consumer_secret = '4MvFAJIztonzmTljquXAmxF3uUJ42SeKK1mhCc89bFynwf5NQb'
access_token = '934521371656417280-qAdxEbVfRw6NZEfZhEhQpneyjiw8xfz'
access_secret = 'dGwIIwbgKIqKexrRnZC9WElwzlCDabVmGUfnCHI893ywS'

api = twitter.Api(consumer_key=consumer_key,
    consumer_secret = consumer_secret,
    access_token_key= access_token,
    access_token_secret=access_secret)

print(api.VerifyCredentials())

#get users and followers of user account
followers = api.GetFollowers()
#friends = api.GetFriends()

#tweeting to my professor
#post_update = api.PostUpdates(status='@tyleransom tweet sent from python #Econ5970')
#print(post_update)

filename = "Followers.csv"
f = open(filename, "w")
headers = "User_Screen_Name, \n"
f.write(headers)

#pull all followers User Names
for u in followers:
    print(u.screen_name)

    f.write(u.screen_name + "\n")

f.close
