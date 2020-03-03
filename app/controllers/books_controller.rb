class BooksController < ApplicationController
  before_action :ensure_correct_user, only: [:edit, :update]

    def index
    @book = Book.new
    @books = Book.all #一覧表示するためにBookモデルの情報を全てくださいのall
    puts @books.to_json
  end

  def create
    @book = Book.new(book_params) #Bookモデルのテーブルを使用しているのでbookコントローラで保存する。
    @book.user_id = current_user.id
    if @book.save #入力されたデータをdbに保存する。
      flash[:notice] = "successfully created book!"#保存された場合の移動先を指定。
      redirect_to book_path(@book)
    else
      @books = Book.all
      render 'index'
  end
end

  def show
  	@book = Book.find(params[:id])
    @book_new = Book.new
  end

  def edit
  	@book = Book.find(params[:id])
  end



  def update
  	@book = Book.find(params[:id])
  	if @book.update(book_params)
  		 flash[:notice] =  "successfully updated book!"
       redirect_to book_path(@book.id)
  	else #if文でエラー発生時と正常時のリンク先を枝分かれにしている。
  		render "edit"
  	end
  end

  def destroy
  	@book = Book.find(params[:id])
  	@book.destroy
  	flash[:notice] = "successfully delete book!"
    redirect_to books_path
  end

  def ensure_correct_user
    @book = Book.find(params[:id])
    if @book.user != current_user
      redirect_to books_path
    end
  end

  private

  def book_params
  	params.require(:book).permit(:title, :body)
  end

end
