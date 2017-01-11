# Author::    Paul Stack  (mailto:pstack@opentable.com)
# Copyright:: Copyright (c) 2013 OpenTable Inc
# License::   MIT

# == Class: nsclient::service
#
# This private class is meant to be called from `nsclient`.
# It manages the nsclient service
#
class nsclient::service(
  $service_state   = $nsclient::service_state,
  $service_enable  = $nsclient::service_enable,
  $allowed_hosts   = $nsclient::allowed_hosts,
  $config_template = $nsclient::config_template,
  $ini_path        = $nsclient::ini_path
) {

  case downcase($::osfamily) {
    'windows': {
      file { "${ini_path}":
        ensure  => file,
        owner   => 'SYSTEM',
        mode    => '0664',
        content => template($config_template),
        notify  => Service['nscp'],
      }

      service { 'nscp':
        ensure  => $service_state,
        enable  => $service_enable,
        require => File["${ini_path}"],
      }
    }
    default: {
      fail('This module only works on Windows based systems.')
    }
  }
}
