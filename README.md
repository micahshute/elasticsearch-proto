`touch medium_data.txt`

Top line of medium_data.txt: `Tag,Title,Text`

`ruby scraper.rb`

`docker run --name article-db -v $pwd/db:/data/db -p 27017:27017 -d mongo`

`ruby mongo_client.rb`

`docker run --name search -d -p 9200:9200 -p 9300:9300 -e "discovery.type=single-node" elasticsearch:7.9.3`

Mongo Connector only works with elasticsearch <= 5 -- the below DOES NOT work with ES 7.9.3

`pip3 install mongo-connector`
`pip3 install 'mongo-connector[elastic2]'`

`python3 mongo_connector.py -m localhost:27217 -t http://localhost:9200`

`mongo-connector -m localhost:27017 -t localhost:9200 -d elastic_doc_manager`