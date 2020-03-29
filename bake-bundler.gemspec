require_relative 'lib/bake/bundler/version'

Gem::Specification.new do |spec|
	spec.name = "bake-bundler"
	spec.version = Bake::Bundler::VERSION
	spec.authors = ["Samuel Williams"]
	spec.email = ["samuel.williams@oriontransfer.co.nz"]
	
	spec.summary = "Provides recipes for bundler."
	spec.homepage = "https://github.com/ioquatix/bake-bundler"
	spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")
	
	# Specify which files should be added to the gem when it is released.
	# The `git ls-files -z` loads the files in the RubyGem that have been added into git.
	spec.files = Dir.chdir(__dir__) do
		`git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
	end
	
	spec.add_dependency "bake", "~> 0.9"
	
	spec.executables = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
	spec.require_paths = ["lib"]
end
