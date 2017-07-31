## HTTP Request Methods
def get(*args)
  call(args.insert(0, 'Get'))
end

def post(*args)
  call(args.insert(0, 'Post'))
end

def put(*args)
  call(args.insert(0, 'Put'))
end

def delete(*args)
  call(args.insert(0, 'Delete'))
end

## API call method
def call(args)
  method = args[0]
  path   = args[1]
  params = args[2]

  # construct api endpoint
  uri  = URI("#{ENDPOINT}/#{path}")
  http = Net::HTTP.new(uri.host, uri.port)

  # use ssl
  http.use_ssl = true
  http.verify_mode = OpenSSL::SSL::VERIFY_NONE

  # construct request
  req = Net::HTTP.const_get(method).new(uri.request_uri)
  req['api_key'] = Graphenedb.configuration.api_key
  req['Accept'] = 'text/html'
  req['Content-Type'] = 'application/json'
  req.body = params.to_json

  # parse response
  res = http.request(req)

  if res.code == '401'
    "Unauthorized. Have you configured your GrapheneDB api key?"
  else
    res.body ? JSON.parse(res.body) : 'no content'
  end
end
