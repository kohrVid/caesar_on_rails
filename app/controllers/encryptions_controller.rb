class EncryptionsController < ApplicationController

	def index
		@encryption = Encryption.new
	end

	def create
		@encryption = Encryption.new(encryption_params)

		before = @encryption.message.unpack("C*")
		after = before.map {|char| (char < 65 || char > 122 || (char > 90 && char < 97)) ? char : (@encryption.shift + char)}
		@code = after.pack("C*")
		if @encryption.save
			render 'index'
		else
			redirect_to root_path
		end
	end


	

	private

		def encryption_params
			 params.require(:encryption).permit(:message, :shift)
		end


end
