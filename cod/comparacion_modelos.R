library(dplyr)
library(ggplot2)

source("cod/analisis_datos_hubble.R")
source("cod/modelo_sin_intercepto.R")
source("cod/modelo_con_intercepto.R")

pendiente_sin <- coef(modelo.sin)[["distancia"]]

pendiente_con <- coef(modelo.con)[["distancia"]]

intercepto_con <- coef(modelo.con)[["(Intercept)"]]

diferencia <- pendiente_con - pendiente_sin

diferencia_porcentual <- 
  100 * diferencia / pendiente_sin

comparacion <- data.frame(
  Modelo = c("Sin intercepto", "Con intercepto"),
  Intercepto = c(0, intercepto_con),
  Pendiente = c(pendiente_sin, pendiente_con)
)

print(comparacion)

cat("Diferencia absoluta:", abs(diferencia), "\n")
cat("Cambio porcentual:", round(diferencia_porcentual, 2), "%\n")

anova(modelo.sin, modelo.con)

grafico.compa <- ggplot(galaxias,
       aes(x = distancia, y = velocidad)) +
  geom_point(color = "gray40", size = 2.5) +
  geom_abline(
    intercept = 0,
    slope = pendiente_sin,
    color = "red",
    linewidth = 1
  ) +
  geom_abline(
    intercept = intercepto_con,
    slope = pendiente_con,
    color = "blue",
    linewidth = 1,
    linetype = "dashed"
  ) +
  labs(
    title = "Comparacion de modelos lineales",
    subtitle = "Rojo: sin intercepto | Azul: con intercepto",
    x = "Distancia (Mpc)",
    y = "Velocidad de recesion (km/s)"
  ) +
  theme_minimal()

ggsave(
  "res/grafico_comparacion_modelos.png",
  plot = grafico.compa,
  width = 10,
  height = 6,
  dpi = 300
)
