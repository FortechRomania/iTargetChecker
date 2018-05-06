describe Fastlane::Actions::ItargetcheckerAction do
  describe '#run' do
    it 'prints a message' do
      expect(Fastlane::UI).to receive(:message).with("The itargetchecker plugin is working!")

      Fastlane::Actions::ItargetcheckerAction.run(nil)
    end
  end
end
