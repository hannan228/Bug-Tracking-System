class ProjectsController < ApplicationController
    before_action :set_project, only: [:show, :edit, :destroy, :update]
   
    rescue_from CanCan::AccessDenied do |exception|
        redirect_to projects_url, :alert => exception.message
    end

    def show
        @project = Project.find(params[:id])
        authorize! :read, @project
    end

    def index
      if current_user
        if current_user.manager?
            @project = Project.where(user_id: current_user)
        elsif current_user.qa?
            @project = Project.where(qa_id: current_user)
        elsif current_user.developer?
            @project = Project.where(developer_id: current_user)
        end
      end
    end

    def new
        @project = Project.new
        authorize! :create, @project
    end

    def edit
        @project = Project.find(params[:id])
        authorize! :update, @project
    end

    
    def create
        @user = current_user

        @project = @user.projects.build(set_params)
        if @project.save
        flash[:notice] = "Project was created successfully."
        redirect_to project_path(@project)
      else
          render :new, status: :unprocessable_entity 
      end
    end

    def update
        if @project.update(set_params)
          flash[:notice] = "Project is updated successfully."
          redirect_to project_path(@project)
        else
            render :edit, status: :unprocessable_entity 
        end
    end

    def set_project
        @project = Project.find(params[:id])
    end

    def set_params
        params.require(:project).permit(:title, :description, :qa_id, :developer_id)
    end

    def destroy
        @project.destroy
        redirect_to projects_path
    end
    

end