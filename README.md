# Doctor  <img src="https://scottjen.files.wordpress.com/2012/05/houseblackss.png" width="150">

This gem will allow you to check the status of all your external dependencies, e.g. url, database, etc

[![Build Status](https://travis-ci.org/magnocosta/doctor.svg?branch=master)](https://travis-ci.org/magnocosta/doctor)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'doctor'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install doctor

## Usage

First, you need to create a file named ```$YOUR_PROJECT/config/initializers/doctor.rb```.
Your file should look like:
```ruby
#one active record per connection is fine
Doctor::ConfigManager.active_record_list.concat [DogActiveRecord, Legacy::CatAnotherDatabase]

#urls that we will do a telnet
Doctor::ConfigManager.url_to_telnet_list.concat [
  {name: 'uaiHebert', host: 'uaihebert.com'},
  {name: 'Paypal', host: 'api.paypal.com', port: 443}
]
```

To see the health check status, access the following URL: http://YOUR_PROJECT/doctor/health_check

A JSON like this will appear:
```json
{  
   "telnets":[  
       {  
         "name":"uaiHebert",
         "host":"uaihebert.com",
         "port":80,
         "timeout":1,
         "wait_time":1,
         "status":"ok"
      },
      {  
         "name":"Paypal",
         "host":"api.paypal.com",
         "port":443,
         "timeout":1,
         "wait_time":1,
         "status":"ok"
      }
   ],
   "databases":[  
      {  
         "status":"ok",
         "active_record":"DogActiveRecord"
      },
      {  
         "status":"error",
         "active_record":"Legacy::CatAnotherDatabase",
         "error_message":"Can't connect to MySQL server on '127.0.0.1' (111)"
      }
   ]
}
```
About the json:
* every time that an error is deteced, the returned http status will be 500
* In case of error ```"status" : "error"``` you will find the attribute ```"error_message":"error text..."``` with the error text
* Notice that with the telnet url some default values were added. You can override them in your ```doctor.rb``` class, e.g. : ```{name: 'uaiHebert', host: 'uaihebert.com', timeout: 2}```
 

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/estantevirtual/doctor. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
fr
