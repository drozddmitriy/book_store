class AddressesController < ApplicationController
  before_action :set_addresses

  def index; end

  def create
    @address = Address.new(address_params)
    @address.addressable = current_user

    if @address.save
      flash.now[:success] = 'Address created!!!'
      redirect_to addresses_path
    else
      flash.now[:danger] = 'Address not created!!!'
      render :index
    end
  end

  def update
    if Address.find(params[:id]).update(address_params)
      flash.now[:success] = 'Address updated!!!'
      redirect_to addresses_path
    else
      flash.now[:danger] = 'Address not updated!!!'
      render :index
    end
  end

  private

  def address_params
    params.require(:address).permit(:firstname, :lastname, :address, :city, :zip, :country, :phone, :cast)
  end

  def set_addresses
    @addresses = current_user.addresses
  end
end
