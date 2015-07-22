# Plexts

Ingress Intel Map API Caller

## Description

* all, faction, alerts message to console
* get the information of the portals in Json format
* get the information of the artifacts in Json format

## Setup

```
cp intel.yml.sample intel.yml
```

Fill `intel.yml` with your intel credentials

## Using CLI

```Shell
$ rake build
plexts 0.0.1 built to pkg/plexts-0.0.1.gem.
$ gem install pkg/plexts-0.0.1.gem
Successfully installed plexts-0.0.1
Parsing documentation for plexts-0.0.1
Done installing documentation for plexts after 0 seconds
1 gem installed
$ rbenb rehash # If necessary
$ plexts -h
Usage: plexts [options]
    -c, --console                    show all or faction, aleart messages
    -e, --entity                     show entities infomation of JSON format
        --minlat VALUE               south west area latitude
        --minlng VALUE               south west area longitude
        --maxlat VALUE               north east area latitude
        --maxlng VALUE               north east area longitude
    -p, --portal                     show portal infomation of JSON format
        --guid VALUE                 portal guid
    -z VALUE                         map zoom level 1-20
    -a, --artifacts                  artifacts infomation of JSON format
```

## Using in Rails
In your Gemfile:

```Ruby
gem 'plexts'
```

Don't forget to put `intel.yml` in root of your project

```Ruby
Plexts::get_artifacts
# => {} 

# COMM log
Plexts.get_plexts(minLatE6, minLngE6, maxLatE6, maxLngE6)

# Map entities
Plexts.get_entities(minLatE6, minLngE6, maxLatE6, maxLngE6, zoom) 

# Portal details
Plexts.get_portal_details('d431c89010b4434da63e4b6070e6c414.12')
```

## Caution

This application should be used at your own risk.
When you use it, there is a possibility that the account is stopped.

## Licence

Released under the [WTFPL license](http://www.wtfpl.net/).
