class EncryptionsController < ApplicationController

	def index
		@encryption = Encryption.new
	end

	def create
		@encryption = Encryption.new(encryption_params)

		before = @encryption.message.unpack("C*")
		after = before.map {|char| 
			result = @encryption.shift  + char
			if char < 65 || char > 122 || (char > 90 && char < 97)
				char
			else
				if (result >90 && result < 97)||(result >122)||(result < 65)
=begin
					if (result > 64 && result < 91) || (result > 96 && result < 123) #Upper/Lower-case
						if @encryption.shift > -1
							result += 256
						elsif
							@encryption.shift < 0
							result -= 256
						end
					else
						result += 230
					end
=end
result += 224
				else
					result
				end
			end			
		}
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
