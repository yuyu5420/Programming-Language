import urllib.request
import re

author = input("Input Author:")
print("Please wait the result ...\n")
Records = {author.replace("+", " "): 0} # create a dictionary to store co-authors records
next_page = 0
n = 0
while next_page != None:
    url = "https://arxiv.org/search/?query=" + author + "&searchtype=author&size=200&start=" + str(n)
    content = urllib.request.urlopen(url)
    html_str = content.read().decode('utf-8')
    pattern = 'Authors:</span>[\s\S]*?</p>'
    result = re.findall(pattern, html_str)
    next_page = re.search('pagination-next', html_str)# check next page if exists
    if next_page != None:# go to next page
        n += 200
    for r in result:
        author_exist = re.search(author.replace("+", " "), r)# check author name if exists
        if author_exist != None:
            co_authors = r.strip()
            pattern = '\">[\s\S]*?</a>'
            co_authors = re.findall(pattern, co_authors)# get the co_authors
            for a in co_authors:
                co_author = a.split("\">")[1].split("</a>")[0].strip()
                if co_author in Records:# have exist in dict
                    Records[co_author] += 1
                else:
                    Records[co_author] = 1     
                
names = sorted(Records)# sort the author names
for name in names:
    if name != author.replace("+", " "):
        print(name + ": " + str(Records[name]) + " times")