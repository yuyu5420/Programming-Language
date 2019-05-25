import urllib.request
import re
from matplotlib import pyplot as plt
from matplotlib.ticker import MaxNLocator

author = input("Input Author:")
print("Please wait the result ...\n")
Records = {"years:": 0} # create a dictionary to store years records
next_page = 0
n = 0
while next_page != None:
    url = "https://arxiv.org/search/?query=" + author + "&searchtype=author&size=200&start=" + str(n)
    content = urllib.request.urlopen(url)
    html_str = content.read().decode('utf-8')
    pattern = 'originally announced</span>[\s\S]*?</p>'
    pattern_author = 'Authors:</span>[\s\S]*?</p>'
    result = re.findall(pattern, html_str)
    result_author = re.findall(pattern_author, html_str)
    next_page = re.search('pagination-next', html_str)# check next page if exists
    if next_page != None:# go to next page
        n += 200
    for i in range(len(result)):
        author_exist = re.search(author.replace("+", " "), result_author[i])# check author name if exists
        if author_exist != None:
            time = result[i].split("originally announced</span>")[1].split("</p>")[0].strip()
            pattern = '[0-9]+'
            time = re.findall(pattern, time)# get the year number
            if time[0] in Records:# have exist in dict
                Records[time[0]] += 1
            else:
                Records[time[0]] = 1 
            
ax = plt.figure().gca()
ax.yaxis.set_major_locator(MaxNLocator(integer=True))
plt.xlabel('year')
plt.ylabel('times')
plt.title('Author: '+ author.replace("+", " "))
years = sorted(Records)# sort the years
for year in years:
    if Records[year] != 0:
        # print(year + ": " + str(Records[year]) + " times")
        plt.bar(year, Records[year], facecolor = 'orange')
plt.show()