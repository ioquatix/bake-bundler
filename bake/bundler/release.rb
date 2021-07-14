
# Increment the patch number of the current version.
def patch
	release([nil, nil, 1], message: "Patch version bump.")
end

# Increment the minor number of the current version.
def minor
	release([nil, 1, 0], message: "Minor version bump.")
end

# Increment the major number of the current version.
def major
	release([1, 0, 0], message: "Major version bump.")
end

VERSION_PATTERN = /VERSION = ['"](?<value>\d+\.\d+\.\d+)(?<pre>.*?)['"]/

# Scans the files listed in the gemspec for a file named `version.rb`. Extracts the VERSION constant and updates it according to the version bump. Commits the changes to git using the specified message.
#
# @parameter bump [Array(Integer | Nil)] the version bump to apply before publishing, e.g. `0,1,0` to increment minor version number.
# @parameter message [String] the git commit message to use.
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

private

def release(*arguments, **options)
	release = context.lookup('bundler:release')
	helper = release.instance.helper
	
	changes = readlines("git", "status", "--porcelain")
	
	if changes.any?
		puts "Uncommitted modifications detected:"
		changes.each do |change|
			puts change
		end
	else
		last_commit = readlines("git", "log", "-1", "--oneline").first
		
		unless last_commit =~ /version bump|bump version/i
			increment(*arguments, **options)
		end
		
		release.call
	end
end

def shell(*arguments)
	IO.pipe do |input, output|
		pid = Process.spawn(*arguments, out: output)
		output.close
		
		begin
			yield input
		ensure
			pid, status = Process.wait2(pid)
			
			unless status.success?
				raise "Failed to execute #{arguments} -> #{status}"
			end
		end
	end
end

def readlines(*arguments)
	shell(*arguments) do |output|
		return output.readlines
	end
end
