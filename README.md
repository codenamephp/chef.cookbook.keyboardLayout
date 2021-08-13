# Chef Cookbook
[![CI](https://github.com/codenamephp/chef.cookbook.keyboardLayout/actions/workflows/ci.yml/badge.svg)](https://github.com/codenamephp/chef.cookbook.keyboardLayout/actions/workflows/ci.yml)

Provides a resource to set the keyboard layout configuration in /etc/default/keyboard and restart several services on changes.

## Usage

Use the resource in your wrapper cookbook. That's it

## Resources
### Keyboard Layout
The `codenamephp_keyboard_layout_manage` sets you default system keyboard layout by replacing `/etc/default/keyboard` with a template where the model,
layout and all other XKB settings can be set using attributes. It also sets up monitoring when the template changes during the chef run and informs
all dependent services.

You can also pass your own template and set attributes as you like them.

#### Actions
- `:update`: Updates the template and restarts services if needed

#### Properties
- `cookbook`: The name of the cookbook where the template can be found, defaults to `'codenamephp_keyboard_layout`
- `template_source`: The name of the template file, defaults to `'keyboard_layout.erb'`
- `model`: The model that is used for the keyboard, defaults to 'pc105'
- `layout`: The layout to be used, e.g. for different languages, defaults 'de'
- `variant`: The variant of the layout that will be used, defaults to ''
- `options`: Additional options to be set, defaults to ''
- `backspace`: How the OS should detect the backspace key, defaults to 'guess'
- `extra_variables`: Additional variables for the template that get merged into the variables passed to the template resource, defaults to {}

#### Examples
```ruby
# Minimal properties
codenamephp_keyboard_layout_manage 'Update keyboard layout'

# With custom template
codenamephp_keyboard_layout_manage 'Update keyboard layout' do
  cookbook 'my_cookbook'
  template_source 'my_template.erb'
  extra_variables(
    {
      new_variable: 'new value',
      layout: 'other layout' # you cando this but ... don't?
    }
  )
end
```
