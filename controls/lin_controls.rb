control 'Supported_Linux_Versions' do
  impact 1.0
  title 'Supported Linux Versions'
  desc 'Below are things to check for:
    - Linux version is 6.x or 7.x;
  '
  describe file('/etc/redhat-release') do
    its('content') { should match /^(Red\sHat\sEnterprise\sLinux\sServer\srelease\s6\.8\s\(Santiago\)|Red\sHat\sEnterprise\sLinux\sServer\srelease\s7\.(1|2|3)\s\(Maipo\))$/ }
  end
  describe package('kernel') do
    it { should be_installed }
  end
end

control 'Root_Password_Compliance' do
  impact 1.0
  title 'Root Password Compliance'
  desc 'Below are things to check for Root Password:
    - No password expiration;
    - Number of days of warning before password expires is set
  '
  %w(root).each do |user|
    describe command("chage -l #{user}") do
      its('stdout') { should match /^Password\sexpires\s+:\snever$/ }
      its('exit_status') { should eq 0 }
    end
  end
end

control 'File_System_Utilization' do
  impact 1.0
  title 'File System Utilization'
  desc 'Below are things to check for:
    - File system utilization is below 80%;
  '
  %w(rootvg-homelv rootvg-rootlv rootvg-tmplv rootvg-varlv rootvg-vloglv rootvg-auditlv rootvg-optlv rootvg-swap rootvg-usrlv rootvg-vlauditlv).each do |fsu|
    describe command("df --total /dev/mapper/#{fsu}|awk '/total/ {print \$5}'|tr -d '%'") do
      its('stdout.to_i') { should be <= 80 }
      its('exit_status') { should eq 0 }
    end
  end
end

control 'ntpd_running' do
  impact 1.0
  title 'ntpd daemon running'
  desc 'Below are things to check for:
    - ntpd daemon is installed, enabled and running;
  '
  describe service('ntpd') do
    it { should be_installed }
    it { should be_enabled }
    it { should be_running }
  end
end
