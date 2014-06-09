# dynr53-server

Dynamic DNS service for Amazon Route53 which can be used to automatically update a DNS record in Amazon Route53 based on the public IP address of a machine. This was specifically built to provide a mechanism for a router running DD-WRT to update a DNS record dynamically.

# Features

* FIXME (list of features)

# Requirements

* Bundler
* AWS Route53 account

# Install

## General

* Install [RVM](https://rvm.io/).
* Install Ruby-1.9.3 or later
* Setup a custom [Gem Set](https://rvm.io/gemsets/basics) and switch to it:

```
rvm gemset create dynr53
rvm gemset use dynr53
```

* Install [bundler](http://bundler.io/)

```
gem install bundler
```

* Install the required gems using `bundler`

```
bundle install
```

## OS X Notes

Before running through the steps outlined in the "General" section above, perform the following steps.

* Install Xcode
* Install the Xcode commandline tools

```
xcode-select --install
```

# Usage

Launch the service:

```
rackup -p 4567
```

Send a GET or POST request to update the DNS record in Route53:

```
wget -XGET http://localhost:4567/update/8.8.8.8
```

# Configuration

All configuration options must be stored in a single config file named `config.yml`. See `config.yml.sample` for a sample configuration.

Configuration options include:

* `zone: [ZONE_ID]` -- Route53 hosted zone id
* `access_key: [ACCESS_KEY]` -- AWS access key
* `secret_key: [SECRET]` -- AWS secret key
* `name: [RECORD NAME]` -- Name of the record to update in Route53


# Author

Original author: Sean Laurent

# License

Apache License  
Version 2.0, January 2004  
[http://www.apache.org/licenses](http://www.apache.org/licenses/)