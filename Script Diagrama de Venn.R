##DIAGRAMA DE VENN##

###Se realizo un estudio fitoquimico cualitativo de 59 cultivos del estado de Nayarit. Se recolectaron cereales, frutos, hortalizas. Posteriormente, se realizaron pruebas rapidas para identificar compuestos por precipitaci?n o cambio de color.Los an?lisis cualitativos 
#fueron: fenoles, taninos, alcaloides y flavonoides.Todas las determinaciones se llevaron a cabo por triplicado y los resultados obtenidos se expresaron como: positivo (1) y negativo (0).##


##INSTALAR Y CARGAR LA PAQUETERIA
install.packages("VennDiagram")
library(VennDiagram)

##CARGAR DATOS
setwd("Ruta/de/trabajo")

d <- read.csv("CUALITATIVOS DIAGRAMA DE VENN.csv")

##CREAR SUBCONJUNTOS
nrow(subset(d, Fenoles == 1))
nrow(subset(d, Taninos == 1))
nrow(subset(d, Alcaloides == 1))
nrow(subset(d, Flavonoides == 1))

##DETERMINAR INTERSECCIONES Y GRAFICAR
grid.newpage()
draw.quad.venn(area1 = nrow(subset(d, Fenoles == 1)), area2 = nrow(subset(d, Taninos == 1)),
                area3 = nrow(subset(d, Alcaloides == 1)), area4 = nrow(subset(d, Flavonoides == 1)),
                 n12 = nrow(subset(d, Fenoles == 1 & Taninos == 1)), n13 = nrow(subset(d, Fenoles == 1 & Alcaloides == 1)),
                 n14 = nrow(subset(d, Fenoles == 1 & Flavonoides == 1)), n23 = nrow(subset(d, Taninos == 1 & Alcaloides == 1)),
                 n24 = nrow(subset(d, Taninos == 1 & Flavonoides == 1)), n34 = nrow(subset(d, Alcaloides == 1 & Flavonoides == 1)),
                 n123 = nrow(subset(d, Fenoles == 1 & Taninos == 1 & Alcaloides == 1)), n124 = nrow(subset(d, Fenoles == 1 & Taninos == 1 & Flavonoides == 1)),
                 n134 = nrow(subset(d, Fenoles == 1 & Alcaloides == 1 & Flavonoides == 1)), n234 =nrow(subset(d, Taninos == 1 & Alcaloides == 1 & Flavonoides == 1)),
                 n1234 = nrow(subset(d, Fenoles == 1 & Taninos == 1 & Alcaloides == 1 & Flavonoides == 1)), category = c("FENOLES", "TANINOS","ALCALOIDES","FLAVONOIDES"), lty= "blank",
                 fill= c("skyblue","pink1","orange1", "green1"))

