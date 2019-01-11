$:.push File.expand_path('lib', __dir__)
require 'rails_media/version'

Gem::Specification.new do |s|
  s.name = 'rails_media'
  s.version = RailsMedia::VERSION
  s.authors = ['qinmingyuan']
  s.email = ['mingyuan0715@foxmail.com']
  s.homepage = ''
  s.summary = 'Summary of RailsCms.'
  s.description = 'Description of RailsCms.'
  s.license = 'MIT'

  s.files = Dir[
    '{app,config,db,lib}/**/*',
    'MIT-LICENSE',
    'Rakefile',
    'README.md'
  ]

  s.add_dependency 'rails_com', '~> 1.2'
  s.add_development_dependency 'sqlite3'
end
