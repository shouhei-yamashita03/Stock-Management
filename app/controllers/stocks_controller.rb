class StocksController < ApplicationController
  # 在庫一覧
  def index
    @user = current_user
    @stocks = @user.stocks
  end

  def new
    @user = current_user
  end

  def edit
  end
  
  # def destroy
  #   @user = current_user
  #   @stock.destroy
  #   flash[:success] = "在庫情報を削除しました。"
  #   redirect_to search_result_user_stock_path
  # end
  
  def create
    @user = current_user
    @stock = @user.stocks.build(stock_params)
  
    if @stock.save
      flash[:success] = "在庫が作成されました。"
      redirect_to user_stock_path(@user, @stock)
    else
      render 'new'
    end
  end

  # CSVインポート
  def import
    @user = current_user
    csv_file = params[:file]
    stocks = Stock.csv_import(csv_file, @user) 
  
    if stocks
      flash[:success] = "CSVファイルのインポートに成功しました。"
    else
      flash[:danger] = "CSVファイルのインポートに失敗しました。"
    end
    redirect_to user_stocks_url
  end

  # 在庫検索
  def stock_search
    #@user = User.find(params[:user_id])
    @user = current_user
    # params[:q]はこの後に作成するビューファイルから送られてくるパラメーター
    # ransackメソッドは送られてきたパラメーターを元にテーブルからデータを検索するメソッド
    # resultメソッドはransackメソッドで取得したデータをActiveRecord_Relationのオブジェクトに変換するメソッド
    @q = Stock.ransack(params[:q])
    @results = @q.result
    @result = params[:q]&.values&.reject(&:blank?)
  end

  # 検索結果
  def search_result
    @user = current_user
    @stocks = @user.stocks
  end

  # 在庫詳細
  def stock_detail
    @user = current_user
    @stocks = @user.stocks
  end

  # 検索結果編集
  def edit_search_result
    @user = current_user
    @stock = @user.stocks.find(params[:user_id])
    @user_stocks = @user.stocks
  end

  def update_search_result
    @user = current_user
    @stock = @user.stocks.find(params[:id])
    if @stock.update_attributes(search_result_params)
      flash[:success] = "更新しました。"
    else
      flash[:danger] = "更新は失敗しました。"
    end
    redirect_to search_result_user_stock_url
  end

  # 在庫詳細編集
  def edit_stock_detail
    @user = current_user
    @stock = @user.stocks.find(params[:user_id])
    @user_stocks = @user.stocks
  end

  def update_stock_detail
    @user = current_user
    @stock = @user.stocks.find(params[:id])
    if @stock.update_attributes(stock_detail_params)
      flash[:success] = "更新しました。"
    else
      flash[:danger] = "更新は失敗しました。"
    end
    redirect_to stock_detail_user_stock_url

  end

  def destroy_stock_detail
    @user = current_user
    @stock = @user.stocks.find(params[:user_id])
    @stock.destroy
    flash[:success] = "在庫詳細情報を削除しました。"
    redirect_to search_result_user_stock_url(@stock)
  end

  private

  def stock_params
    params.require(:stock).permit(:display_number, :category_name, :stock_name, :stock_description, :quantity, :user_id, :price)
  end

  def search_result_params
    params.require(:stock).permit(:display_number, :category_name, :stock_name, :stock_description, :price, :quantity)
  end

  def stock_detail_params
    params.require(:stock).permit(:category_name, :stock_name, :stock_description)
  end
end
