class Comment < ActiveRecord::Base
	#user와 pin은 여러개의 Comment들을 가질 수 있습니다.
  belongs_to :user
  belongs_to :pin
end
