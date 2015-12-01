require 'spec_helper'

describe 'nsclient', :type => :class do

  let(:facts) { {
      :osfamily  => 'Windows'
  } }
  let(:params) {{
      :package_source_location => 'https://github.com/mickem/nscp/releases/download/0.4.3.143',
      :package_source          => 'NSCP-0.4.3.143-x64.msi',
      :package_name            => 'NSCP-0.4.3.143-x64.msi',
      :download_destination    => 'c:\\temp'
  }}

  it { should contain_class('nsclient::install').that_comes_before('nsclient::service') }

  context 'using params defaults' do
    it { should contain_class('nsclient') }
    it { should contain_download_file('NSCP-Installer').with(
      'url'                   => 'https://github.com/mickem/nscp/releases/download/0.4.3.143/NSCP-0.4.3.143-x64.msi',
      'destination_directory' => 'c:\temp'
    )}
    it { should contain_package('NSCP-0.4.3.143-x64.msi').with(
      'ensure'   => 'installed',
      'provider' => 'windows',
      'source'   => 'c:\temp\NSCP-0.4.3.143-x64.msi',
      'require'  => 'Download_file[NSCP-Installer]'
    )}
    it { should contain_service('nscp').with_ensure('running') }
#
  end

  context 'installing a custom version' do

    let(:params) {{
      :package_source           => 'NSCP-Custom-build.msi',
      :package_name             => 'NSClient++ (x64)',
      :package_source_location  => 'http://myproxy.com:8080'
    }}

    it { should contain_package('NSClient++ (x64)').with(
      'ensure'   => 'installed',
      'provider' => 'windows',
      'source'   => 'c:\temp\NSCP-Custom-build.msi',
      'require'  => 'Download_file[NSCP-Installer]'
    )}

  end

  context 'when trying to install on Ubuntu' do
    let(:facts) { {:osfamily => 'Ubuntu'} }
    it do
      expect {
        should contain_class('nsclient')
      }.to raise_error(Puppet::Error, /^This module only works on Windows based systems./)
    end
  end

  context 'with service_state set to stopped' do
    let(:params) { {'service_state' => 'stopped'} }

    it { should contain_service('nscp').with_ensure('stopped') }
  end

  context 'with service_enable set to false' do
    let(:params) { {'service_enable' => 'false'} }

    it { should contain_service('nscp').with_enable('false') }
  end

  context 'with service_enable set to true' do
    let(:params) { {'service_enable' => 'true'} }

    it { should contain_service('nscp').with_enable('true') }
  end

  context 'when single value array of allowed hosts' do
    let(:params) {{ 'allowed_hosts' => ['172.16.0.3'], 'service_state' => 'running', 'service_enable' => 'true' }}

    it { should contain_file('C:\Program Files\NSClient++\nsclient.ini').with_content(/allowed hosts = 172\.16\.0\.3/) }
  end

  context 'when passing an array of allowed hosts' do
    let(:params) {{ 'allowed_hosts' => ['10.21.0.0/22','10.21.4.0/22'], 'service_state' => 'running', 'service_enable' => 'true' }}

    it { should contain_file('C:\Program Files\NSClient++\nsclient.ini').with_content(/allowed hosts = 10\.21\.0\.0\/22,10\.21\.4\.0\/22/) }
  end

  context 'with default module settings' do
    let(:params) {{ }}
    it { should contain_file('C:\Program Files\NSClient++\nsclient.ini').with_content(/CheckDisk = 1/) }
    it { should contain_file('C:\Program Files\NSClient++\nsclient.ini').with_content(/CheckEventLog = 1/) }
    it { should contain_file('C:\Program Files\NSClient++\nsclient.ini').with_content(/CheckExternalScripts = 1/) }
    it { should contain_file('C:\Program Files\NSClient++\nsclient.ini').with_content(/CheckHelpers = 1/) }
    it { should contain_file('C:\Program Files\NSClient++\nsclient.ini').with_content(/CheckNSCP = 1/) }
    it { should contain_file('C:\Program Files\NSClient++\nsclient.ini').with_content(/CheckSystem = 1/) }
    it { should contain_file('C:\Program Files\NSClient++\nsclient.ini').with_content(/CheckWMI = 1/) }
    it { should contain_file('C:\Program Files\NSClient++\nsclient.ini').with_content(/NRPEServer = 1/) }
    it { should contain_file('C:\Program Files\NSClient++\nsclient.ini').with_content(/NSCAClient = 1/) }
    it { should contain_file('C:\Program Files\NSClient++\nsclient.ini').with_content(/NSClientServer = 1/) }
  end

  context 'when check_disk is enabled' do
    let(:params) {{ 'check_disk_enabled' => true }}

    it { should contain_file('C:\Program Files\NSClient++\nsclient.ini').with_content(/CheckDisk = 1/) }
  end

  context 'when check_disk is disabled' do
    let(:params) {{ 'check_disk_enabled' => false }}

    it { should contain_file('C:\Program Files\NSClient++\nsclient.ini').with_content(/CheckDisk = 0/) }
  end

  context 'when check_eventlog is enabled' do
    let(:params) {{ 'check_eventlog_enabled' => true }}

    it { should contain_file('C:\Program Files\NSClient++\nsclient.ini').with_content(/CheckEventLog = 1/) }
  end

  context 'when check_eventlog is disabled' do
    let(:params) {{ 'check_eventlog_enabled' => false }}

    it { should contain_file('C:\Program Files\NSClient++\nsclient.ini').with_content(/CheckEventLog = 0/) }
  end

  context 'when check_scripts is enabled' do
    let(:params) {{ 'check_scripts_enabled' => true }}

    it { should contain_file('C:\Program Files\NSClient++\nsclient.ini').with_content(/CheckExternalScripts = 1/) }
  end

  context 'when check_scripts is disabled' do
    let(:params) {{ 'check_scripts_enabled' => false }}

    it { should contain_file('C:\Program Files\NSClient++\nsclient.ini').with_content(/CheckExternalScripts = 0/) }
  end

  context 'when check_helpers is enabled' do
    let(:params) {{ 'check_helpers_enabled' => true }}

    it { should contain_file('C:\Program Files\NSClient++\nsclient.ini').with_content(/CheckHelpers = 1/) }
  end

  context 'when check_helpers is disabled' do
    let(:params) {{ 'check_helpers_enabled' => false }}

    it { should contain_file('C:\Program Files\NSClient++\nsclient.ini').with_content(/CheckHelpers = 0/) }
  end

  context 'when check_nscp is enabled' do
    let(:params) {{ 'check_nscp_enabled' => true }}

    it { should contain_file('C:\Program Files\NSClient++\nsclient.ini').with_content(/CheckNSCP = 1/) }
  end

  context 'when check_nscp is disabled' do
    let(:params) {{ 'check_nscp_enabled' => false }}

    it { should contain_file('C:\Program Files\NSClient++\nsclient.ini').with_content(/CheckNSCP = 0/) }
  end

  context 'when check_system is enabled' do
    let(:params) {{ 'check_system_enabled' => true }}

    it { should contain_file('C:\Program Files\NSClient++\nsclient.ini').with_content(/CheckSystem = 1/) }
  end

  context 'when check_system is disabled' do
    let(:params) {{ 'check_system_enabled' => false }}

    it { should contain_file('C:\Program Files\NSClient++\nsclient.ini').with_content(/CheckSystem = 0/) }
  end

  context 'when check_wmi is enabled' do
    let(:params) {{ 'check_wmi_enabled' => true }}

    it { should contain_file('C:\Program Files\NSClient++\nsclient.ini').with_content(/CheckWMI = 1/) }
  end

  context 'when check_wmi is disabled' do
    let(:params) {{ 'check_wmi_enabled' => false }}

    it { should contain_file('C:\Program Files\NSClient++\nsclient.ini').with_content(/CheckWMI = 0/) }
  end

  context 'when nrpe_server is enabled' do
    let(:params) {{ 'nrpe_server_enabled' => true }}

    it { should contain_file('C:\Program Files\NSClient++\nsclient.ini').with_content(/NRPEServer = 1/) }
  end

  context 'when nrpe_server is disabled' do
    let(:params) {{ 'nrpe_server_enabled' => false }}

    it { should contain_file('C:\Program Files\NSClient++\nsclient.ini').with_content(/NRPEServer = 0/) }
  end

  context 'when nsca_client is enabled' do
    let(:params) {{ 'nsca_client_enabled' => true }}

    it { should contain_file('C:\Program Files\NSClient++\nsclient.ini').with_content(/NSCAClient = 1/) }
  end

  context 'when nsca_client is disabled' do
    let(:params) {{ 'nsca_client_enabled' => false }}

    it { should contain_file('C:\Program Files\NSClient++\nsclient.ini').with_content(/NSCAClient = 0/) }
  end

  context 'when nsclient_server is enabled' do
    let(:params) {{ 'nsclient_server_enabled' => true }}

    it { should contain_file('C:\Program Files\NSClient++\nsclient.ini').with_content(/NSClientServer = 1/) }
  end

  context 'when nsclient_server is disabled' do
    let(:params) {{ 'nsclient_server_enabled' => false }}

    it { should contain_file('C:\Program Files\NSClient++\nsclient.ini').with_content(/NSClientServer = 0/) }
  end

  context 'with a list of custom aliases' do
    let(:params) {{
      'service_state' => 'running', 'service_enable' => 'true', 'custom_aliases' => [
        {'name' => 'foo', 'command' => 'MyFooCommand', 'args' => 'a list of args for foo'},
        {'name' => 'bar', 'command' => 'MyBarCommand', 'args' => 'a list of args for bar'},
        {'name' => 'baz', 'command' => 'MyBazCommand', 'args' => 'a list of args for baz'},
      ]
    }}

    it { should contain_file('C:\Program Files\NSClient++\nsclient.ini').with_content(/alias_foo = MyFooCommand a list of args for foo/) }
    it { should contain_file('C:\Program Files\NSClient++\nsclient.ini').with_content(/alias_bar = MyBarCommand a list of args for bar/) }
    it { should contain_file('C:\Program Files\NSClient++\nsclient.ini').with_content(/alias_baz = MyBazCommand a list of args for baz/) }
  end

end
