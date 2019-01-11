$:.push File.expand_path('lib', __dir__)
require 'rails_cms/version'

Gem::Specification.new do |spec|
  spec.name = 'rails_cms'
  spec.version = RailsCms::VERSION
  spec.authors = ['qinmingyuan']
  spec.email = ['mingyuan0715@foxmail.com']
  spec.homepage = ''
  spec.summary = 'Summary of RailsCms.'
  spec.description = 'Description of RailsCms.'
  spec.license = 'MIT'

  spec.files = Dir[
    '{app,config,db,lib}/**/*',
    'MIT-LICENSE',
    'Rakefile',
    'README.md'
  ]

  spec.add_dependency 'rails_com', '~> 5.2.2'

  spec.add_development_dependency 'sqlite3'
end
