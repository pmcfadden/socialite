Gem::Specification.new do |s|
  s.name        = "devise"
  s.version     = "1.1.7"
  s.files        = Dir.glob("{lib,app}/**/*") + %w(MIT-LICENSE README.rdoc)
  s.require_path = 'lib'
  s.add_dependency('bcrypt-ruby')
  s.add_dependency('warden')
end

