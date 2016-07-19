class PinsController < ApplicationController
	before_action :find_pin, only: [:show, :edit, :update, :destroy, :upvote]
	before_filter :authenticate_user!, except: [:index, :show]
	before_action :authorized_user, only: [:edit, :update, :destroy]

	# def search
	# 	if params[:search].present?
	# 		@pins = Pin.search(params[:search])
	# 	else
	# 		@pins = Pin.all
	# 	end
	# end

	def index
		@pins = Pin.all.order("created_at DESC")
		@pins = @pins.page(params[:page]).per_page(8)
	end

	def show
	end

	def new
		@pin = current_user.pins.build
	end

	def create
		@pin = current_user.pins.build(pin_params)

		if @pin.save
			redirect_to @pin, notice: "새로운 Pin이 공유되었습니다! =ㅅ=!!"
		else
			render 'new'
		end
	end

	def edit
	end

	def update
		if @pin.update(pin_params)
			redirect_to @pin, notice: "Pin 정보가 수정되었습니다! =ㅅ=!!"
		else
			render 'edit'
		end
	end

	def destroy
		@pin.destroy
		redirect_to root_path, notice: "Pin이 삭제되었습니다...ㅠㅠ;;"
	end

	def upvote
		@pin.upvote_by current_user
		redirect_to :back
	end

	private

	def pin_params
		params.require(:pin).permit(:title, :description, :image)
	end

	def authorized_user
		@pin = current_user.pins.find_by(id: params[:id])
		redirect_to pins_path, notice: "Not authorized to edit this pin" if @pin.nil?
	end

	def find_pin
		@pin = Pin.find(params[:id])
	end
end
