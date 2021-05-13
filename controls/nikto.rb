title 'nikto'
control 'nikto-requirements' do                        
  title 'nikto-inspec requirements'             
  desc 'Make sure, that the requirements to test webservices are met.'

  describe 'User has access to docker' do
    subject { command('docker ps') }                
    it 'should be true' do
      expect(subject.exit_status).to(be 0)
    end
  end

  describe docker_image(input('niktoImage')) do
    it { should exist }
  end
end

control 'nikto-test' do                        
  title 'nikto-inspec test'             
  desc 'Run Nikto against the services configured in your input file.'

  describe "nikto scan" do
    subject { command("docker run #{input('dockerOptions')} --rm #{input('niktoImage')} -h #{input('host')} -p #{input('ports')} #{input('options')}") }
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
