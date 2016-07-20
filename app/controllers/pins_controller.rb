class PinsController < ApplicationController
	before_action :find_pin, only: [:show, :edit, :update, :destroy, :upvote]
	#index와 show page는 회원이 아니더라도 볼 수 있습니다.
	before_filter :authenticate_user!, except: [:index, :show]
	before_action :authorized_user, only: [:edit, :update, :destroy]

	def index
		#pin들은 생성된 최근 날짜 순서대로 정렬되며, 페이지당 8개의 요소를 가질 수 있도록 나누어집니다.
		#All pins are reordered by created time every /index call and pagination with 8 pages.
		@pins = Pin.all.order("created_at DESC")
		@pins = @pins.page(params[:page]).per_page(8)
	end

	def show
		#before_action으로 처리.
		#Did by before_action.
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

	#acts_as_votable part. I made only upvote function because I don't need downvote.
	def upvote
		@pin.upvote_by current_user
		redirect_to :back
	end

	#Used by searchkick gem
	#searchkick 잼이 Pin을 찾을 때 사용합니다.
	def search
		if params[:search].present?
			@pins = Pin.search(params[:search])
		else
			@pins = Pin.all
		end
	end


	private
	def pin_params
		params.require(:pin).permit(:title, :description, :image)
	end

	def authorized_user
		@pin = current_user.pins.find_by(id: params[:id])
		redirect_to pins_path, notice: "해당 Pin을 수정할 권한이 없습니다." if @pin.nil?
	end

	def find_pin
		@pin = Pin.find(params[:id])
	end
end
