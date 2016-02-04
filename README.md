# Experimental Platform: HAProxy

HAProxy load balancer for experimental platform that is also capable of re-targeting inbound SSH connections on port 80 (through
proxy tunnel connections using [publish_to_web](https://github.com/experimental-platform/platform-ptw)) to the SSH daemon on the 
hosting platform machine.

This is a component of the experimental platform. To read more about it please go here:

[https://github.com/experimental-platform/experimental-platform](https://github.com/experimental-platform/experimental-platform)

## Branch: Development

[![Build Status](https://travis-ci.org/experimental-platform/platform-haproxy.svg?branch=development)](https://travis-ci.org/experimental-platform/platform-haproxy)

All development branches stem from and (re-)integrate here.

## Branch: Master

[![Build Status](https://travis-ci.org/experimental-platform/platform-haproxy.svg?branch=master)](https://travis-ci.org/experimental-platform/platform-haproxy)

This is the base for α-channel releases.

## Error Pages

The static error pages for HAProxy are added from the `error_pages/html` directory. These are generated using the Ruby script in `error_pages` and the
error definitions in `error_pages/errors.yml`. The script has no dependencies apart from the Ruby standard library which should always be just available.

You can re-build the static error pages by running `ruby error_pages/build.rb` and committing the result if you have ruby installed on your system.