# frozen_string_literal: true

require 'spec_helper'

describe 'codenamephp_keyboard_layout_manage' do
  platform 'debian' # https://github.com/chefspec/chefspec/issues/953

  step_into :codenamephp_keyboard_layout_manage
  let(:bash) { chef_run.bash('Execute bash script') }

  context 'Minimal properties' do
    recipe do
      codenamephp_keyboard_layout_manage 'Update keyboard layout'
    end

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end

    it 'Updates the layout' do
      expect(chef_run).to create_template('Update keyboard layout').with(
        path: '/etc/default/keyboard',
        cookbook: 'codenamephp_keyboard_layout',
        source: 'keyboard_layout.erb',
        variables: {
          model: 'pc105',
          layout: 'de',
          variant: '',
          options: '',
          backspace: 'guess'
        }
      )
    end

    it 'subscribes to template changes' do
      expect(bash).to subscribe_to('template[Update keyboard layout]').delayed
    end
  end

  context 'With custom properties' do
    recipe do
      codenamephp_keyboard_layout_manage 'Update keyboard layout' do
        cookbook 'some cookbook'
        template_source 'some template'
        model 'some model'
        layout 'some layout'
        variant 'some variant'
        options 'some options'
        backspace 'some backspace'
      end
    end

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end

    it 'Updates the layout' do
      expect(chef_run).to create_template('Update keyboard layout').with(
        path: '/etc/default/keyboard',
        cookbook: 'some cookbook',
        source: 'some template',
        variables: {
          model: 'some model',
          layout: 'some layout',
          variant: 'some variant',
          options: 'some options',
          backspace: 'some backspace'
        }
      )
    end
  end

  context 'With extra variables properties' do
    recipe do
      codenamephp_keyboard_layout_manage 'Update keyboard layout' do
        model 'some model'
        layout 'some layout'
        extra_variables(
          model: 'overriden model',
          some_variable: 'some value'
        )
      end
    end

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end

    it 'Updates the layout' do
      expect(chef_run).to create_template('Update keyboard layout').with(
        variables: {
          model: 'overriden model',
          layout: 'some layout',
          some_variable: 'some value',
          backspace: 'guess',
          options: '',
          variant: ''
        }
      )
    end
  end
end
