require 'json'
require 'httparty'

class Api::BookingsController < ApplicationController
  include HTTParty
  before_action :set_booking, only: [:show, :update, :destroy]

  TOKEN = '_9IMg6_2hRUMy2Q-Qyb5qN7x_RiIUaxpW7-xQ8L6HFJ1PmOprnR8IA'
  @base_uri = "https://sandbox.picap.co/api/:url?t=#{TOKEN}"


  # GET /bookings
  def index
    base_uri = "https://sandbox.picap.co/api/third/bookings?t=#{TOKEN}"
    response = HTTParty.get(base_uri)

    render json: response
  end

  # GET /bookings/1
  def show
    base_uri = "https://sandbox.picap.co/api/third/bookings/#{@booking.reference_id}/?t=#{TOKEN}"

    response = HTTParty.get(base_uri, 
    :headers => { 'Content-Type' => 'application/json' } )

    render json: response
  end

  # POST /bookings
  def create
    base_uri = "https://sandbox.picap.co/api/third/bookings?t=#{TOKEN}"

    response = HTTParty.post(base_uri, 
    :body => params.to_json,
    :headers => { 'Content-Type' => 'application/json' } )

    booking_info = JSON.parse response.body
  
    Booking.create(reference_id: booking_info["_id"], payload: booking_info.except!("_id"))

    render json: response
  end

  # PATCH/PUT /bookings/1
  def update
    base_uri = "https://sandbox.picap.co/api/third/bookings/#{@booking.reference_id}/cancel?t=#{TOKEN}"

    response = HTTParty.patch(base_uri, 
    :headers => { 'Content-Type' => 'application/json' } )

    render json: response
  end

  # DELETE /bookings/1
  def destroy
    @booking.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_booking
      @booking = Booking.find(params[:id])
    end
end
