class BooksController < ApplicationController
  before_action :set_book, only: [:show, :edit, :update, :destroy, :rent]
  before_action :authenticate_user!, exept: [:index, :show]
  # before_action :correct_user, only: [:edit, :update, :destroy]
  before_action only: [:edit, :update, :destroy]

  # GET /books
  # GET /books.json
  def index
    @books = Book.where(["name LIKE ?", "%#{params[:search]}%"])
  end

   def mybooks
      @cu = current_user.id
      @mybooks = Book.all.where("owner_id = #{current_user.id}")
    end

  # GET /books/1
  # GET /books/1.json
  def show
   
    # 
  end

  # GET /books/new
  def new

    # @book = current_user.books.build
    @book = Book.new
    @give = ( [['tak', true], ['nie', false]])

  end

  # GET /books/1/edit
  def edit
    if @book.rent_by_id != nil
    @user = User.find(@book.rent_by_id)
    @options = ([[@user.email, @user.id], ['wolna', nil], ['niedostepna', nil]])
    else
      @options = ( [['wolna', nil], ['niedostepna', '666']])
    end
    @give = ( [['tak', true], ['nie', false]])
  end

  # POST /books
  # POST /books.json
  def create
    @user = current_user
    @book = Book.new(book_params)
    @book.owner = @user
    
    respond_to do |format|
      if @book.save
        BookMailer.book_created(@user).deliver_now
        format.html { redirect_to @book, notice: 'Book was successfully created.' }
        format.json { render :show, status: :created, location: @book }
      else
        format.html { render :new }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /books/1
  # PATCH/PUT /books/1.json
  def update
    if (@book.owner != current_user)
      @book.rent_by = current_user
    end
  # @user = User.find(@book.rent_by_id)
  #   @options = ([[@user.email, @user.id], ['wolna', nil], ['niedostepna', '666']])
 

  #   respond_to do |format|
  #     if @book.update(book_params2)
  #       if (@book.owner != current_user)
  #         BookMailer.book_rented(current_user, @book.owner).deliver
  #       end
  #       format.html { redirect_to @book, notice: 'Book was successfully updated.' }
  #       format.json { render :show, status: :ok, location: @book }
  #     else
  #       format.html { render :edit }
  #       format.json { render json: @book.errors, status: :unprocessable_entity }
  #     end
  #   end

  if (@book.owner != current_user)
     @par = @book.update(book_params2)
  else 
    @par=  @book.update(book_params)
    end

      respond_to do |format|
      if @par
         if (@book.owner != current_user)
          BookMailer.book_rented(current_user, @book.owner).deliver
         end
        format.html { redirect_to @book, notice: 'Pin został zaktualizowany.' }
        format.json { render :show, status: :ok, location: @book }
      else
        format.html { render :edit }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /books/1
  # DELETE /books/1.json
  def destroy
    @book.destroy
    respond_to do |format|
      format.html { redirect_to books_url, notice: 'Book was successfully destroyed.' }
      format.json { head :no_content }
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_book
      @book = Book.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def book_params
      params.require(:book).permit(:author, :name, :category, :description, :owner_id, :rent_by_id, :give)
    end

     def book_params2
      params.permit(:author, :name, :category, :description, :owner_id, :rent_by_id)
    end

    # def correct_user 
    #   @book = current_user.owned.find_by(id: params[:id])
    #   redirect_to books_path, notice: "Nie masz uprawnień do edycji" if @book.nil?
    # end
end
