# Libcodeowners

A thin Ruby wrapper around [codeowners-rs](https://github.com/rubyatscale/codeowners-rs)

## Why?

The [codeowners-rs](https://github.com/rubyatscale/codeowners-rs) CLI is a fast alternative to the Ruby gem [code_ownership](https://github.com/rubyatscale/code_ownership). However, since codeowners-rs is written in Rust, it can't provide direct Ruby APIs.

**libcodeowners** provides Ruby APIs that delegate to codeowners-rs. Much of this code was lifted from [code_ownership](https://github.com/rubyatscale/code_ownership).

## Installation

```bash
gem install libcodeowners
```

## Usage

```ruby
require 'libcodeowners'

team = Libcodeowners.for_file('path/to/file.rb')
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/rubyatscale/libcodeowners.
