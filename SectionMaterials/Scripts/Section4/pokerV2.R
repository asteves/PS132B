## The full version 
## The following is a program that simulates an arbitrary number of hands, and returns the frequencies of different hand values. 

# Helper Functions --------------------------------------------------------
deal_cards = function(deck, N=5, R = FALSE){
  ## Randomly sample 5 cards 
  ## Representation of a 5 card stud hand
  return(deck[sample.int(nrow(deck),N,R),])
}

test_straight = function(hand, card){
  ## Note that this is "slow" relative to other methods   ## I'm writing it this way to demonstrate a for loop
  ## Sort our hand in ascending order 
  h = sort(hand[[card]])
  
  ## 5 card hand
  ## we test whether the cards are in sequential order
  for(i in 1:4){
    if(h[i+1] - h[i] != 1){
      ## If this condition is false then we can't have a straight
      return(FALSE)
    }
  }
  return(TRUE)
}

## For reference, if we're smart about how we do 
## evaluations, this works to test for a straight
# test_straight = function(hand, card){
#   h = sort(hand[[card]])
#   return(h[5] - h[1] == 4)
# }


test_flush = function(hand, suit){
  ## A flush has all the same suit 
  ## Consequently there should only be one element
  return(length(unique(hand[[suit]]))== 1)
}

test_royal = function(hand, card, suit){
  ## Here is one way to test for a Royal Flush
  ## There are likely other smarter ways
  ## The specific cards needed for a Royal Flush 
  ## A = 1, J=11,Q=12,K=13
  s = c(1,10,11,12,13)
  ## Order the hand in ascending order by card value 
  h = hand[order(hand[[card]]),]
  
  ## If all the cards are the same, then the sum will be sum(T,T,T,T,T)
  ## which is sum(c(1,1,1,1,1)) == 5 
  ## In order for it to be a Royal Flush, the cards all have to be same suit
  return(sum(h == s) == 5 && test_flush(hand, suit))
}

evaluate_hand = function(hand, card, suit){
  ## Get the distribution of values in the hand 
  d = table(hand[[card]])
  
  ## Use numbers to represent hands 1="High Card" to 10 = "Royal Flush"
  if(test_royal(hand, card, suit)){
    return(10)
  }
  else if(test_straight(hand, card)){
    ## if it's a straight, check if it's also a flush 
    if(test_flush(hand, suit)){
      return(9)
    }else{
      ## Just a regular straight 
      return(5)
    }
  }
  ## 4 of a kind
  else if(any(d == 4)){
    return(8)
  }
  ## Full House 
  ## First test if we have three of a kind
  else if(any(d == 3)){
    ## Now test if the other two cards are a pair
    if(any(d == 2)){
      return(7)
    }else{
      return(4)
    }
  }
  ## In order to test for 2 pairs
  ## We can use the fact that we should have exactly 
  ## two buckets that have 2 in them
  else if(length(d[d==2]) == 2){
    return(3)
  }
  else if(any(d == 2)){
    return(2)
  }
  ## Finally we test to see if we have a flush 
  else if(test_flush(hand, suit)){
    return(6)
  } else{
    return(1)
  }
}


# Simulation Loop  -------------------------------------------------------------

simulateDeals = function(N = 100){
  ## Make a deck 
  suits = rep(c("C", "D", "S", "H"), 13)
  cards = rep(1:13, each = 4)
  ## There are other representations available
  ## But a data frame works for this problem
  deck = data.frame(suits, cards)
  
  ## Preallocate a vector to store results
  deals = vector(mode = "logical", length = N)
  for(i in 1:N){
    deals[i] = evaluate_hand(deal_cards(deck),
                             card = "cards", 
                             suit="suits")
  }
  return(deals)
}


# Test Runs ---------------------------------------------------------------

           
## Test different N sizes 
set.seed(355)
N = c(100, 1000,10000)
results = list()
for(i in 1:length(N)){
  a = simulateDeals(N[i])
  results[[i]] = a
}

for(i in 1:length(N)){
  print(table(results[[i]]))
}
for(i in 1:length(N)){
  print(prop.table(table(results[[i]]))*100)
}


