library(dplyr)
source("cod/analisis_datos_hubble.R")

modelo.sin <- lm(
  velocidad ~ 0 + distancia,
  data = galaxias
)

summary(modelo.sin)

H0_estimado <- coef(modelo.sin)[["distancia"]]

print(H0_estimado)

#Intervalo de confianza de 95% para mantener la incertidumbre de los datos
confint(modelo.sin, level = 0.95)

library(ggplot2)

grafico.sin <- ggplot(galaxias,
       aes(x = distancia, y = velocidad)) +
  geom_point(color = "steelblue", size = 3) +
  geom_abline(
    intercept = 0,
    slope = H0_estimado,
    color = "red",
    linewidth = 1
  ) +
  labs(
    title = "Modelo A: Ley de Hubble-Lemaître",
    subtitle = paste("H0 estimada =", round(H0_estimado, 2)),
    x = "Distancia (Mpc)",
    y = "Velocidad de recesión (km/s)"
  ) +
  theme_minimal()

ggsave(
  "res/grafico_modelo_sin_intercepto.png",
  plot = grafico.sin,
  width = 10,
  height = 6,
  dpi = 300
)

