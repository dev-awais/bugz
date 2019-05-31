class ProjectsController < ApplicationController

def index
  if current_user.developer?
    @project =  Project.where(id: ProjectsUser.where(user_id: current_user).pluck("project_id"))
    authorize @project
  elsif current_user.manager? 
    @project = current_user.projects.all
    authorize @project
  elsif current_user.qa?
    @project =  Project.where(id: ProjectsUser.where(user_id: current_user).pluck("project_id"))
  end
end

def new
  @project = current_user.projects.new
  authorize @project    
  @developers = User.where(user_type: 'developer')
  @qa = User.where(user_type: 'qa')
end


def create
  @project = current_user.projects.new(post_params)
  authorize @project
  if params[:selected_users].present?
    params[:selected_users].split(",").each do |user|
      @project.users << User.find(user)
    end
  end
  if @project.save
    redirect_to action: 'index'
  else
    render 'new'
  end
end


def show
  @project=Project.find(params[:id])
  @developers = User.where(user_type: 'developer')
  @qa = User.where(user_type: 'qa')
  @selected_developers_qa=@project.users.where(user_type: ['developer','qa']).pluck(:user_id)
end


def edit
  @project=Project.find(params[:id])
  authorize @project
  @developers = User.where(user_type: 'developer')
  @qa = User.where(user_type: 'qa')
  @selected_developers_qa=@project.users.where(user_type: ['developer','qa']).pluck(:user_id)
end


def update
  @project = Project.find(params[:id])
  authorize @project
  @new_selected_users=params[:selected_users].split(",").map! { |i| i.to_s }
  #puts @new_selected_users.class
  @new_selected_users.each do |u|
    ProjectsUser.exists?(project_id: @project,user_id: u)? ProjectsUser.where(project_id: @project,user_id: u).delete_all : @project.users << User.find(u)
  end  
  authorize @project
  if @project.update(post_params)  
    redirect_to action: 'show'
  else
    render 'edit'
  end
end


def destroy
  @project=Project.find(params[:id])
  authorize @project
  @project.destroy
  redirect_to user_projects_path
end


private
  def post_params
    params.require(:project).permit(:name)
  end

   
end
