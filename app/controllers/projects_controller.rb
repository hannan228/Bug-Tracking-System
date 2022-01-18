class ProjectsController < ApplicationController
    before_action :set_project, only: [:show, :edit, :destroy, :update]

    def show
        @project = Project.find(params[:id])
    end

    def index
        @project = Project.all
    end

    def new
        @project = Project.new
    end

    
    def create
        @project = Project.new(set_params)
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
        params.require(:project).permit(:title, :description)
    end

    

end