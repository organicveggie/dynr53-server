
begin
  require 'bones'
rescue LoadError
  abort '### Please install the "bones" gem ###'
end

task :default => 'test:run'
task 'gem:release' => 'test:run'

Bones {
  name     'dynr53'
  authors  'Sean Laurent'
  email    'organicveggie@gmail.com'
  url      'https://github.com/organicveggie/dynr53-server'
}

