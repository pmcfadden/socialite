class TestLogger
  def self.log message
    puts "TEST LOG: #{message}"
  end
end

class Hash
  def to_s
    keys.collect {|k| "#{k} => #{[k]}"}.join ", "
  end
end
