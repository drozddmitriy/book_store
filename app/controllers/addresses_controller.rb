class AddressesController < ApplicationController
  load_and_authorize_resource

  def index; end

  def create
    @address = Address.new(address_params)
    @address.addressable = current_user

    if @address.save
      flash[:success] = I18n.t('controllers.addresses.address_created')
      redirect_to addresses_path
    else
      flash[:danger] = I18n.t('controllers.addresses.address_not_created')
      render :index
    end
  end

  def update
    @address = Address.find(params[:id])

    if @address.update(address_params)
      flash[:success] = I18n.t('controllers.addresses.address_updated')
      redirect_to addresses_path
    else
      flash[:danger] = I18n.t('controllers.addresses.address_not_updated')
      render :index
    end
  end

  private

  def address_params
    params.require(:address).permit(:firstname, :lastname, :address, :city, :zip, :country, :phone, :cast)
  end
end
