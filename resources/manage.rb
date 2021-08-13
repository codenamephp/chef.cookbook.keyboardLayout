# frozen_string_literal: true

unified_mode true

property :cookbook, String, default: 'codenamephp_keyboard_layout', description: 'The cookbook that contains the template, defaults to this cookbook'
property :template_source, String, default: 'keyboard_layout.erb', description: 'The name of the template, defaults to keyboard_layout.erb'
property :model, String, default: 'pc105', description: 'The model that is used for the keyboard'
property :layout, String, default: 'de', description: 'The layout to be used, e.g. for different languages'
property :variant, String, default: '', description: 'The variant of the layout that will be used'
property :options, String, default: '', description: 'Additional options to be set'
property :backspace, String, default: 'guess', description: 'How the OS should detect the backspace key'
property :extra_variables, Hash, default: {}, description: 'Additional variables for the template that get merged into the variables passed to the template resource'

action :update do
  template 'Update keyboard layout' do
    path '/etc/default/keyboard'
    cookbook new_resource.cookbook
    source new_resource.template_source
    variables(
      {
        model: new_resource.model,
        layout: new_resource.layout,
        variant: new_resource.variant,
        options: new_resource.options,
        backspace: new_resource.backspace,
      }.merge(new_resource.extra_variables)
    )
  end

  bash 'Execute bash script' do
    action :nothing
    code <<~COMMANDS
      sudo service keyboard-setup restart;
      sudo setupcon;
      sudo update-initramfs -u;
      sudo setxkbmap de;
      sudo udevadm trigger --subsystem-match=input --action=change;
    COMMANDS
    subscribes :run, 'template[Update keyboard layout]', :delayed
  end
end
