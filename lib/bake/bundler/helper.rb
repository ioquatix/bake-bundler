# frozen_string_literal: true

# Copyright, 2020, by Samuel G. D. Williams. <http://www.codeotaku.com>
# 
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
# 
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.

require 'bundler/gem_helper'

module Bake
	module Bundler
		class Helper < ::Bundler::GemHelper
			def version_path
				gemspec.files.grep(/version.rb/).first
			end
			
			VERSION_PATTERN = /VERSION = ['"](?<value>\d+\.\d+\.\d+)(?<pre>.*?)['"]/
			
			def update_version(bump)
				return unless version_path = self.version_path
				
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
					yield version if block_given?
					
					File.write(version_path, lines.join)
					
					return version_path
				end
			end
			
			def guard_clean
				super
			end
			
			def already_tagged?
				super
			end
			
			def tag_version
				super
			end
			
			def git_push(remote)
				super
			end
			
			def gem_push?
				super
			end
			
			def rubygem_push(path)
				super
			end
		end
	end
end
