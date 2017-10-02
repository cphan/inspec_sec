control 'Supported_AIX_version' do
  impact 1.0
  title 'Supported AIX version'
  desc 'Below are things to check for:
    - AIX version = 7100-04-02-1614
  '
  describe command('oslevel -s') do
    its('stdout') { should match /^7100-04-04-1717$/ }
    its('exit_status') { should eq 0 }
  end
end

control 'File_System_Utilization' do
  impact 1.0
  title 'File System Utilization'
  desc 'Below are things to check for:
    - File system utilization is below 80%
  '
  %w(hd4 hd2 hd9var hd3 hd1 hd11admin hd10opt livedump).each do |lv|
    describe command("df -Im |awk '/#{lv}/ {print \$5}'| tr -d '%'") do
      its('stdout.to_i') { should be <= 80 }
      its('exit_status') { should eq 0 }
    end
  end
end

control 'Core_File_Config' do
  impact 1.0
  title 'Core File Configuration'
  desc 'Below are things to check for:
    - Core file should be customized
  '
  describe command('lscore -d') do
    its('stdout') { should match /^compression:\son$/ }
    its('stdout') { should match /^path\sspecification:\son$/ }
    its('stdout') { should match /^corefile\slocation:\s\/core$/ }
    its('stdout') { should match /^naming\sspecification:\son$/ }
    its('exit_status') { should eq 0 }
  end
end

control 'Syslogd_Running' do
  impact 1.0
  title 'Syslog daemon is running'
  desc 'Below are things to check for:
    - Syslog daemon is running
  '
  describe command('lssrc -s syslogd') do
    its('stdout') { should match /^\s+syslogd\s+ras\s+\d{1,}\s+active$/ }
    its('exit_status') { should eq 0 }
  end
end
