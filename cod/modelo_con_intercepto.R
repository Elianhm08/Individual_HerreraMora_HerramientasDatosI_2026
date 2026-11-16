library(dplyr)
source("cod/analisis_datos_hubble.R")

modelo.con <- lm(
  velocidad ~ distancia,
  data = galaxias
)

summary(modelo.con)

beta.0 <- coef(modelo.con)[["(Intercept)"]]
beta.1 <- coef(modelo.con)[["distancia"]]

print(beta.0)
print(beta.1)

confint(modelo.con, level = 0.95)

library(ggplot2)

grafica.con <-  ggplot(galaxias,
       aes(x = distancia, y = velocidad)) +
  geom_point(color = "steelblue", size = 3) +
  geom_abline(
    intercept = beta.0,
    slope = beta.1,
    color = "darkgreen",
    linewidth = 1
  ) +
  labs(
    title = "Modelo B: Regresión con intercepto",
    subtitle = paste(
      "Intercepto =", round(beta.0, 2),
      "| Pendiente =", round(beta.1, 2)
    ),
    x = "Distancia (Mpc)",
    y = "Velocidad de recesión (km/s)"
  ) +
  theme_minimal()

grafica.con

ggsave(
  "res/grafico_modelo_con_intercepto.png",
  plot = grafica.con,
  width = 10,
  height = 6,
  dpi = 300
)
