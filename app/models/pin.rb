class Pin < ActiveRecord::Base
	#We init this project by searchkick.
	searchkick
	#We use acts_as_vatable gem.
	acts_as_votable
	#각각의 Pin은 user에 속해있고, 여러 comments를 가질 수 있습니다.
	belongs_to :user
	has_many :comments

	#Paperclip option, Upload 시 medium option을 주면, 사진 파일이 400x400이 되어 저장됩니다.
	has_attached_file :image, styles: { medium: "400x400>" }
	validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
end
