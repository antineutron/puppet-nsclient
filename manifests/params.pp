# Author::    Paul Stack  (mailto:pstack@opentable.com)
# Copyright:: Copyright (c) 2013 OpenTable Inc
# License::   MIT

# == Class nsclient::params
#
# This privaye class is meant to be called from `nsclient`
# It sets variables according to platform
#
class nsclient::params {
  $allowed_hosts           = []
  $service_state           = 'running'
  $service_enable          = true
  $package_source_location = 'https://github.com/mickem/nscp/releases/download/0.4.3.143'
  $package_name            = 'NSClient++ (x64)'
  $package_source          = 'NSCP-0.4.3.143-x64.msi'
  $download_destination    = "c:\\temp"
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
}
