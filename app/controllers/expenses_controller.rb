class ExpensesController < ApplicationController
  before_filter :authenticate_user!, :check_items

  def index
    @this_month_items = Item.where('extract(month from purchase_date) = ? AND extract(year from purchase_date) = ? AND user_id = ?',
                                     Date.today.month, Date.today.year,  current_user.id)

    @this_month_expense = @this_month_items.sum("price")

    lifetime_expenses = Item.where(user_id: current_user.id)
    @lifetime_expenses = lifetime_expenses.sum("price")

    #Search by month
    get_date_limit
    @the_date = nil
    if params[:search_month]
      @the_date = get_last_date(expense_params)
      @searched_month = Item.search_month(params[:search_month], current_user.id)
      @searched_month_expense = @searched_month.sum("price")
    end


  end

  private
  def get_last_date(date)
    year = date["(1i)"]
    month = date["(2i)"]
    return Date.parse(year + '-' + month + '-1')
  end

  def get_date_limit
    oldest_item = Item.where(user_id: current_user.id).order("purchase_date").first
    oldest_item_date = oldest_item.purchase_date
    newest_item = Item.where(user_id: current_user.id).order("purchase_date").last
    newest_item_date = newest_item.purchase_date
    @newest_year = newest_item_date.year
    @oldest_year = oldest_item_date.year
  end

  def expense_params
    params.require(:search_month)
  end
end
