
require_relative "lib/bake/bundler/version"

Gem::Specification.new do |spec|
	spec.name = "bake-bundler"
	spec.version = Bake::Bundler::VERSION
	
	spec.summary = "Provides recipes for bundler."
	spec.authors = ["Samuel Williams"]
	spec.license = nil
	
	spec.homepage = "https://github.com/ioquatix/bake-bundler"
	
	spec.metadata = {
		"funding_uri" => "https://github.com/sponsors/ioquatix/",
	}
	
	spec.files = Dir.glob('{bake,lib}/**/*', File::FNM_DOTMATCH, base: __dir__)
	
	spec.required_ruby_version = ">= 2.3.0"
	
	spec.add_dependency "bake", "~> 0.9"
	spec.add_dependency "rspec"
end
