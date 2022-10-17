library(tidyverse)

sample_value <- c(5, 10, 20, 30, 100)

store_out <- data.frame()

for (n in sample_value) {
  
  for (sim in 1:100) {
    
    draw_normal <- rnorm(n, 3, 1)
    
    
    draw_uniform <- runif(n, 0 , 1)
    
    draw_binomial <- rbinom(n, size = 10, prob = 0.3)
    
    out <- data.frame(normal = mean(draw_normal),
                      uniform = mean(draw_uniform),
                      binomial = mean(draw_binomial),
                      sample_size = as.factor(n) )
    
    store_out <- bind_rows(store_out, out)
    
  } 
  
}


ggplot(store_out, aes(x = normal, color = sample_size))+
  geom_density(bw=.1)+
  geom_vline(xintercept = 3, linetype="dotted")+
  ggtitle("Normal Distribution")

ggplot(store_out, aes(x = uniform, color = sample_size))+
  geom_density(bw=.05)+
  geom_vline(xintercept = 0.5, linetype="dotted")+
  ggtitle("Uniform Distribution")


ggplot(store_out, aes(x = binomial, color = sample_size))+
  geom_density(bw=.1)+
  geom_vline(xintercept = 3, linetype="dotted")+
  ggtitle("Binomial Distribution")



