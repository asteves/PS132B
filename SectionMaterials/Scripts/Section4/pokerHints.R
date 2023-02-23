## Is it a pair? 
## The following is a program that will classify whether a 5 card hand in poker is a pair or not. For this program, we ignore anything about suits. 

# Minimal Program ---------------------------------------------------------

## Make a deck 
deck = rep(1:13, each = 4)

isPair = function(hand){
  ## We can combine table with which() and length()
  ## to determine if we have just one pair 
  ## This could be one line, but I'll break it up 
  ## for teaching clarity
  values = table(hand)
  pairs = which(values == 2)
  numpairs = length(pairs)
  
  if(numpairs == 1){
    return("Pair")
  } else{
    return("Not Pair")
  }
}

## Let's apply our test cases 
testcases = list(pair, twopair)
for(i in 1:length(testcases)){
  print(isPair(testcases[[i]]))
}


## Of course we want to do this repeatedly so a loop seems reasonable 

## Set the number of runs
N = 10

## preallocate a vector
pairs = vector(mode = "logical", length = N)
for(i in 1:N){
  pairs[i] = isPair(sample(deck, 5, replace = F))
}
table(pairs)
