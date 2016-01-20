# coding: utf-8

Gem::Specification.new do |spec|
  spec.name          = 'highlighter'
  spec.version       = File.readlines('version')[0].strip
  spec.authors       = ['Jacob Oakes']
  spec.email         = ['jacoboakes92@gmail.com']
  spec.summary       = 'Converts markdown to html and highlights code blocks'
  spec.description   = 'Converts markdown to html while adding syntax highlighting to code blocks'
  spec.homepage      = 'https://github.com/oakesja/highligter'
  spec.license       = 'Apache 2.0'
  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = ['markdown2html']
  spec.require_paths = ['lib']
  spec.required_ruby_version = '>= 2.0'
  spec.add_dependency 'clamp', '~> 1.0'
  spec.add_dependency 'redcarpet', '~> 3.3'
  spec.add_development_dependency 'bundler', '~> 1.10'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'oj'
end
