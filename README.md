# Bake::Bundler

Provides bake tasks for releasing gems using bundler.

[![Development Status](https://github.com/ioquatix/bake-bundler/workflows/Development/badge.svg)](https://github.com/ioquatix/bake-bundler/actions?workflow=Development)

## Installation

``` shell
bundle add bake-bundler
```

## Usage

### Build

``` shell
$ bake bundler:build
```

### Install

``` shell
$ bake bundler:install
```

### Release

``` shell
$ bake bundler:release

$ bake bundler:release:patch
$ bake bundler:release:minor
$ bake bundler:release:major
```

## Contributing

1.  Fork it
2.  Create your feature branch (`git checkout -b my-new-feature`)
3.  Commit your changes (`git commit -am 'Add some feature'`)
4.  Push to the branch (`git push origin my-new-feature`)
5.  Create new Pull Request

## See Also

  - [Bake](https://github.com/ioquatix/bake) — The bake task execution tool.

## License

Released under the MIT license.

Copyright, 2020, by [Samuel G. D. Williams](http://www.codeotaku.com).

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
