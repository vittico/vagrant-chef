describe os_env('JAVA_HOME') do
	its('content') { should eq '/etc/alternatives/java_sdk' }
end

describe os_env('JRE_HOME') do
        its('content') { should eq '/etc/alternatives/jre' }
end

describe port(8080) do
  it { should be_listening }
  its('addresses') { should include '0.0.0.0' }
end

describe port(1099) do
  it { should be_listening }
  its('addresses') { should include '0.0.0.0' }
end

