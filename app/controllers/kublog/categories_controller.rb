module Kublog
  class CategoriesController < ApplicationController
    
    skip_filter :require_admin, :only => [:show]
    
    def show
      @category = Category.find_by_slug!(params[:id])
      @presenter = PostsPresenter.new(@category)
      respond_to do |format|
        format.atom { render "/kublog/posts/index", :layout => false, :content_type => 'text/xml' }
        format.rss  { render "/kublog/posts/index", :layout => false, :content_type => 'text/xml' }
        format.html { render "/kublog/posts/index" }
      end
    end
    
    def create
      @category = Category.new(params[:category])
      respond_to do |format|
        if @category.save
          format.json { render :json => @category }
        else
          format.json { render :json => @category.errors.messages, :status => 'unprocessable_entity' }
        end
      end
    end
    
    def update
      @category = Category.find_by_slug!(params[:id])
      respond_to do |format|
        if @category.update_attributes(params[:category])
          format.json { render :json => @category }
        else
          format.json { render :json => @category.errors.messages, :status => 'unprocessable_entity' }
        end
      end
    end
    
    def destroy
      @category = Category.find_by_slug!(params[:id])
      @category.destroy
      respond_to do |format|
        format.json{ render :json => @category }
      end
    end
    
  end
end
