# Look in the tasks/setup.rb file for the various options that can be
# configured in this Rakefile. The .rake files in the tasks directory
# are where the options are used.

load 'tasks/setup.rb'

ensure_in_path 'lib'
require 'multi_exiftool'

task :default => 'spec:run'

PROJ.name = 'multi_exiftool'
PROJ.authors = 'Jan Friedrich'
PROJ.email = 'janfri.rubyforge@gmail.com'
PROJ.url = 'http://multi_exiftool.rubyforge.org'
PROJ.rubyforge.name = 'multi_exiftool'

PROJ.spec.opts << '--color'
