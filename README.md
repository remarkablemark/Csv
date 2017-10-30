# Csv

Parses string to [CSV](https://tools.ietf.org/html/rfc4180):

```rb
Csv.parse(string, separator=',', quote='"')
```

## Install

Prerequisites:

- [Ruby](https://www.ruby-lang.org)
- [Bundler](http://bundler.io)

```sh
$ git clone https://github.com/remarkablemark/Csv.git && cd Csv
$ bundle install
```

## Usage

Require the `Csv` class:

```rb
require_relative 'csv'
```

Then parse CSV string to multidimensional array:

```rb
Csv.parse("a,b,c\nd,e,\"foo\"")
# [["a", "b", "c"], ["d", "e", "foo"]]
```

### Parameters

The first parameter is `string`. If the field quotes are unclosed, then an `ArgumentError` will be raised:

```rb
Csv.parse('"a","b","c')
# raise ArgumentError, 'unclosed quote'
```

The second parameter is `separator`. The default value is `,`. It can be customized:

```rb
Csv.parse("a\tb\tc", "\t")
# [["a", "b"]]
```

The third parameter is `quote`. The default value is `"`. It can be customized:

```rb
Csv.parse("|a|,|b\n|,|\"c\"|", ',', '|')
# [["a", "b\n", "\"c\""]]
```

## Testing

Run unit tests:

```sh
$ ruby test/test_csv.rb
```

Run benchmark:

```sh
$ ruby test/test_benchmark.rb
```

Watch unit tests and benchmark:

```sh
$ bundle exec guard
```

## Docs

Generate [YARD](https://yardoc.org) docs:

```sh
$ bundle exec yard doc *.rb
$ open docs/index.html
```

## License

[MIT](LICENSE)
