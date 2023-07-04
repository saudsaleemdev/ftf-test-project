module Resourceable
  extend ActiveSupport::Concern

  included do
    before_action :find_resource, only: %i[edit update destroy show]
  end

  def index
    @resources = if paginate?
                   policy_scope(klass).page(params[:page])
                 else
                   policy_scope(klass)
                 end
    authorize klass
  end

  def show
    respond_to do |format|
      format.html
    end
  end

  def edit; end

  def update
    if @resource.update(resource_params)
      redirect_to redirect_to_path, notice: "Updated"
    else
      render :edit
    end
  end

  def new
    @resource = klass.new
    authorize @resource
    get_props
    respond_to do |format|
      format.html
    end
  end

  def create
    @resource = klass.new(resource_params)
    @resource.company = current_user.company if @resource.respond_to?(:company_id)
    authorize @resource
    if @resource.save
      redirect_to redirect_to_path, notice: "Created"
    else
      render :new
    end
  end

  def destroy
    @resource.destroy
    redirect_to [controller_name.to_sym], notice: "Deleted"
  end

  private

  def find_resource
    @resource = if klass.respond_to?(:friendly_id) && !klass.respond_to?(:use_id)
                  policy_scope(klass).friendly.find(params[:id])
                else
                  policy_scope(klass).find(params[:id])
                end
    authorize @resource
    get_props
  end

  def get_props
    return unless get_props?

    @props = JSON.parse(render_to_string("api/#{controller_name}/show"))
  end

  def redirect_to_path
    @resource
  end

  def get_props?
    # false by default, turn in on controller
    false
  end

  def klass
    controller_name.singularize.camelize.constantize
  end

  def klass_name
    klass.to_s
  end

  def resource_name
    controller_name.singularize
  end

  def resource_params
    params.require(resource_name).permit(*policy(klass.new).permitted_attributes)
  end

  def paginate?
    false
  end
end
