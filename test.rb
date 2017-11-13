require 'elasticsearch'

#whole file is gucci, this is if we don't wanna use rails to index stuff:

client = Elasticsearch::Client.new(log: true, host: ENV['SEARCHBOX_SSL_URL'])

# works:
client.index(index: 'tutors',
              type: 'Tutor',
                id: 1,
              body: { uuid: 'Test', first_name: 'testjeet'})

# return all:
client.search( index: 'tutors', body: { query: {  } } )
Elasticsearch::Model.client.search( index: 'tutors', body: { query: {  } } )

# specific:
client.search( index: 'tutors', body: { query: { match: { first_name: 'lol' } } } )
