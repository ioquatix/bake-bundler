
# Increment the patch number of the current version ("major.minor.patch").
def patch
	increment([nil, nil, 1], message: "Patch version bump.")
end

# Increment the patch number of the current version ("major.minor.patch").
def minor
	increment([nil, 1, 0], message: "Minor version bump.")
end

# Increment the patch number of the current version ("major.minor.patch").
def major
	increment([1, 0, 0], message: "Major version bump.")
end

VERSION_PATTERN = /VERSION = ['"](?<value>\d+\.\d+\.\d+)(?<pre>.*?)['"]/

# Scans the files listed in the gemspec for a file named `version.rb`. Extracts the VERSION constant and updates it according to the version bump. Commits the changes to git using the specified message.
#
# @param bump [Array(Integer | Nil)] the version bump to apply before publishing.
# @param message [String] the git commit message to use.
def increment(bump, message: "Bump version.")
	release = context.lookup('bundler:release')
	helper = release.instance.helper
	gemspec = helper.gemspec
	
	version_path = gemspec.files.grep(/version.rb/).first
	
	Console.logger.info(self) {"Preparing to update #{version_path}..."}
	
	lines = File.readlines(version_path)
	version = nil
	
	lines.each do |line|
		if match = line.match(VERSION_PATTERN)
			version = match[:value].split(/\./).map(&:to_i)
			bump.each_with_index do |increment, index|
				if increment == 1
					version[index] += 1
				elsif increment == 0
					version[index] = 0
				end
			end
			
			line.sub!(match[:value], version.join('.'))
		end
	end
	
	if version
		File.write(version_path, lines.join)
		
		system("git", "add", version_path, chdir: context.root)
		system("git", "commit", "-m", message, chdir: context.root)
		
		version_string = version.join('.')
		
		Console.logger.info(self) {"Updated version to #{version_string}"}
		
		# Ensure that any subsequent tasks use the correct version!
		gemspec.version = Gem::Version.new(version_string)
	else
		raise "Could not find version number!"
	end
end
