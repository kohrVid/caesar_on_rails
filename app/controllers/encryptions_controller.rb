class EncryptionsController < ApplicationController

	def index
		@encryption = Encryption.new
	end

	def create
		@encryption = Encryption.new(encryption_params)
		upper_case = []
		lower_case = []
		(65..90).each do |i|
			upper_case.push(i)
		end
		(97..122).each do |i|
			lower_case.push(i)
		end

		before = @encryption.message.unpack("C*")
		after = before.map {|char| 
			result = @encryption.shift  + char

			if !(upper_case.include?(char) || lower_case.include?(char))
				char
			elsif upper_case.include?(result) || lower_case.include?(result)
				if !( (upper_case.include?(char) && lower_case.include?(result)) || (lower_case.include?(char) && upper_case.include?(result)) )
					result 
				elsif upper_case.include?(char)
					if @encryption.shift < 0
						result + (upper_case[-1] - (upper_case[0]-1))
					else
						result + (upper_case[0] - (upper_case[-1]+1))
					end
				elsif lower_case.include?(char)
					if @encryption.shift < 0
						result + (lower_case[-1] - (lower_case[0]-1))
					else
						result + (lower_case[0] - (lower_case[-1]+1))
					end
				end
			elsif upper_case.include?(char)
				if @encryption.shift < 0
					result + (upper_case[-1] - (upper_case[0]-1))
				else
					result + (upper_case[0] - (upper_case[-1]+1))
				end
			elsif lower_case.include?(char)
				if @encryption.shift < 0
					result + (lower_case[-1] - (lower_case[0]-1))
				else
					result + (lower_case[0] - (lower_case[-1]+1))
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
