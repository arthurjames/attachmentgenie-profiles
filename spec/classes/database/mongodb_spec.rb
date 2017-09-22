require 'spec_helper'
describe 'profiles::database::mongodb' do
  on_os_under_test.each do |os, facts|
    context "on #{os}" do
      let(:facts) do
        facts.merge(root_home: '/root')
      end
      context 'with defaults for all parameters' do
        it { is_expected.to contain_class('profiles::database::mongodb') }
      end
    end
  end
end
