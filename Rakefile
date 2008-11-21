require 'echoe'

Echoe.new 'multi_exiftool' do |p|
  p.author = 'Jan Friedrich'
  p.email = 'janfri.rubyforge@gmail.com'
  p.project = 'multiexiftool'
  p.url = 'http://multiexiftool.rubyforge.org'
  p.development_dependencies = ['yact']
end

namespace :reg do

  ROOT_DIR = File.dirname(__FILE__)
  SCRIPT_DIR = File.join(ROOT_DIR, 'script')
  DATA_DIR = File.join(ROOT_DIR, %w(data regression))
  RB_FILES = File.join(DATA_DIR, '*.rb')

  desc 'Generate regression data'
  task :generate

  def target src
    src + '.out'
  end

  FileList[RB_FILES].each do |src|
    target = target(src)
    file target => src do |t|
      sh "ruby #{t.prerequisites.first} > #{t.name}"
    end

    task :generate => target
  end

  desc 'Running regression tests'
  task :test => :generate do
    FileList[RB_FILES].each do |src|
      target = target(src)
      puts '-' * 8 << File.basename(src)
      sh "ruby #{src} | wdiff -n #{target} - | #{File.join(SCRIPT_DIR, 'colorize.rb')}"# ; echo x >/dev/null"
    end
  end

end
