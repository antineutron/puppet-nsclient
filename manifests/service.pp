# Author::    Paul Stack  (mailto:pstack@opentable.com)
# Copyright:: Copyright (c) 2013 OpenTable Inc
# License::   MIT

# == Class: nsclient::service
#
# This private class is meant to be called from `nsclient`.
# It manages the nsclient service
#
class nsclient::service(
  $service_state           = $nsclient::service_state,
  $service_enable          = $nsclient::service_enable,
  $allowed_hosts           = $nsclient::allowed_hosts,
  $config_template         = $nsclient::config_template,
  $install_path            = $nsclient::install_path,
  $check_disk_enabled      = $nsclient::check_disk_enabled,
  $check_eventlog_enabled  = $nsclient::check_eventlog_enabled,
  $check_scripts_enabled   = $nsclient::check_scripts_enabled,
  $check_helpers_enabled   = $nsclient::check_helpers_enabled,
  $check_nscp_enabled      = $nsclient::check_nscp_enabled,
  $check_system_enabled    = $nsclient::check_system_enabled,
  $check_wmi_enabled       = $nsclient::check_wmi_enabled,
  $nrpe_server_enabled     = $nsclient::nrpe_server_enabled,
  $nsca_client_enabled     = $nsclient::nsca_client_enabled,
  $nsclient_server_enabled = $nsclient::nsclient_server_enabled,
  $allow_arguments         = $nsclient::allow_arguments,
  $insecure_enabled        = $nsclient::insecure_enabled,
  $custom_aliases          = $nsclient::custom_aliases,
  $external_scripts        = $nsclient::external_scripts,
) {

  case downcase($::osfamily) {
    'windows': {
      file { "${install_path}\\nsclient.ini":
        ensure  => file,
        owner   => 'SYSTEM',
        mode    => '0664',
        content => template($config_template),
        notify  => Service['nscp'],
      }

      service { 'nscp':
        ensure  => $service_state,
        enable  => $service_enable,
        require => File["${install_path}\\nsclient.ini"],
      }
    }
    default: {
      fail('This module only works on Windows based systems.')
    }
  }
}
