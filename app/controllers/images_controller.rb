class ImagesController < ApplicationController
 def index
  @images = Image.all
  respond_to do |format|
      format.html # index.html.erb
  end  
 end

 def show
    @image = Image.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
    end
 end

 def new
    @image = Image.new

    respond_to do |format|
      format.html # new.html.erb
    end
 end
 
 def create
    @image = Image.new(params[:img])
    
    respond_to do |format|
      if @image.save
        format.html { redirect_to @image, :notice => 'Image was successfully uploaded.' }
      end
    end
 end

 def destroy
    @image = Image.find(params[:id])
    @image.destroy
    File.delete("#{Rails.root}/#{Image::Directory}")
    File.delete("#{Rails.root}/#{Image::Resize_directory}")
    respond_to do |format|
      format.html { redirect_to images_url }
    end  
 end
end
