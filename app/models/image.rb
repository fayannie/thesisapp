require 'rubygems'
require 'RMagick'

class Image < ActiveRecord::Base
  after_save :save_to_disk
  after_destroy :delete_file 

 def to_param
  "#{id}-#{title}"
 end
 
 def image_file=(file)
   @temp_file = file
   filename = @temp_file.original_filename
   self.title = filename.gsub(/[.]/,'-')
 end

 def save_to_disk
   if @temp_file
      data = @temp_file.read
      directory = 'app/assets/images/'
      path = File.join(directory,self.title)
      File.open(path,"wb") { |f| f.write(data) }
   end
 end
 
 def resize  
   if self.width
     width = self.width
   else
     width = 100
   end
   if self.height
     height = self.height
   else
     height = 100
   end
   @title = self.title
   original_image = Magick::Image.read('app/assets/images/'<<@title).first
   resize_image = original_image.resize(width, height)
   resize_image.write('app/assets/images/resize/'<<@title)
 end
  
 def delete_file
   File.delete("#{Rails.root}/app/assets/images/#{self.title}")
   File.delete("#{Rails.root}/app/assets/images/resize/#{self.title}")
 end
end
