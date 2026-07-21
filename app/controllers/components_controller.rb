class ComponentsController < ApplicationController
  def index
  end

  def include_fragment
    render layout: false
  end

  def page_preview
  end
end
