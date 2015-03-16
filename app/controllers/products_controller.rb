class ProductsController < ApplicationController
  authorize_resource class: false
  def try
    puts "can can try"
  end

  def try_harder
    puts "can can try"
  end

end
