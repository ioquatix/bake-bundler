
require_relative '../lib/bake/bundler/helper'

def initialize(context)
	super(context)
	
	@helper = Bake::Bundler::Helper.new(context.root)
	@built_gem_path = nil
end

attr :helper

# Build the gem into the pkg directory.
def build
	@built_gem_path ||= @helper.build_gem
	
	gemspec = @helper.gemspec
	
	$stdout.puts "Your gem contains the following files:"
	pp gemspec.files
end

# Build and install the gem into system gems.
# @parameter local [Boolean] only use locally available caches.
def install(local: false)
	path = self.build
	
	@helper.install_gem(path, local)
end

def release(remote: nil)
	@helper.guard_clean
	
	unless @helper.already_tagged?
		@helper.tag_version do
			@helper.git_push(remote)
		end
	end
	
	path = self.build
	
	if @helper.gem_push?
		@helper.rubygem_push(path)
	end
end

