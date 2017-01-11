# Author::    Paul Stack  (mailto:pstack@opentable.com)
# Copyright:: Copyright (c) 2013 OpenTable Inc
# License::   MIT

# == Class nsclient::params
#
# This private class is meant to be called from `nsclient`
# It sets variables according to platform
#
class nsclient::params {
  $package_name            = 'nscp'
  $ini_path                = 'C:/Program Files/NSClient++/nsclient.ini'
  $allowed_hosts           = []
  $service_state           = 'running'
  $service_enable          = true
  $config_template         = 'nsclient/nsclient.ini.erb'
  $check_disk_enabled      = true
  $check_eventlog_enabled  = true
  $check_scripts_enabled   = true
  $check_helpers_enabled   = true
  $check_nscp_enabled      = true
  $check_system_enabled    = true
  $check_wmi_enabled       = true
  $nrpe_server_enabled     = true
  $nsca_client_enabled     = true
  $nsclient_server_enabled = true
  $allow_arguments         = false
  $insecure_enabled        = false
  $custom_aliases          = []
  $external_scripts        = []
}
