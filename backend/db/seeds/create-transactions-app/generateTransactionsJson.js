import { faker } from '@faker-js/faker';
import * as fs from 'fs'
const largePurchaseMax = 800; // $800 
const mainCheckingInitialBalance = 9545.59;
const nesteggCheckingInitialBalance = 15000;
const travelCheckingInitialBalance = 1000;
const graphicsCardCheckingInitialBalance = 600;
const giftsCheckingInitialBalance = 500;
const creditCardInitialBalance = 4320.39;
const budgetCategories = [ 'groceries','auto','web','music','phone','home','daycare','mark','lisa','N/A'];

let checkingFreeCheckingDataObj = generateTransactions('checking', mainCheckingInitialBalance,1);
let checkingNesteggDataObj = generateTransactions('checking', nesteggCheckingInitialBalance,2);
let checkingTravelDataObj = generateTransactions('checking', travelCheckingInitialBalance,3);
let checkingGraphicsCardDataObj = generateTransactions('checking', graphicsCardCheckingInitialBalance,4);
let checkingGiftsCardDataObj = generateTransactions('checking', giftsCheckingInitialBalance,5);
let creditDataObj = generateTransactions('credit', creditCardInitialBalance,6);

writeSeedFile([checkingFreeCheckingDataObj,checkingNesteggDataObj,checkingTravelDataObj,checkingGraphicsCardDataObj,checkingGiftsCardDataObj,creditDataObj]);

function writeSeedFile(arrayOfTransDataObj) {
  const allTransactions = [].concat.apply([], arrayOfTransDataObj);
  let seedsStr = '';
  allTransactions.forEach((trans,i) => {
    const date = dateStrToRailsDate(trans.date);
    const acct = trans.account;
    const categoryNum = Math.floor((Math.random() * 10)+1);
    let line = 'Transaction.create!(';
    line += 'date: ' + date + ', ';
    line += 'description: \'' + trans.description.replace('\'','') + '\', ';
    line += 'amount: \'' + trans.amount + '\', ';
    line += 'balance: \'' + trans.balance + '\', ';
    line += 'purchase_type_id: ' + categoryNum + ', ';
    line += 'account_id: ' + acct + ', ';
    line += 'user_id: 1' + ")\n";
    seedsStr += line;
  });
  fs.writeFileSync('./../5_transactions.rb',seedsStr);
}

// 12/03/22 => DateTime.new(2022,12,3,0)
function dateStrToRailsDate(dateStr) {
  const dateArr = dateStr.split('/');
  const year = '20'+dateArr[2];
  const month = parseInt(dateArr[0], 10);
  const day = parseInt(dateArr[1], 10)
  const railsDateStr = 'DateTime.new(' + year + ',' + month + ',' + day + ',0)';
  return railsDateStr;
}


function generateTransactions(transactionType, initBal, acctName) {
  let transactions = [];
  let startDate = new Date('01 January 2022 00:00 UTC');
  let endDate = new Date(startDate.getTime());
  endDate.setDate(endDate.getDate() + 1);
  let balance = initBal;
  let balanceFormatted;
  let priceNoDollarSign;
  let priceInverted;
  const numDays = Math.round((new Date() - startDate) / (1000 * 3600 * 24));

  for (let id = 1; id <= numDays; id++) {
    let description;
    let price;
    let balanceStr;
    let category;

    const date = formatDate(new Date(+startDate + Math.random() * (endDate - startDate)));

    // regular checking or credit card payment transaction
    if (id % 15 != 0) {
      description = removeFirstWord(faker.commerce.productName()) + ' at ' + removeLLCAndInc(faker.company.companyName(0));
      const priceAndBalObj = getDebitOrCreditPriceAndBalance(transactionType,balance,largePurchaseMax);
      price = priceAndBalObj.price;
      balance = priceAndBalObj.balance;
      balanceStr = balanceNumToBalanceCurrencyStr(balance);
      category = faker.helpers.arrayElement(budgetCategories);
      
    } else {
      // paycheck 
      if (transactionType == 'checking') {
        description = 'paycheck';
        priceNoDollarSign = -4000;
        priceInverted = "4,000";
        price = '$' + priceInverted;
        balance = balance - priceNoDollarSign;
        balanceStr = '$' + toCurrencyWithCommas(balance);
        category = 'N/A';

      // credit card payment 
      } else if (transactionType == 'credit') {
        description = 'credit card payment';
        priceNoDollarSign = balance;
        priceInverted = priceNoDollarSign;
        price = '-$' + toCurrencyWithCommas(priceInverted);
        balance = balance - priceNoDollarSign;
        balanceStr = '$' + toCurrencyWithCommas(balance);
        category = 'N/A';
      }
    }
    
    transactions.push({
      date: date,
      description: description,
      amount: price,
      balance: balanceStr,
      category: category,
      account: acctName
    });

    startDate = new Date(endDate.getTime());
    endDate.setDate(endDate.getDate() + 1);

  };
  return transactions
}




// utils

function getRegularDebitOrCreditTransactionObj(type,balance,largePurchaseMax) {
  description = removeFirstWord(faker.commerce.productName()) + ' at ' + removeLLCAndInc(faker.company.companyName(0));
  const priceAndBalObj = getDebitOrCreditPriceAndBalance(type,balance,largePurchaseMax);
  price = priceAndBalObj.price;
  balance = priceAndBalObj.balance;
  balanceStr = balanceNumToBalanceCurrencyStr(balance);
  return {
    description: description,
    price: price,
    balance: balanceStr,
  }
}

function balanceNumToBalanceCurrencyStr(balanceNum) {
  return '$' + toCurrencyWithCommas(balanceNum);
}

function getDebitOrCreditPriceAndBalance(type,balance,max) {
  let priceAndBalObj;
  if (type == 'checking') {
    priceAndBalObj = getDebitTransactionPriceAndBalance(balance,max);
  } else if (type == 'credit') {
    priceAndBalObj = getCreditTransactionPriceAndBalance(balance,max);
  }
  return priceAndBalObj;
}

function getCreditTransactionPriceAndBalance(balance,max) {
  const priceNum = getRandomPrice(max);
  const priceStr = '$' + priceNum;
  const nextBalance = balance + parseFloat(priceNum);  // add price from balance for debit transactions
  return { price: priceStr, balance: nextBalance }
}

function getDebitTransactionPriceAndBalance(balance,max) {
  let nextBalance = 0
  let priceStr;
  while (nextBalance < balance * .8) {
    const priceNum = getPriceThatKeepsBalancePositive(balance,800);
    priceStr = '-$' + priceNum;
    nextBalance = balance - priceNum;    // subtract price from balance for debit transactions
  }
  return { price: priceStr, balance: nextBalance }
}

function getPriceThatKeepsBalancePositive(balance,max) {
  const actualMax = (balance < max) ? balance - 2 : max;  // if current balance is less than requested max, use balance as max (otherwise balance can go negative)
  const price = getRandomPrice(actualMax);
  return price;
}

function removeLLCAndInc(companyName) {
  const companyWithLLC = faker.company.companyName(0);
  const lastWord = companyWithLLC.split(' ').pop();
  let company;
  if (lastWord == "LLC" || lastWord == "Inc") {
    const lastIndex = companyWithLLC.lastIndexOf(" ");
    company = companyWithLLC.substring(0, lastIndex).trim();
  } else {
    company = companyWithLLC;
  }
  return company;
}

function removeFirstWord(multipleWords) {
  return multipleWords.substring(multipleWords.indexOf(' ')).trim();
}

function toCurrencyWithCommas(floatNum) {
  return  floatNum.toFixed(2).toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}

// from 1.00 to 799.99
function getRandomPrice(max) {
  const dollars = Math.floor(Math.random() * (max) + 1)
  const cents = Math.floor(Math.random() * (100))
  return dollars.toString() + '.' + cents.toString();
}

// from https://stackoverflow.com/a/23593099
// Sun May 11,2014' => 05/11/14
function formatDate(date) {
  var d = new Date(date),
      month = '' + (d.getMonth() + 1),
      day = '' + d.getDate(),
      year = d.getFullYear().toString().slice(-2);
  if (month.length < 2) 
      month = '0' + month;
  if (day.length < 2) 
      day = '0' + day;
  return [month, day, year].join('/');
}