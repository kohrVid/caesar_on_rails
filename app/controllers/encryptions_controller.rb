class EncryptionsController < ApplicationController

	def index
		@encryption = Encryption.new
	end

	def create
		@encryption = Encryption.new(encryption_params)

		before = @encryption.message.unpack("C*")
		after = before.map {|char| (char.to_i < 65 || char.to_i > 122 || (char.to_i > 90 && char.to_i < 97)) ? char.to_i : (@encryption.shift.to_i + char.to_i)}
		@code = after.pack("C*")
		if @encryption.save
			render 'index'
		else
			render 'index'
		end
	end


#	def show
		#@encryption = Encryption.find(params[:id])

#	end

#	def update
#	end
	

	private

		def encryption_params
			 params.require(:encryption).permit(:message, :shift)
		end


end
