# Author::    Paul Stack  (mailto:pstack@opentable.com)
# Copyright:: Copyright (c) 2013 OpenTable Inc
# License::   MIT

# == Class: nsclient::install
#
# This private class is meant to be called from `nsclient`.
# It downloads the package and installs it.
#
class nsclient::install {

  case downcase($::osfamily) {
    'windows': {

      package { $nsclient::package_name:
        ensure => present,
        provider => 'chocolatey',
      }
    }
    default: {
      fail('This module only works on Windows based systems.')
    }
  }
}
