class Csv
  DELIMITER = "\n"
  QUOTE = '"'

  def self.parse(string, separator=',')
    records = []
    fields = []
    field = nil
    is_field_quoted = false

    chars = string.chars
    chars.each_with_index do |char, index|
      prev_char = chars[index - 1]
      next_char = chars[index + 1]

      if is_field_quoted
        if char == QUOTE && (next_char == separator || next_char == DELIMITER || next_char == nil)
          fields.push(field.gsub '""', '"')
          field = nil
          records.push(fields) if next_char == nil || next_char == DELIMITER
        elsif prev_char == QUOTE && (char == separator || char == DELIMITER)
          is_field_quoted = false
        else
          field += char
        end
        next
      elsif char == QUOTE && field == nil
        is_field_quoted = true
        field = ''
        next
      end

      if char == separator && prev_char != QUOTE
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
