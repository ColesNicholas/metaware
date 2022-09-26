library(metafor)
library(ggplot2)
library(gridExtra)
theme_set(theme_minimal)

# load dataframe
df <- read.csv("tmp.df.csv")

# normal funnel plot shows strong negative relationship between vi and yi
p1 <- ggplot(df, 
             aes(x = vi, y = yi)) +
  geom_point() +
  ggtitle("funnel plot")


# get tau2 estimate
tau2 <- rma.uni(yi = yi, 
                vi = vi,
                data = df,
                method = "REML")$tau2

# estimated relationship between vi and yi is NEGATIVE when using REML
p2 <- ggplot(df, 
             aes(x = vi, 
                 y = yi,
                 size = 1 / (tau2 + vi))) + #  show REML weighting for points
  geom_point() +
  geom_smooth(method = "lm", 
              mapping = aes(weight = 1 / (tau2 + vi)), #  REML weighting
              color = "black") +
  ggtitle("REML weighting") +
  guides(size = "none")


# estimated relationship between vi and yi is POSITIVE when using FE
p3 <- ggplot(df, 
             aes(x = vi, 
                 y = yi,
                 size = 1 / vi)) + # show FE weighting for points
  geom_point() +
  geom_smooth(method = "lm", 
              mapping = aes(weight = 1 / vi), #  FE weighting
              color = "black") +
  ggtitle("FE weighting") +
  guides(size = "none")

# plot together
grid.arrange(p1, p2, p3,
             nrow = 2)

# Implications: I usually see PET-PEESE implemented with FE weighting. 
# In this scenario, the FE weighting will provide an 
# very counterintuitive slope estimate
