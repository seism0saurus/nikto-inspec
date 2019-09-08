# encoding: utf-8
# copyright: 2019, Ulrich Viefhaus
title 'nikto'
niktoImage = attribute('niktoImage', default: 'sullo/nikto', description: 'nikto docker image')
host = attribute('host', default: 'localhost', description: 'Hosts to scan. Multiple hosts are comma separated')
ports = attribute('ports', default: '80,443', description: 'Ports of the webservice. Multiple ports are comma separated')
options = attribute('options', default: '', description: 'additional commandline opotions for nikto')
dockerOptions = attribute('dockerOptions', default: '', description: 'additional commandline opotions for docker')

control 'nikto-requirements' do                        
  title 'nikto-inspec requirements'             
  desc 'Make sure, that the requrements to test webservices are met.'

  describe 'User has access to docker' do
    subject { command('docker ps') }                
    it 'should be true' do
      expect(subject.exit_status).to(be 0)
    end
  end

  describe docker_image(niktoImage) do
    it { should exist }
  end

end

control 'nikto-test' do                        
  title 'nikto-inspec test'             
  desc 'Run the test against the services configured in files/servers.yml.'

  describe "nikto scan" do
    subject { command("docker run #{dockerOptions} --rm #{niktoImage} -h #{host} -p #{ports} #{options}") }
    it 'should not abort' do
      expect(subject.exit_status).to(be 0)
    end
    it 'should find no errors' do
      expect(subject.stdout).to(match /\b0 error/)
    end
    it 'should find no issues' do
      expect(subject.stdout).to(match /\b0 item/)
    end
  end

end
