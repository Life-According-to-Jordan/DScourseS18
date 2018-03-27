#In this assignment we are comparing optimization techniques using the nloptr package

library(nloptr)
library(stargazer)
set.seed(100)
print("Generating Matrix...")
N=100000
K=10
X<-matrix(rnorm(N*K,mean=0,sd=1), N, K)
df<-as.data.frame(X)
X[,1] <- 1 
eps = rnorm(N, mean = 0, sd = 0.5)
head(eps)
beta <- c(1.5, -1, 0.25, 0.75, 3.5, -2, 0.5, 1, 1.25, 2)
Y <- X %*%  beta + eps
head(Y)

print("Question 5")
beta_estimates <- solve(t(X) %*% X) %*% t(X) %*% Y
print(beta_estimates)
print(beta)
print("The beta_estimates were very close to the given betas in the problem")

#gradient decent
print("Question 6")
set.seed(100)

# stepsize
alpha <- 0.0000003
maxiter <- 500000

# define objective function
objfun <- function(beta,Y,X) {return(sum((Y-X%*%beta)^2))}

# define gradient function
gradient <- function(beta,Y,X) {return(as.vector(-2*t(X)%*%(Y-X%*%beta)))}

beta <- runif(dim(X)[2])

beta.All <- matrix("numeric",length(beta),maxiter)

iter  <- 1
beta0 <- 0*beta
while (norm(as.matrix(beta0)-as.matrix(beta))>1e-8) {
  beta0 <- beta
  beta <- beta0 - alpha*gradient(beta0,Y,X)
  beta.All[,iter] <- beta
  if (iter%%10000==0) {
    print(beta)
  }
  iter <- iter+1
}

# print result and plot all xs for every iteration
print(iter)
print(paste("The minimum of f(beta,Y,X) is ", beta, sep = ""))


print("Question 7")
print("Starting L-BFGS")

## initial values
beta0 <- runif(dim(X)[2]) #start at uniform random numbers equal to number of coefficients

# Algorithm parameters
options <- list("algorithm"="NLOPT_LD_LBFGS","xtol_rel"=1.0e-6,"maxeval"=1e3)

# Optimize
result_NLOPT_LD_LBFGS <- nloptr( x0=beta0,eval_f=objfun,eval_grad_f=gradient,opts=options,Y=Y,X=X)
print(result_NLOPT_LD_LBFGS)

#Nelder-Mead 
print("Question 7: Nelder-Mead")

## define objective function 
obj = function(X, Y, beta){return(sum(Y-X%*%beta)^2)}

## define gradient function 
grad = function(X, Y, beta){return(as.vector(-2*t(X)%*%(Y-X%*%beta)))}

## create data
Y = Y
X = X
beta0 = runif(dim(X)[2])

## options for alg.  
options <- list("algorithm"="NLOPT_LN_NELDERMEAD","xtol_rel"=1.0e-6,"maxeval"=1e4)

## optimizing using Nelder-Mead
result_NM <- nloptr(x0=beta0,eval_f=objfun,opts=options,Y=Y,X=X)
print(result_NM)

print("Question 8")
objfun <- function(theta,Y,X) {
  # need to slice our parameter vector into beta and sigma components
  beta <- theta[1:(length(theta)-1)]
  sig <- theta[length(theta)]
  # write objective function as *negative* log likelihood (since NLOPT minimizes)
  loglike <- -sum( -.5*(log(2*pi*(sig^2)) + ((Y-X%*%beta)/sig)^2) ) 
  return (loglike)
}
theta0 <- runif(dim(X)[2]+1) #start at uniform random numbers equal to number of coefficients

options <- list("algorithm"="NLOPT_LN_NELDERMEAD","xtol_rel"=1.0e-6,"maxeval"=1e4)

result_MLE_Nelder_Mead <- nloptr( x0=theta0,eval_f=objfun,opts=options,Y=Y,X=X)
print(result_MLE_Nelder_Mead)

print("Question 9")
Q9_LM <- lm(Y ~ X -1) 
print(summary(Q9_LM))
stargazer(Q9_LM)