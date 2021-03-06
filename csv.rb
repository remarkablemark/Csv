# An interface for parsing CSV.
#
# @author Menglin "Mark" Xu
# @abstract
# @see https://tools.ietf.org/html/rfc4180 The CSV spec.
class Csv
  DELIMITER = "\n"

  # Parses a CSV string into its array equivalent.
  #
  # @example Parse CSV string with defaults
  #   Csv.parse('a,b') #=> [["a", "b"]]
  #
  # @example Parse CSV string with custom separator
  #   Csv.parse("a\tb", "\t") #=> [["a", "b"]]
  #
  # @example Parse CSV string with custom quote
  #   Csv.parse('|a|,|b|', ',', '|') #=> [["a", "b"]]
  #
  # @param [String] string The CSV string.
  # @param [String] separator The character to divide each field.
  # @param [String] quote The character to denote quoted field.
  # @return [Array] The CSV formatted as an array.
  def self.parse(string, separator=',', quote='"')
    raise ArgumentError, 'unclosed quote' if string.count(quote) % 2 != 0

    records = []
    fields = []
    field = nil
    is_field_quoted = false

    chars = string.chars
    chars.each_with_index do |char, index|
      prev_char = chars[index - 1]
      next_char = chars[index + 1]

      if is_field_quoted
        if char == quote && (next_char == separator || next_char == DELIMITER || next_char == nil)
          # replace 2 quotes with 1 quote in field
          fields.push(field.gsub quote * 2, quote)
          field = nil
          if next_char == nil || next_char == DELIMITER
            records.push(fields)
            fields = []
          end
        elsif prev_char == quote && (char == separator || char == DELIMITER)
          is_field_quoted = false
        else
          field += char
        end
        next
      elsif char == quote && field == nil
        is_field_quoted = true
        field = ''
        next
      end

      if char == separator && prev_char != quote
        fields.push(field)
        field = nil
        # ensure empty field is added at line break or end
        fields.push(field) if next_char == DELIMITER || next_char == nil

      elsif char == DELIMITER
        records.push(fields)
        fields = []

      else
        field == nil ? field = char : field += char
        if next_char == DELIMITER
          fields.push(field)
          field = nil
        end
      end

      if next_char == nil
        fields.push(field) if field
        records.push(fields) if fields.length > 0
      end
    end

    records
  end
end
