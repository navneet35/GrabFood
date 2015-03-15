class ProductController < ApplicationController
  load_and_authorize_resource


  def try
    puts "can can try"
  end

  def try_harder
    puts "can can try"
  end
end
