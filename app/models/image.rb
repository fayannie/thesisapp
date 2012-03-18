require 'rubygems'
require 'RMagick'

class Image < ActiveRecord::Base
 
 Directory = 'app/assets/images/'
 Resize_directory = 'app/assets/images/resize'
 
 Image.set_primary_key "title"
 validates :title, :uniqueness => true
 
 def img=(file)
   #upload image file to 'app/assets/images'
   name = file.original_filename
   data = file.read
   #directory = 'app/assets/images/'
   path = File.join(Directory,name)
   File.open(path,"wb") { |f| f.write(data) }
   
   @title = self.title = name
   #resize image  
   width, height = 100, 100
   original_image = Magick::Image.read(Directory<<@title).first
   resize_image = original_image.resize(width, height)
   #save resize image
   resize_image.write(Resize_directory<<@title)
  end
end
