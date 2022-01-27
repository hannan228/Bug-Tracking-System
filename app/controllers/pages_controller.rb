class PagesController < ApplicationController
  def home
    
    @bug = Bug.all
    if current_user
      if current_user.manager?
          @project = Project.where(user_id: current_user)

          project1 = Project.where(user_id: current_user)
          @bug = Bug.where(project_id: project1)
      elsif current_user.qa?
          @project = Project.where(qa_id: current_user)
          @bug = Bug.where(user_id: current_user)
      elsif current_user.developer?
          @project = Project.where(developer_id: current_user)

          project1 = Project.where(developer_id: current_user)
          @bug = Bug.where(project_id: project1)
      end
    end

  end
end
