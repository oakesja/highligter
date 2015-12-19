Gem::Specification.new do |gem|
  gem.author        = 'Jacob Oakes'
  gem.summary       = 'Converts markdown to html and adds code highlighting to code blocks'
  gem.files         = ['lib/converter.rb']
  gem.executables   = ['markdown2html']
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = 'markdown2html'
  gem.require_paths = %w(lib)
  gem.add_dependency 'trollop', '~> 2.1'
  gem.version       = '0.1'
end