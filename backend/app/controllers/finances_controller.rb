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
    
    all_accounts = all_accounts.as_json
    all_accounts.each do |acct|
      acct.store('slug', acct['name'])
      acct['name'] = acct['name'].titleize
    end
    
    asset_accounts = asset_accounts.as_json
    asset_accounts.each do |acct|
      acct.store('slug', acct['name'])
      acct['name'] = acct['name'].titleize
    end
    
    debt_accounts = debt_accounts.as_json
    debt_accounts.each do |acct|
      acct.store('slug', acct['name'])
      acct['name'] = acct['name'].titleize
    end

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
      acct_name = account['slug']
      these_transactions = User.select('transactions.id,transactions.account_id,transactions.date,transactions.description,transactions.purchase_type_id,transactions.amount,transactions.balance').joins(:transactions).where(id: user).where(:transactions => {:account_id => account['id']})
      account_transactions[acct_name] = these_transactions
    end
    transactions = {'all_transactions' => all_transactions, 'account_transactions' => account_transactions}

    # balances 
    sparse_balances = {}
    account_transactions.each do |acct_name, transactions| 
      sparse_balances_arr = []
      transactions.each do |transaction|
        date = transaction['date']
        balance = transaction['balance']
        balance_hash = { 'date' => date, 'balance' => balance}
        sparse_balances_arr.push(balance_hash)
      end
      sparse_balances[acct_name] = sparse_balances_arr
    end

    filled_balances = {}

    sparse_balances.each do |acct_name, sparse_balances| 
      filled_balances_arr = []
      start_date = sparse_balances[0].as_json['date'].to_datetime
      counter = 0
      last_bal = nil
      debugger
      for date_counter in start_date..Time.now
        # puts counter,sparse_balances[counter],sparse_balances[counter].as_json
        this_bal_obj = sparse_balances[counter].as_json
        if this_bal_obj != nil && this_bal_obj['date'] != nil
          date = this_bal_obj['date'].to_datetime

          loop do
            date_counter == date
            if sparse_balances != nil && sparse_balances[counter] != nil
              balance = sparse_balances[counter].as_json['balance']
              filled_balances_arr.push({'date' => date, 'balance' => balance})
              last_bal = balance
            end
            counter += 1
            this_bal_obj = sparse_balances[counter].as_json

          end
        end
          
        if date_counter != date
          filled_balances_arr.push({'date' => date, 'balance' => last_bal})
        end
        counter += 1
        filled_balances[acct_name] = filled_balances_arr
      end

    end


    balances = {'sparse_balances' => sparse_balances, 'filled_balances' => filled_balances}


    

    finances = {'accounts' => accounts, 'assets' => assets, 'budgets' => budgets, 'transactions' => transactions, 'balances' => balances}
    # render json: finances
    render json: finances
  end 

end