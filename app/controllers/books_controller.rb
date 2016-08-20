class BooksController < ApplicationController
  before_action :set_book, only: [:show, :edit, :update, :destroy, :rent]
  before_action :authenticate_user!, exept: [:index, :show]
  # before_action :correct_user, only: [:edit, :update, :destroy]
  before_action only: [:edit, :update, :destroy]
  helper_method :rent

  # GET /books
  # GET /books.json
  def index
    @books = Book.where(["name OR author LIKE ?", "%#{params[:search]}%"])
    # @books = Book.search(params[:search])
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
  end

  # GET /books/1/edit
  def edit
  
  end

  # POST /books
  # POST /books.json
  def create
    @book = Book.new(book_params)
    @book.owner = current_user

    respond_to do |format|
      if @book.save
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
    respond_to do |format|
      if @book.update(book_params2)
        format.html { redirect_to @book, notice: 'Book was successfully updated.' }
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

   def rent
        @book.rent_by = current_user
    end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_book
      @book = Book.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def book_params
      params.require(:book).permit(:author, :name, :category, :description, :owner_id, :rent_by_id)
    end

     def book_params2
      params.permit(:author, :name, :category, :description, :owner_id, :rent_by_id)
    end

    # def correct_user 
    #   @book = current_user.owned.find_by(id: params[:id])
    #   redirect_to books_path, notice: "Nie masz uprawnień do edycji" if @book.nil?
    # end
end
