require 'mongo'
# require 'pry'

class MongoClient

    attr_reader :client

    def initialize(db: )
        @client = Mongo::Client.new(
            [
                'voxpop-db1:27017',
                'voxpop-db2:27017',
                'voxpop-db3:27017'
            ], 
            database: db,
            replica_set: 'voxpop-db-set'
        )

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
                headers = line.split(',').map(&:strip).map(&:downcase).map(&:to_sym)
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

# binding.pry

mc = MongoClient.new(db: 'voxpop_test')
# binding.pry
# mc.clear
puts mc.import_csv('./medium_data.txt')
# data = mc.read_data


# binding.pry