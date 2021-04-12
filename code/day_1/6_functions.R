# function_name <- function(arguments1, arguments2, so on) {
#    Function body 
# }
# 
# Function Name − Name of the function,whenever you want to ues a function, you call it by using the name
# 
# Arguments − placeholder variables which are used in function
# 
# Function Body − function body contains the code for all the statements or actions
# 
# Return Value − it is the last statement in function body

# Create a function to print squares of numbers in sequence.

new.function <- function(a) {
   for(i in 1:a) {
      b <- i^2
      print(b)
   }
}

# Call the function new.function supplying 6 as an argument.
new.function(6)


decile <- function(x){   
  deciles <- vector(length=10)   
  for (i in seq(0.1,1,.1)){     
    deciles[i*10] <- quantile(x, i, na.rm=T)   
  }   
  return (   
    ifelse(x<deciles[1], 1,   
    ifelse(x<deciles[2], 2,   
    ifelse(x<deciles[3], 3, 
    ifelse(x<deciles[4], 4,
    ifelse(x<deciles[5], 5,
    ifelse(x<deciles[6], 6,
    ifelse(x<deciles[7], 7,
    ifelse(x<deciles[8], 8,   
    ifelse(x<deciles[9], 9, 10   
    )))))))))) 
  }


