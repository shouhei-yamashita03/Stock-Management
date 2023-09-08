class StocksController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @stocks = @user.stocks
  end

  def new
    @user = User.find(params[:user_id])
  end

  def import
    @user = User.find(params[:user_id])
    stocks = Stock.csv_import(params[:file], @user)
    Stock.import(stocks)
    redirect_to root_path, notice: "#{l @user.name, format: :long}の入荷物を登録しました。"
  end
end
