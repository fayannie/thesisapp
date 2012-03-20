require 'rubygems'
require 'RMagick'

class Image < ActiveRecord::Base

 def to_param
  "#{id}-#{title}"
 end
 
 #upload image file to 'app/assets/images'
 def image_file=(file)
   filename = file.original_filename
   name = filename.gsub(/[.]/,'-')
   data = file.read
   directory = 'app/assets/images/'
   path = File.join(directory,name)
   File.open(path,"wb") { |f| f.write(data) }
   self.title = name
 end
 
 #resize image 
 def resize  
   width, height = 100, 100
   @title = self.title
   original_image = Magick::Image.read('app/assets/images/'<<@title).first
   resize_image = original_image.resize(width, height)
   resize_image.write('app/assets/images/resize/'<<@title)
 end
  
  def after_destroy
   File.delete("#{Rails.root}/app/assets/images/#{self.title}")
   File.delete("#{Rails.root}/app/assets/images/resize/#{self.title}")
  end
end
