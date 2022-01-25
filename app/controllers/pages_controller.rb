class PagesController < ApplicationController
  def home
    @bug = Bug.all
    @project = Project.all
  end
end
