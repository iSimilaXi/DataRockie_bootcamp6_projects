# r pizza chatbot

#menu dataframe
df_pizza <- data.frame(id = c("1", "2", "3"),
                       pizza = c("Pepperoni",
                                "Cheese",
                                "Meat Lover"))

df_pizza_price <- data.frame(size = c("M", "L", "XL"),
                             Pepperoni = c(12.99, 15.99, 18.99),
                             Cheese = c(9.99, 12.99, 14.99),
                             'Meat Lover' = c(14.99, 17.99, 21.99))

df_appetizers <- data.frame(id = c("1", "2", "3"),
                             appetizers = c("French Fries",
                                             "Cheese Balls",
                                             "Caesar Salad"),
                             price = c(4.99, 7.99, 8.99))

#object (set it as empty object)
description <- NULL
amount <- NULL
price <- NULL

#function
pizza <- function (pizza_id) {
  df_pizza$pizza[as.numeric(pizza_id)]
}

size_and_price <- function (pizza_size) {
  if(pizza_size == "M") {
    price <- df_pizza_price[[as.numeric(pizza_id) + 1]][1]
  } else if (pizza_size == "L") {
    price <- df_pizza_price[[as.numeric(pizza_id) + 1]][2]
  } else if (pizza_size == "XL") {
    price <- df_pizza_price[[as.numeric(pizza_id) + 1]][3]
  }
}

pizza_order_amount <- function(amount) {
  as.integer(amount)
}

appetizer <- function (app_id) {
  df_appetizers$appetizers[as.numeric(app_id)]
}

app_order_amount <- function(amount) {
  as.integer(amount)
}

appetizer_price <- function (app_id) {
  price <- df_appetizers$price[as.numeric(app_id)]
}

#------------------------
#chatbot part

print("Pablo's Pizza, ready to serve you slices of happiness!")
print("Hello, welcome to our pizza shop.")

#greeting, username
print("Enter your name here: ")
username <- readLines("stdin", n=1)
print(paste("Hi", username, ", how can we help you?"))

con_trans <- "Y"

# continue transaction
while (con_trans == "Y") {
  
  print("1. Ordering Pizzas")
  print("2. Appetizers")
  print("3. Order Confirmation")
  
  chat_selection <- readLines("stdin", n=1)
  if(as.numeric(chat_selection) %in% 1:3) {
    #Order Pizzas
    if (chat_selection == "1") {
      #pizza selection
      print("Pizza Menu")
      print(df_pizza[, 1:2])
      print("Select your pizza menu: ")
      pizza_id <- readLines("stdin", n=1) 
        if ((as.numeric(pizza_id) %in% 1:3)) {
          description <- append(description, pizza(pizza_id))
          #pizza size & price?
          print(df_pizza_price[ , c(1, as.numeric(pizza_id) + 1)])
          print("Which size? M/L/XL")
          pizza_size <- readLines("stdin", n=1)
          print("Pizza amount: ")
          pizza_amount <- readLines("stdin", n=1)
          amount <- append(amount, pizza_order_amount(pizza_amount))
          price <- append(price, size_and_price(pizza_size)* pizza_order_amount(pizza_amount))
        } else {
          print("Wrong input! Try again.")
      }
    } else if (chat_selection == "2") {
      #order appetizers
      print("Appetizer Menu")
      print(df_appetizers)
      print("Select your appetizer: ")
      app_id <- readLines("stdin", n=1)
      if (as.numeric(app_id) %in% 1:3) {
        description <- append(description, appetizer(app_id))
        
        print("Numbers of the appetizer order: ")
        app_amount <- readLines("stdin", n=1)
        amount <- append(amount, app_order_amount(app_amount))
        price <- append(price, app_order_amount(app_amount) *
                          appetizer_price(app_id))
      } else {
        print("Wrong input! Try again.")
      }
    } else if (chat_selection == "3") {
      # Check order
      cust_order_list <- list(Items = description,
                              Amount = amount,
                              Price = price)
      cust_order_df <- data.frame(cust_order_list)
      if(is.null(cust_order_list[[1]]) == TRUE) {
        print("Your order is currently empty.")
      } else {
        print(cust_order_df)
      }
    }
    print("Would you like to order more? Y/N")
    con_trans <- readLines("stdin", n=1)
  } else {
    print("Wrong input! Try again.")
  }
}

# order summary
cust_order_list <- list(Items = description,
                        Amount = amount,
                        Price = price)
cust_order_df <- data.frame(cust_order_list)

print("== Order Summary ==")
print(cust_order_df)
total <- sum(cust_order_df$Price)
print("===================")
print(paste("Total:", total, "$"))
print("===================")
print("At your service.")
print("===================")