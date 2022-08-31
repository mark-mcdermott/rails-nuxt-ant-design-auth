class BudgetsController < ApplicationController 

  # POST '/budgets/:user_id/:budget_name/:budget_value'
  def create_budget
    # new_budget = Budget.create(:category_id => category_id, :user_id => params[:user_id], :value => params[:budget_value])
    # new_budget.save!

    # if category already exists, just create the budget
    if PurchaseType.find_by name: params[:budget_name]
      puts '1'
      purchase_type = PurchaseType.find_by name: params[:budget_name]
      purchase_type_id = purchase_type.id

      # check if user already has a budget with this purchase type
      found = false
      user_budgets = Budget.where(user_id: params[:user_id])
      user_budgets.each do |budget|
        this_purchase_type_id = budget.purchase_type_id
        if this_purchase_type_id == purchase_type_id
          puts '2'
          found = true
        end
      end
      if !found
        puts '3'
        new_budget = Budget.create(:purchase_type_id => purchase_type_id, :value => params[:budget_value], :user_id => params[:user_id])
        new_budget.save!
      end
      # user_budget_of_same_purchase_type_json = user_budget_of_same_purchase_type.as_json
      # if Budget.find_by(user_id: params[:user_id], purchase_type_id: purchase_type_id).nil?
      #   puts 'no length'
      # else
      #   puts 'length'
      # end

      # user_budget_of_same_purchase_type = Budget.find_by(user_id: params[:user_id], purchase_type_id: purchase_type_id)
      # user_budget_of_same_purchase_type_json = user_budget_of_same_purchase_type.as_json
      # if Budget.find_by(user_id: params[:user_id], purchase_type_id: purchase_type_id).nil?
      #   puts 'no length'
      # else
      #   puts 'length'
      # end
      #   puts 'found'
      # else
      #   puts 'not found'
      # end
      # puts 'ni'
      # puts user_budget_of_same_purchase_type
      #   new_budget = Budget.create(:purchase_type_id => purchase_type_id, :value => params[:budget_value], :user_id => params[:user_id])
      #   new_budget.save!

      # else
      #   puts 'user already has a this budget'
      #   render json: 'user already has this budget'
      # end


    else
      puts '4'
    #   # if category is new, create the category and then create the budget
    #   new_purchase_type = PurchaseType.create(:name => params[:budget_name])
    #   new_category.save!
    #   new_category = Category.find_by name: params[:budget_name]
    #   new_category_id = new_category.id
    #   new_budget = Budget.create(:category_id => new_category_id, :user_id => params[:user_id], :value => params[:budget_value])
    #   new_budget.save!
    end
    render json: 'hi'
  end

  # PUT '/budgets/:budget_id/:budget_name/:budget_value
  def edit_budget

    # if category already exists, just get category id 
    # if Category.find_by name: params[:budget_name]
    #   category = Category.find_by name: params[:budget_name]
    #   category_id = category.id
    # # if category does not exist, create it
    # else
    #   new_category = Category.create(:name => params[:budget_name])
    #   new_category.save!
    #   new_category = Category.find_by name: params[:budget_name]
    #   category_id = new_category.id
    # end
    #
    # # update the budget record
    # budget = Budget.find(params[:budget_id])
    # budget.category_id = category_id
    # budget.value = params[:budget_value]
    # budget.save!

  end

  # THIS WORKS # TODO DELTE THIS LINE
  # DELETE '/budgets/:budget_id'
  def destroy_budget
    budget = Budget.find params[:budget_id]
    budget.destroy
    render json: 'budget successfully deleted'
  end

  # GET '/budgets/:user_id'
  def find_budgets

    # get the budgets with the correct category names
    budgets = Budget.where(:user_id => params[:user_id]);
    budgets_arr = []
    purchase_type_ids_arr = []

    # get purchase type names
    budgets.each do |budget|
      purchase_type_id = budget.purchase_type_id
      purchase_type = PurchaseType.find(purchase_type_id);
      id = budget.id
      lower_case_name = purchase_type.name
      name = lower_case_name.capitalize
      value = budget.value
      purchase_type_id = budget.purchase_type_id
      budget_hash = { 'id' => id, 'name' => name, 'value' => value, 'purchase_type_id' => purchase_type_id }
      budgets_arr.push(budget_hash)
      if purchase_type_ids_arr.exclude?(purchase_type_id)
        purchase_type_ids_arr.push(purchase_type_id)
      end
    end

    # get spent amounts from sum of transaction amounts by category
    
    # get all transactions where transactions.user_id = user_id
    transactions = Transaction.where(:user_id => params[:user_id], :date => Date.today.at_beginning_of_month..Date.today);
    # transactions = Transaction.all

    purchase_type_ids_arr.each do |category_id|
      category_sum = 0
      transactions.each do |transaction|
        if (transaction.category_id == category_id)

        end
      end
    end

    render json: budgets # TODO: Remove this line

    # transactions = Transaction.where(:user_id => params[:user_id], );
    #                Author.joins("INNER JOIN books ON books.author_id = authors.id AND books.out_of_print = FALSE")

    ## from those, get array of array of objects where each subarray is a category and each object is a transaction in that category


    # render json: transactions
    #render json: budgets_arr
  end

  # GET '/budgets/last-used-id
  def find_last_used_id
    budgets = Budget.all 
    last_budget = budgets.last 
    last_budget_id = last_budget.id
    render json: last_budget_id
  end

end