class Article
attr_accessor :title, :body

# Định nghĩa validates bằng tay
def self.validates(field, options)
  # Lưu lại thông tin validate vào class
  @validations ||= []
  @validations << { field: field, options: options }
end

def self.validations
  @validations || []
end

def initialize(title, body)
  @title = title
  @body = body
end

def valid?
  @errors = []
  
  self.class.validations.each do |validation|
    field = validation[:field]
    options = validation[:options]
    
    # Kiểm tra validate cho mỗi trường
    value = send(field)  # Gọi phương thức tương ứng với trường (title, body)
    
    if options[:presence] && (value.nil? || value.strip.empty?)
      @errors << "#{field.capitalize} can't be blank"
    end

    if options[:length] && options[:length][:minimum] && value.length < options[:length][:minimum]
      @errors << "#{field.capitalize} is too short (minimum is #{options[:length][:minimum]} characters)"
    end
  end

  @errors.empty?
end

def errors
  @errors
end
end

# Định nghĩa các validate trong class Article
Article.validates :title, presence: true
Article.validates :body, presence: true, length: { minimum: 10 }

# Tạo một instance của Article
article = Article.new("", "Short")

# Kiểm tra tính hợp lệ của đối tượng
puts article.valid?   # => false, vì title trống và body quá ngắn
puts article.errors   # => ["Title can't be blank", "Body is too short (minimum is 10 characters)"]
