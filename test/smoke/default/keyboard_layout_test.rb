# frozen_string_literal: true

describe file('/etc/default/keyboard') do
  it { should exist }
  its('type') { should eq :file }
  its('content') { should match(/XKBMODEL="pc105"/) }
  its('content') { should match(/XKBLAYOUT="de"/) }
  its('content') { should match(/XKBVARIANT=""/) }
  its('content') { should match(/XKBOPTIONS=""/) }
  its('content') { should match(/BACKSPACE="guess"/) }
end

describe command('localectl status') do
  its('stdout') { should match(/X11 Layout: de/) }
  its('stdout') { should match(/X11 Model: pc105/) }
end
