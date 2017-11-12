require 'elasticsearch'

client = Elasticsearch::Client.new log: true

client.index(index: 'myindex',
              type: 'mytype',
                id: 1,
              body: { title: 'Test', content: 'blah blah'})
# => {"_index"=>"myindex", ... "created"=>true}

client.search index: 'myindex', body: { query: { match: { title: 'test' } } }
# => {"took"=>2, ..., "hits"=>{"total":5, ...}}
client.search index: 'myindex', body: { query: { match: { content: 'blah' } } }
