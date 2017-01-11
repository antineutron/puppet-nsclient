# Author::    Paul Stack  (mailto:pstack@opentable.com)
# Copyright:: Copyright (c) 2013 OpenTable Inc
# License::   MIT

# == Class: nsclient
#
# Module to install NSClient on Windows.
#
# === Requirements/Dependencies
#
# Currently requires the puppetlabs/stdlib module on the Puppet Forge in
# order to validate much of the the provided configuration.
#
# === Parameters
#
# [*package_name*]
# This is name of the package to download from Chocolatey
#
# [*ini_path*]
# This is full path to the nsclient.ini file on the system
#
# [*allowed_hosts*]
# Array of hosts that your client can communicate with. You can use netmasks
# (/ syntax) or * to create ranges.
#
# [*service_state*]
# Whether you want to nsclient service to start up. Defaults to running
#
# [*service_enable*]
# Whether you want to nsclient service to start up at boot. Defaults to true
#
# [*config_template*]
# This is the template to use as the config file.
#
# [*check_disk_enabled*]
# Whether you want nsclient to check disk space
# 
# [*check_eventlog_enabled*]
# Whether you want to check errors and warnings in the event log
# 
# [*check_scripts_enabled*]
# Whether you want to run external scripts for more complex checks
# 
# [*check_helpers_enabled*]
# Whether you want to turn on helper functions to extend other checks
# 
# [*check_nscp_enabled*]
# Whether you want to check the agent state
# 
# [*check_system_enabled*]
# Whether you want to check system stats such as CPU and memory usage
# 
# [*check_wmi_enabled*]
# Whether you want to check WMI info
# 
# [*nrpe_server_enabled*]
# Whether you want to listen for incoming NRPE requests from Nagios
# 
# [*nsca_client_enabled*]
# Whether you want to support passive Nagios checks via NSCA
# 
# [*nsclient_server_enabled*]
# Whether you want to run the NSClient server to accept incoming requests
# 
# [*allow_arguments*]
# Whether you want Nagios to be able to pass in command arguments
# 
# [*insecure_enabled*]
# Whether you want to enable older insecure NRPE protocol for legacy check plugin
# 
# [*custom_aliases*]
# Optional list of aliases to add (hashes of name, command and args)
# 
# [*external_scripts*]
# Optional list of external script definitions (hashes of name, command and args)
# 
#
# === Examples
#
# Basic installation:
#
#   class { 'nsclient':
#   }
#
# In order to configure the nagios hosts to communicate with:
#
#   class { 'nsclient':
#     allowed_hosts => ['10.21.0.0/22','10.21.4.0/22'],
#   }
#
class nsclient (
  $package_name            = $nsclient::params::package_name,
  $ini_path                = $nsclient::params::ini_path,
  $allowed_hosts           = $nsclient::params::allowed_hosts,
  $service_state           = $nsclient::params::service_state,
  $service_enable          = $nsclient::params::service_enable,
  $config_template         = $nsclient::params::config_template,
  $check_disk_enabled      = $nsclient::params::check_disk_enabled,
  $check_eventlog_enabled  = $nsclient::params::check_eventlog_enabled,
  $check_scripts_enabled   = $nsclient::params::check_scripts_enabled,
  $check_helpers_enabled   = $nsclient::params::check_helpers_enabled,
  $check_nscp_enabled      = $nsclient::params::check_nscp_enabled,
  $check_system_enabled    = $nsclient::params::check_system_enabled,
  $check_wmi_enabled       = $nsclient::params::check_wmi_enabled,
  $nrpe_server_enabled     = $nsclient::params::nrpe_server_enabled,
  $nsca_client_enabled     = $nsclient::params::nsca_client_enabled,
  $nsclient_server_enabled = $nsclient::params::nsclient_server_enabled,
  $allow_arguments         = $nsclient::params::allow_arguments,
  $insecure_enabled        = $nsclient::params::insecure_enabled,
  $custom_aliases          = $nsclient::params::custom_aliases,
  $external_scripts        = $nsclient::params::external_scripts,
) inherits nsclient::params {

  validate_string($package_source_location)
  validate_string($package_source)
  validate_string($package_name)
  validate_string($config_template)
  validate_string($install_path)

  class {'::nsclient::install':} ->
  class {'::nsclient::service':}

}
