
# TakeHome.io

## Problem Statement

**Ruby Engineer 60 Minute Challenge**

A client needs to know what is happening on the social networks. All of them. Right now.

The three social networks the client is interested in are:

● https://takehome.io/twitter

● https://takehome.io/facebook

● https://takehome.io/instagram

Because these social networks are so webscale, they don't always respond predictably. The

delay in their response almost appears like someone waited for a random integer of seconds

before responding!

Also, sometimes they will respond with an error. This error will not be valid JSON. Life's hard

sometimes.

The client needs to be able to run your thing, then issue the command:

`curl localhost:3000`

And get back a JSON response of the output from the three social networks in the format:

`{ twitter: [tweets], facebook: [statuses], instagram: [photos] }`

Order isn't important.

This should be a quick little task, but the client is paying us A Billion dollars for it so make sure

your implementation is as robust as it is beautiful. In other words this submission should be

representative of the code you would produce for a production, live 24x7 system, we

suggest you include documentation, test coverage, robust error handling. You should

also be thinking about how to make this code perform as fast as possible.

Have fun!

### Built with


* [Ruby](https://www.ruby-lang.org/en/)

* [Ruby on Rails](https://rubyonrails.org/)

* [PostgreSQL](https://www.postgresql.org/)

* [RSpec](https://github.com/rspec/rspec-rails)

### Getting Started

To get a local copy up and running follow these simple steps.

### Prerequisites

*  `ruby 2.6.5`

*  `rails 6.1.6`

### Installation

1. Clone the repo and cd into it
	```
	git clone https://github.com/adeelsarim/social_networks
	cd social_networks
	```
2. Install the gems
	`bundle install`

3. Setup the Database
	`rails db:create`
4. Start the server
	`rails s`
5. Run test suits
	`rspec`

###

**Get All Data**
```http
curl http://localhost:3000
```
Response Success:
```javascript
  {
  "tweets": [
    {
      "username": "@GuyEndoreKaiser",
      "tweet": "If you live to be 100, you should make up some fake reason why, just to mess with people... like claim you ate a pinecone every single day."
    },
    {
      "username": "@mikeleffingwell",
      "tweet": "STOP TELLING ME YOUR NEWBORN'S WEIGHT AND LENGTH I DON'T KNOW WHAT TO DO WITH THAT INFORMATION."
    }
  ],
  "facebook": [
    {
      "name": "Some Friend",
      "status": "Here's some photos of my holiday. Look how much more fun I'm having than you are!"
    },
    {
      "name": "Drama Pig",
      "status": "I am in a hospital. I will not tell you anything about why I am here."
    }
  ],
  "instagram": [
    {
      "username": "hipster1",
      "picture": "food"
    },
    {
      "username": "hipster2",
      "picture": "coffee"
    },
    {
      "username": "hipster3",
      "picture": "coffee"
    },
    {
      "username": "hipster4",
      "picture": "food"
    },
    {
      "username": "hipster5",
      "picture": "this one is of a cat"
    }
  ]
}
```
Response Error: Sometimes API return Invalid JSON
```
  Server responded with Invalid JSON
```

### Performance

**Error Handling**: If we have proper documentation available for the API we can write a custom error handler class that will be used for handling all the errors.

Example
```
 class Error < StandardError
    attr_reader :code

    # Raised when TakeHome.io returns a 4xx HTTP status code
    ClientError = Class.new(self)

    # Raised when TakeHome.io returns the HTTP status code 400
    BadRequest = Class.new(ClientError)

    # Raised when TakeHome.io returns the HTTP status code 401
    Unauthorized = Class.new(ClientError)

    # Raised when TakeHome.io returns the HTTP status code 403
    Forbidden = Class.new(ClientError)

    # Raised when TakeHome.io returns the HTTP status code 404
    NotFound = Class.new(ClientError)

    # Raised when TakeHome.io returns the HTTP status code 422
    UnprocessableEntity = Class.new(ClientError)

    # Raised when TakeHome.io returns a 5xx HTTP status code
    ServerError = Class.new(self)

    # Raised when TakeHome.io returns the HTTP status code 503
    ServiceUnavailable = Class.new(ServerError)

    # Raised when TakeHome.io returns the HTTP status code 504
    GatewayTimeout = Class.new(ServerError)

    # Raised when an operation subject to timeout takes too long
    TimeoutError = Class.new(self)

    ERRORS = {
      400 => TakeHome::Error::BadRequest,
      401 => TakeHome::Error::Unauthorized,
      403 => TakeHome::Error::Forbidden,
      404 => TakeHome::Error::NotFound,
      422 => TakeHome::Error::UnprocessableEntity,
      503 => TakeHome::Error::ServiceUnavailable,
      504 => TakeHome::Error::GatewayTimeout
    }.freeze


    class << self
      # Create a new error from an HTTP response
      #
      def from_response(body, headers)
        message, code = parse_error(body)
        new(message, headers, code)
      end

      # Create a new error from a media error hash
      #
      def from_processing_response(error, headers)
        message = error[:message]
        code = error[:code]
        new(message, headers, code)
      end

      private

      def parse_error(body)
        # extract_message_from_errors(body)
      end

      def extract_message_from_errors(body)
        first = Array(body[:errors]).first
        if first.is_a?(Hash)
          [first[:message].chomp, first[:code]]
        else
          [first.chomp, nil]
        end
      end
    end

    def initialize(message = "", _headers = {}, code = nil)
      super(message)
      @code = code
    end
  end
```

Pagination: If API supports pagination, we should use that so request won't be timed out.


