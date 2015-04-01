class Admin::ProjectsController < Admin::BaseController
  
  # GET /projects/new
  def new
    @project = Project.new
  end

# POST /projects
  # POST /projects.json
  def create
    @project = Project.new(project_params)

    if @project.save
      flash[:notice] = "Project has been created."

      redirect_to @project
    else
      flash.now[:alert] = "Project has not been created."

      render "new"
    end
  end
  

  # DELETE /projects/1
  # DELETE /projects/1.json
  def destroy
    @project = Project.find(params[:id])
    @project.destroy
    respond_to do |format|
      format.html { redirect_to projects_url, notice: 'Project has been successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  
  private 
  def project_params
      params.require(:project).permit(:name, :description)
  end
end
