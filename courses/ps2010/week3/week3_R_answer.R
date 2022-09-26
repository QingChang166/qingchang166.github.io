library(ggplot2)

x_value <- rnorm(10000)

y_value <- dnorm(x_value)

plot_data <- data.frame(x = x_value,
                        y = y_value)


ggplot(plot_data, aes(x = x, y= y))+
  geom_line()



draw_data <- data.frame(x_draw = seq(-2,2, length.out = 10000),
                        y_draw = runif(10000, 0, 0.4))


ggplot(plot_data, aes(x = x, y= y))+
  geom_line(color = "red")+
  geom_point(draw_data, mapping = aes(x_draw, y_draw), alpha = 0.2)


under <- draw_data$y_draw <= dnorm(draw_data$x_draw)

ratio <- sum(under)/length(under)

total_area <- 4 * 0.4

area_under_curve <- ratio*total_area



