class BugsController < ApplicationController
   before_action :set_project, only: [:new,:edit,:show,:index,:create,:update]
     #around_action :wrap_in_transaction, only: :show

  def index
    if current_user.manager?
      if(params[:project_id]).length>1
        @bugs=Bug.where(project_id: ProjectsUser.where(user_id: current_user).pluck("project_id"))
        authorize @bugs
      else
        @bugs =Bug.where(project_id: params[:project_id])
        authorize @bugs
      end
    elsif current_user.developer?
      if(params[:project_id]).length>1
        @bugs=Bug.where(project_id: ProjectsUser.where(user_id: current_user).pluck("project_id"))
        authorize @bugs
      else
        @bugs =Bug.where(project_id: params[:project_id])
        authorize @bugs
      end
    elsif current_user.qa?
      if(params[:project_id]).length>1
        @bugs=Bug.where(project_id: ProjectsUser.where(user_id: current_user).pluck("project_id"))
        authorize @bugs
      else
        @bugs =Bug.where(project_id: params[:project_id])
        authorize @bugs
      end
    end
  end


  def new
    @bug = Bug.new
    authorize @bug
  end


  def create
    @bug = Bug.new(post_params)
    authorize @bug
    @bug.project = @project
    @bug.user = current_user 
    if @bug.save!
      redirect_to user_project_bugs_path
    else
      render 'new'
    end
  end


  def show
    @bug=Bug.find(params[:id])
    @assign_developer =  User.where(id: Bug.find(@bug.id).assign_to).pluck('name')
    @users= User.where(user_type: "developer")
  end


  def edit
    @bug=Bug.find(params[:id])
    authorize @bug
  end


  def update
    @bug=Bug.find(params[:id])
    authorize @bug
    if current_user.developer?
      if @bug.update(bug_update_params)
        redirect_to user_project_bug_path(current_user,@project)
      else
        render 'show'
      end
    elsif current_user.manager? 
      if current_user.id == params[:bug][:assign_to].to_i
          render 'show'
      else
        if  @bug.update(bug_update_params)
          if ProjectsUser.exists?(project_id: @bug.project_id,user_id: @bug.assign_to)
            redirect_to user_project_bug_path(current_user,@project)
          else
            ProjectsUser.create(project_id: @bug.project_id,user_id: @bug.assign_to )
            redirect_to user_project_bug_path(current_user,@project)
          end
        else
          render 'show'
        end
      end
    end
  end


  private
 
    def post_params
      params.require(:bug).permit(:title,:deadline,:screenshot,:bug_type,:status,:description)
    end

    def bug_update_params
      params.require(:bug).permit(:status,:assign_to)
    end

    def set_project
      @project= Project.find(params[:project_id])
    end
    
end
