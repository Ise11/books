class BookMailer < ActionMailer::Base

	def book_created(user)
		@user = user
		mail(
			to: @user.email,
			from: "bookappmgr@gmail.com",
			subject: "Dodano nowa ksiazke",
			body: "Dodano nowa ksiazke do bazy."
			)
	end

	def book_rented(user, user2)
		@owner = user2
		@user = user
		mail(
			to: @owner.email,
			from: "bookappmgr@gmail.com",
			subject: "Ktos chce wypozyczyc ksiazke"
			# body: "#{user.email} chce wypozyczyc Twoja ksiazke."
			)
	end
end