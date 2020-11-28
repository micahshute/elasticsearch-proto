require 'mongo'
require 'pry'

class MongoClient


    def initialize(db: )
        @client = Mongo::Client.new(['127.0.0.1:27017'], database: db)

    end

    def clear
        @client[:posts].drop
    end

    def import_csv(file)
        collection = @client[:posts]
        headers = nil
        docs = []
        File.open(file).each_line.with_index do |line, i|
            if i == 0
                headers = line.split(',').map(&:strip).map(&:to_sym)
            else
                data = line.split(',')
                doc = {}
                doc[:_id] = i
                data.each.with_index do |el, j|
                    doc[headers[j]] = el
                end
                docs << doc
            end
        end
        result = collection.insert_many(docs)
        result.inserted_count
    end

    def read_data
        @client[:posts].find({})
    end
    
end

mc = MongoClient.new(db: 'articles')
# mc.clear
# puts mc.import_csv('./medium_data.txt')
data = mc.read_data


binding.pry