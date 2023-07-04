class AccountsController < ApplicationController
  include Resourceable


  def update
    if @resource.update(resource_params)
      redirect_to [controller_name], notice: "Successfully Updated #{klass_name}"
    else
      render :edit
    end
  end

  def create
    @resource = klass.new(resource_params)
    authorize @resource
    @resource.organization = current_user.organization
    if @resource.save
      redirect_to @resource, notice: "Successfully created #{klass_name}"
    else
      render :new
    end
  end
end