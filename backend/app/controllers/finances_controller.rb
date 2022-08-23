class FinancesController < ApplicationController

  # GET /finances/1
  def show    
    user = params[:user]

    # accounts
    all_accounts = User.select('accounts.id,accounts.name,accounts.account_type_id,users.id as user_id,users.email').joins(:accounts).where(id: user)
    asset_acct_id = AccountType.where('name' =>'asset').first.id
    debt_acct_id = AccountType.where('name' =>'debt').first.id
    asset_accounts = all_accounts.where('accounts.account_type_id' => asset_acct_id)
    debt_accounts = all_accounts.where('accounts.account_type_id' => debt_acct_id)
    accounts = {'all_accounts' => all_accounts, 'asset_accounts' => asset_accounts, 'debt_accounts' => debt_accounts}

    # assets
    assets = Asset.where(user_id: user)

    # budgets
    budgets = []
    active_record_budgets = User.select('budgets.id,budgets.value,budgets.purchase_type_id,budgets.user_id,users.email').joins(:budgets).where(id: user)
    active_record_budgets.each do |budget|
      budget = budget.attributes
      purchase_type = PurchaseType.find(budget['purchase_type_id']).name
      budget[:purchase_type] = purchase_type
      budgets.push(budget)
    end

    # transactions
    all_transactions = []
    all_active_record_transactions = User.select('transactions.id,transactions.account_id,transactions.date,transactions.description,transactions.purchase_type_id,transactions.amount,transactions.balance').joins(:transactions).where(id: user)
    all_active_record_transactions.each do |transaction|
      transaction = transaction.attributes
      purchase_type = PurchaseType.find(transaction['purchase_type_id']).name
      account = Account.find(transaction['account_id']).name
      account_type_id = Account.find(transaction['account_id']).account_type_id
      account_type = AccountType.find(account_type_id).name
      transaction[:purchase_type] = purchase_type
      transaction[:account] = account
      transaction[:account_type_id] = account_type_id
      transaction[:account_type] = account_type
      all_transactions.push(transaction)
    end

    account_transactions = {}
    all_accounts.each do |account| 
      acct_name = account.name
      these_transactions = User.select('transactions.id,transactions.account_id,transactions.date,transactions.description,transactions.purchase_type_id,transactions.amount,transactions.balance').joins(:transactions).where(id: user).where(:transactions => {:account_id => account.id})
      account_transactions[acct_name] = these_transactions
    end
    transactions = {'all_transactions' => all_transactions, 'account_transactions' => account_transactions}

    # TODO: add balances to data object
    # TODO: add chart labels/data to data object (30 days, 3 months, 6 months, 12 months, all time)
    

    finances = {'accounts' => accounts, 'assets' => assets, 'budgets' => budgets, 'transactions' => transactions}
    # render json: finances
    render json: finances
  end 

end