from bs4 import BeautifulSoup
import json

htmlfile =  open('pmi-glossary.html', 'r', encoding='utf-8')
soup = BeautifulSoup(htmlfile, 'lxml')
htmlfile.close()
terms = [term.text.strip() for term in soup.find_all('dt')]
definitions = [term.p.text.replace('\t', '') for term in soup.find_all('dd')]
definitions = [term.replace('\n', ' ') for term in definitions]
items = {k:v for k,v in zip(terms, definitions)}
with open('glossary.txt', 'w') as txtfile:
	for term, exp in zip(terms, definitions):
		txtfile.write(f'{term} - {exp}')
		txtfile.write('\n')
with open('glossary.json', 'w', encoding='utf-8') as jsonfile:
	json.dump(items, jsonfile, indent=2, ensure_ascii=False)
