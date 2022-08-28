require 'money-rails'

class FinancesController < ApplicationController

  def dollar_amt(num)
    ActiveSupport::NumberHelper.number_to_currency(num, precision: 0)
  end

  # takes in string like '$35,349.32' and returns $35,349
  def round_cur_str(str)
    rounded_float = Money.new(Monetize.parse(str)).to_f.round
    rounded_cur_str = helpers.humanized_money_with_symbol rounded_float
    rounded_cur_str
  end

  # takes in the end_balances object and runs the sum of the checking end balances. will have to be refactored for customization - it's hardcoded my account names for now
  def get_checking_sum_end_balance(end_balances)
    sum = 0
    end_balances.each do |end_balance_acct|
      this_end_balance = end_balance_acct[1]
      sum += Monetize.parse(this_end_balance) # TODO: THIS IS PROBABLY AN ERROR - SHOULD PROBABLY BE sum += Monetize.parse(this_end_balance * 100)
    end
    money_obj = Money.new(sum)
    helpers.humanized_money_with_symbol money_obj
  end

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
    assets = []
    assets_active_record_arr = Asset.where(user_id: user)
    assets_active_record_arr.each do |asset_active_record|
      asset_hash = asset_active_record.as_json
      value = asset_hash['value']
      dollar_str = dollar_amt(value)
      dollar_str_k = dollar_str
      dollar_str_k[-4..-1] = 'k'
      asset_hash[:dollar_amt] = dollar_str
      asset_hash[:dollar_amt_k] = dollar_str_k
      assets.push(asset_hash)
    end

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
    # "sparse balances" are straight from the transactions list - it can skip days and there can be multiple balances on one day
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

    # "filled balances" are sparse balances, but whenever dates are skipped it fills in each skipped day with the last balance used. filled balances have a balance for everyday, but there can also be multiple balances on one day
    filled_balances = {}
    sparse_balances.each do |acct_name, sparse_balance_acct|
      filled_balances_arr = []
      start_date = sparse_balance_acct[0].as_json['date'].to_datetime
      sparse_bal_counter = 0
      last_bal = nil

      for date_counter in start_date..Time.now

        # if date_counter date is missing, use last balance
        if date_counter != sparse_balance_acct[sparse_bal_counter].as_json['date'].to_datetime
          filled_balances_arr.push({'date'=>date_counter, 'balance'=>last_bal})
          # puts date_counter.to_s + ': ' + last_bal

        # otherwise use date_counter balance
        else
          filled_balances_arr.push({'date'=>sparse_balance_acct[sparse_bal_counter].as_json['date'].to_datetime, 'balance'=>sparse_balance_acct[sparse_bal_counter].as_json['balance']})
          # puts sparse_balance_acct[sparse_bal_counter].as_json['date'] + ': ' + sparse_balance_acct[sparse_bal_counter].as_json['balance']
          last_bal = sparse_balance_acct[sparse_bal_counter].as_json['balance']
          sparse_bal_counter += 1
        end

        # if next date is also the same as date_counter, start a loop to get all balances of same day
        while sparse_balance_acct[sparse_bal_counter] != nil && sparse_balance_acct[sparse_bal_counter].as_json['date'].to_datetime == date_counter
          filled_balances_arr.push({'date'=>date_counter, 'balance'=>sparse_balance_acct[sparse_bal_counter].as_json['balance']})
          last_bal = sparse_balance_acct[sparse_bal_counter].as_json['balance']
          # puts date_counter.to_s + ': ' + sparse_balance_acct[sparse_bal_counter].as_json['balance']
          sparse_bal_counter += 1
        end

        # break out of for if no more dates (ie, if dates end before today's date)
        if sparse_balance_acct.length == sparse_bal_counter
          break
        end

      end

      filled_balances[acct_name] = filled_balances_arr
    end

    # end balances only have the final balance (most recent balance from filled_balances)
    end_balances_all_accounts = {}
    filled_balances.each do |acct_name, filled_balance_acct|
      end_balance = filled_balance_acct.last['balance']
      end_balances_all_accounts[acct_name] = end_balance
    end

    # will have to be refactored for customization eventually (right now if the account isn't named checking_free_checking or credit, this won't work)
    end_balance_main_checking = round_cur_str(end_balances_all_accounts['checking_free_checking'])
    end_balance_main_credit_card = round_cur_str(end_balances_all_accounts['credit'])
    end_balance_nestegg = round_cur_str(end_balances_all_accounts['checking_nestegg'])
    end_balance_all_checking = round_cur_str(get_checking_sum_end_balance(end_balances_all_accounts))

    end_balances = { 'all_accounts' => end_balances_all_accounts, 'main_checking' => end_balance_main_checking, 'main_credit_card' => end_balance_main_credit_card, 'nestegg' => end_balance_nestegg, 'all_checking' => end_balance_all_checking}

    # daily balances are filled balances, but there is only ever one balance per day. If filled_balances has more than one balance for a day, only the last of the day is in daily_balances
    daily_balances = {}
    filled_balances.each do |acct_name, filled_balance_acct|
      daily_balances_arr = []
      counter = 0
      while counter < filled_balance_acct.length
        date = filled_balance_acct[counter]['date']

        # get next balance's date
        next_date = counter == filled_balance_acct.length-1 ? nil : filled_balance_acct[counter + 1]['date']

        # while next balance's date is the same as this balance's date, go to next date
        while next_date == date
          counter += 1
          date = filled_balance_acct[counter]['date']

          # if counter is at last index, use nil for next_date, else use actual next date
          next_date = counter == filled_balance_acct.length-1 ? nil : filled_balance_acct[counter + 1]['date']
        end
        daily_balances_arr.push({ 'date' =>  filled_balance_acct[counter]['date'], 'balance' => filled_balance_acct[counter]['balance']})
        counter += 1
      end
      daily_balances[acct_name] = daily_balances_arr
    end

    # weekly/bimonthly/monthly balances
    weekly_balances = {}
    bimonthly_balances = {}
    monthly_balances = {}
    daily_balances.each do |acct_name, daily_balance_acct|
      weekly_balances_arr = []
      bimonthly_balances_arr = []
      monthly_balances_arr = []
      daily_balance_acct.each_with_index do |balance_obj|
        date = balance_obj['date']
        day = date.strftime("%d").to_i
        if day == 1
          weekly_balances_arr.push(balance_obj)
          bimonthly_balances_arr.push(balance_obj)
          monthly_balances_arr.push(balance_obj)
        elsif day == 15
          weekly_balances_arr.push(balance_obj)
          bimonthly_balances_arr.push(balance_obj)
        elsif day == 8 || day == 22 || day == 29
          weekly_balances_arr.push(balance_obj)
        end
      end
      weekly_balances[acct_name] = weekly_balances_arr
      bimonthly_balances[acct_name] = bimonthly_balances_arr
      monthly_balances[acct_name] = monthly_balances_arr
    end

    # balances by duration

    # 30 day daily balances
    thirty_day_daily_balances = {}
    daily_balances.each do |acct_name, daily_balance_acct|
      thirty_day_daily_balances_arr = []
      thirty_days_ago = Date.today - 30.days
      daily_balance_acct.each_with_index do |balance_obj|
        date = balance_obj['date']
        if date > thirty_days_ago
          thirty_day_daily_balances_arr.push(balance_obj)
        end
      end
      thirty_day_daily_balances[acct_name] = thirty_day_daily_balances_arr
    end

    # 30 day weekly, 3 month daily/weekly/bimonthly
    thirty_day_weekly_balances = {}
    three_month_daily_balances = {}
    three_month_weekly_balances = {}
    three_month_bimonthly_balances = {}

    one_year_daily_balances = {}
    one_year_weekly_balances = {}
    one_year_bimonthly_balances = {}
    one_year_monthly_balances = {}

    daily_balances.each do |acct_name, daily_balance_acct|
      thirty_day_weekly_balances_arr = []
      three_month_daily_balances_arr = []
      three_month_weekly_balances_arr = []
      three_month_bimonthly_balances_arr = []
      one_year_daily_balances_arr = []
      one_year_weekly_balances_arr = []
      one_year_bimonthly_balances_arr = []
      one_year_monthly_balances_arr = []
      thirty_days_ago = Date.today - 30.days
      three_months_ago = Date.today - 90.days
      one_year_ago = Date.today - 365.days
      daily_balance_acct.each_with_index do |balance_obj|
        date = balance_obj['date']
        day = date.strftime("%d").to_i
        day_minus_1 = day - 1

        if date > thirty_days_ago
          if day_minus_1 % 7 == 0
            thirty_day_weekly_balances_arr.push(balance_obj)
          end
        end

        if date > three_months_ago
          three_month_daily_balances_arr.push(balance_obj)
          day_minus_1 = day - 1
          if day_minus_1 % 7 == 0
            three_month_weekly_balances_arr.push(balance_obj)
          end
          if day == 1 or day == 15
            three_month_bimonthly_balances_arr.push(balance_obj)
          end
        end

        if date > one_year_ago
          one_year_daily_balances_arr.push(balance_obj)
          day_minus_1 = day - 1
          if day_minus_1 % 7 == 0
            one_year_weekly_balances_arr.push(balance_obj)
          end
          if day == 1
            one_year_bimonthly_balances_arr.push(balance_obj)
            one_year_monthly_balances_arr.push(balance_obj)
          end
          if day == 15
            one_year_bimonthly_balances_arr.push(balance_obj)
          end
        end

      end
      thirty_day_weekly_balances[acct_name] = thirty_day_weekly_balances_arr
      three_month_daily_balances[acct_name] = three_month_daily_balances_arr
      three_month_weekly_balances[acct_name] = three_month_weekly_balances_arr
      three_month_bimonthly_balances[acct_name] = three_month_bimonthly_balances_arr

      one_year_daily_balances[acct_name] = one_year_daily_balances_arr
      one_year_weekly_balances[acct_name] = one_year_weekly_balances_arr
      one_year_bimonthly_balances[acct_name] = one_year_bimonthly_balances_arr
      one_year_monthly_balances[acct_name] = one_year_monthly_balances_arr

    end

    thirty_day_balances = {'thirty_day_daily_balances' => thirty_day_daily_balances,
                           'thirty_day_weekly_balances' => thirty_day_weekly_balances}

    three_month_balances = {'three_month_daily_balances' => three_month_daily_balances,
                           'three_month_weekly_balances' => three_month_weekly_balances,
                           'three_month_bimonthly_balances' => three_month_bimonthly_balances}

    one_year_balances = {'one_year_daily_balances' => one_year_daily_balances,
                         'one_year_weekly_balances' => one_year_weekly_balances,
                         'one_year_bimonthly_balances' => one_year_bimonthly_balances,
                         'one_year_monthly_balances' => one_year_monthly_balances}

    balances_by_duration = {'thirty_day_balances' => thirty_day_balances,
                            'three_month_balances' => three_month_balances,
                            'one_year_balances' => one_year_balances}

    balances = {'sparse_balances' => sparse_balances, 'filled_balances' => filled_balances,
                'daily_balances' => daily_balances, 'weekly_balances' => weekly_balances,
                'bimonthly_balances' => bimonthly_balances, 'monthly_balances' => monthly_balances,
                'end_balances' => end_balances, 'balances_by_duration' => balances_by_duration}

    # net worth
    net_worth_arr = []
    today = Date.today
    nine_months_ago = Date.today - (30 * 9).days
    (nine_months_ago..today).each do |date|
      day = date.strftime("%d").to_i
      if day == 1
        net_worth_arr.push({date.to_s => 0})
      end
    end

    counter = 0
    monthly_balances.each do |acct_name, monthly_balance_acct|
      counter += 1
      monthly_balance_acct.each do |balance_obj|
        date = Date.strptime(balance_obj['date'].to_s)
        balance = Monetize.parse(balance_obj['balance']).to_f
        if date > nine_months_ago
          net_worth_arr.each_with_index do |net_worth_hash,index|
            net_worth_date = Date.strptime(net_worth_hash.keys[0])
            net_worth_balance = net_worth_hash.values[0].to_f
            if net_worth_date == date
              new_balance = (acct_name != 'credit') ? (net_worth_balance + balance).round() : (net_worth_balance - balance).round()
              net_worth_arr[index][net_worth_date.to_s] = new_balance
            end
          end
        end
      end
    end

    # bar graph data
    bar_graph_labels = [] # dates in yyyy-mm-dd format
    bar_graph_data = []   # dollar amounts in integer value
    net_worth_arr.each do |net_worth_obj|
      date_str = net_worth_obj.keys[0]
      month = Date.strptime(date_str).strftime("%b") # ie, "Feb"
      bar_graph_labels.push(month)
      net_worth = net_worth_obj.values[0]
      bar_graph_data.push(net_worth)
    end

    # assets.each do |asset|
    #   value = asset['value']
    #   asset['dollar_amt'] = dollar_amt(value)
    # end

    net_worth_graph = {'labels' => bar_graph_labels, 'data' => bar_graph_data}

    graphs = {'net_worth' => net_worth_graph}

    finances = {'accounts' => accounts, 'assets' => assets, 'budgets' => budgets, 'transactions' => transactions,
                'balances' => balances, 'net_worth' => net_worth_arr, 'graphs' => graphs}
    render json: finances
  end 

end