#
# Cookbook:: dev_env
# Spec:: default
#
# Copyright:: 2017, Sean Holden, All Rights Reserved.

require 'spec_helper'

describe 'dev_env::default' do
  context 'When all attributes are default, on CentOS7' do
    let(:platform) { 'centos' }
    let(:version) { '7.2.1511' }
    let(:chef_run) {
      ChefSpec::SoloRunner.new(platform: platform, version: version).
        converge(described_recipe)
    }

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end

    describe '#directories' do
      it 'creates ~/code' do
        expect(chef_run).to create_directory('/home/vagrant/code').
          with(
            owner: 'vagrant',
            group: 'vagrant',
            mode: '755'
          )
      end

      it 'creates ~/code/test_app' do
        expect(chef_run).to create_directory('/home/vagrant/code/test_app').
          with(
            owner: 'vagrant',
            group: 'vagrant',
            mode: '755'
          )
      end
    end
  end
end
