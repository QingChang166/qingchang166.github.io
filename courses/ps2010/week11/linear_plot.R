library(ggplot2)


data <- data.frame(y=c(600, 700, 750, 900, 1200, 1300, 1350, 1500, 1600, 1900, 2200, 2300, 2350, 2500, 2600),
                   x=c(1, 2, 2, 3, 4, 4, 5, 6, 6, 8, 9, 9, 11, 12, 12))


ggplot(data,aes(x, y)) +
  geom_point()+
  xlab("Education Level")+
  ylab("Income")+
  theme_minimal()



ggplot(data,aes(x, y)) +
  geom_point()+
  geom_smooth(method='lm', se=FALSE)+ 
  xlab("Education Level")+
  ylab("Income")+
  theme_minimal()


fit <- lm(y ~ x, data =data)

data$pred <- predict(fit)

ggplot(data,aes(x, y)) +
  geom_point()+
  geom_smooth(method='lm', se=FALSE)+ 
  geom_segment(aes(xend = x, yend = pred, color = "Distance")) +
  xlab("Education Level")+
  ylab("Income")+
  theme_minimal()

ggplot(data,aes(x, y)) +
  geom_point() +
  geom_smooth(method='lm') +
  ylim(500, 2650)+
  xlab("Education Level")+
  ylab("Income")+
  theme_minimal()
