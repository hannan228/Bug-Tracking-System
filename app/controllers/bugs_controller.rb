class BugsController < ApplicationController

    
    rescue_from CanCan::AccessDenied do |exception|
        redirect_to bugs_url, :alert => exception.message
    end
    
    before_action :set_bug, only: [:show, :edit, :destroy, :update]

    def show
        @bug = Bug.find(params[:id])
    end

    def index
        @bug = Bug.all
    end

    def new
        @bug = Bug.new
        authorize! :create, @bug
    end
    def edit
        @bug = Bug.find(params[:id])
        authorize! :update, @bug
    end
    
    def create

        @user = current_user
        @bug = @user.bugs.build(set_params)
        if @bug.save
            flash[:notice] = "Bug was created successfully."
            redirect_to bug_path(@bug)
        else
            render :new, status: :unprocessable_entity 
        end
    end

    def update
        if @bug.update(set_params)
          flash[:notice] = "Bug is updated successfully."
          redirect_to bug_path(@bug)
        else
            render :edit, status: :unprocessable_entity 
        end
    end

    def destroy
        @bug.destroy
        params[:id] = nil
        redirect_to bugs_path
    end

    def set_bug
        @bug = Bug.find(params[:id])
    end

    def set_params
        params.require(:bug).permit(:title, :description, :screenshot, :bug_type, :bug_status, :feature_status, :deadline, :image,:project_id)
    end

end