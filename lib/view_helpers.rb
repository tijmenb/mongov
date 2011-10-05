helpers do

  def flash?
    session[:message]
  end

  def flash
    message = session[:message]
    session[:message] = nil
    message
  end

  def display(value)
    case value
      when NilClass
        label "Nil", :empty
      when BSON::ObjectId
        label value, :id
      when TrueClass, FalseClass
        label value, value
      when Time, Fixnum, Float, Bignum
        code value
      when String
        value.empty? ? label( "empty string", :empty) : format(value)
      when BSON::OrderedHash
        erb :document, :locals => {:d => value}
      when Array
        if value.empty?
          label "empty array", :empty
        elsif value.first.class == BSON::OrderedHash
          erb :embedded_collection, :locals => {:documents => value}
        else
          erb :embedded_list, :locals => {:values => value}
        end
    end
  end

  def code(str)
    "<code>#{str}</code>"
  end

  def format(text)
    text = text.to_str.gsub(/\r\n?/, "\n").gsub(/([^\n]\n)(?=[^\n])/, '\1<br />')
    "<span class='string'>#{text}</span>"
  end

  def label(str, type = :notice)
    "<span class='label mongo #{type.to_s}'>#{str}</span>"
  end

  def title(d)
    d['_id'].nil? ? "" : d['_id'].to_s
  end

end
