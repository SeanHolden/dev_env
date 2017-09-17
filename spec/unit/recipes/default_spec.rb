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

    before do
      stub_command("echo $SHELL | grep -c zsh").and_return(false)
    end

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
    end

    describe '#git' do
      it 'checkout/sync repo' do
        expect(chef_run).to sync_git('/home/vagrant/code/ReactReduxStarter').
          with(
            repository: 'git@github.com:SeanHolden/ReactReduxStarter.git',
            checkout_branch: 'master',
            enable_checkout: false,
            user: 'vagrant',
            group: 'vagrant',
            environment: { 'HOME' => '/home/vagrant', 'USER' => 'vagrant' },
            timeout: 10
          )
      end
    end

    describe 'templates' do
      it 'creates ~/.zshrc' do
        expect(chef_run).to create_template('/home/vagrant/.zshrc').with(
          owner: 'vagrant',
          group: 'vagrant',
          mode: '644'
        )
      end
    end
  end

  context 'When all attributes are default, on Ubuntu' do
    let(:platform) { 'ubuntu' }
    let(:version) { '16.04' }
    let(:chef_run) {
      ChefSpec::SoloRunner.new(platform: platform, version: version).
        converge(described_recipe)
    }

    before do
      stub_command("echo $SHELL | grep -c zsh").and_return(false)
    end

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end

    describe '#directories' do
      it 'creates ~/code' do
        expect(chef_run).to create_directory('/home/ubuntu/code').
          with(
            owner: 'ubuntu',
            group: 'ubuntu',
            mode: '755'
          )
      end
    end

    describe '#git' do
      it 'checkout/sync repo' do
        expect(chef_run).to sync_git('/home/ubuntu/code/ReactReduxStarter').
          with(
            repository: 'git@github.com:SeanHolden/ReactReduxStarter.git',
            checkout_branch: 'master',
            enable_checkout: false,
            user: 'ubuntu',
            group: 'ubuntu',
            environment: { 'HOME' => '/home/ubuntu', 'USER' => 'ubuntu' },
            timeout: 10
          )
      end
    end

    describe 'templates' do
      it 'creates ~/.zshrc' do
        expect(chef_run).to create_template('/home/ubuntu/.zshrc').with(
          owner: 'ubuntu',
          group: 'ubuntu',
          mode: '644'
        )
      end
    end

    describe 'execute commands' do
      it 'upgrades all packages' do
        expect(chef_run).to run_execute('apt-get upgrade')
      end

      it 'upgrades all distro packages' do
        expect(chef_run).to run_execute('apt-get dist-upgrade')
      end
    end
  end
end
