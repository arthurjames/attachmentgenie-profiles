require 'spec_helper'
describe 'profiles::website::uwsgi' do
  on_os_under_test.each do |os, facts|
    context "on #{os}" do
      let(:facts) { facts }
      context 'with defaults for all parameters' do
        it { should contain_class('profiles::website::uwsgi') }
        it { should contain_group('uwgsi').with_ensure('present') }
        it { should contain_user('uwgsi').with_ensure('present') }
      end
    end
  end
end