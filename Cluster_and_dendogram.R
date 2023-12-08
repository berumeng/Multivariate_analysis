###Script para analizar los niveles de expresion de las cuantificaciones de las diferentes estrategias de filtrado de reads
##Librerias requeridas
library(gplots)
library (RColorBrewer)

##Establecer la carpeta de trabajo
setwd("Ruta/de/trabajo")
##cargar el set de datos con nivles de expresión normalizados a cpm
Table1 = read.table("Heatmap conF.txt", header=TRUE, row.names=1)
head(Table1)

#CREAR UN OBJETO PARA APLICAR LA FUNCION EN Rstudio.
normalize <- function(x) {
  return ((x - min(x)) / (max(x) - min(x)))
}

#normalized
#ROW (2)
#COLUMN(10)
#normalized <- function(x) (x- min(x))/(max(x) - min(x)
norm3 <- as.data.frame(lapply(Table1[,2:10], normalize))
norm3
head(norm3)
names(norm3)
dim(norm3)

#AÑAIDR NOMBRES A LA COLUMNA NO. 1
rownames = paste("UAA", 1:15, sep = "")
rownames(norm3) = rownames
head(norm3)


#PAQUETERIA FACTO EXTRA PARA GRAFICAR CLUSTER PLOT, PCA
library(factoextra)
fviz_nbclust(norm3, kmeans, method = "silhouette")
fviz_nbclust(norm3, kmeans, method = "wss")
fviz_nbclust(norm3, kmeans, method = "gap_stat")

#CLUSTER
#CENTERS SIGNIFICA EL NUMERO DE CLUSTERS, 
#NSTART SON LAS OBSERVACIONES
k2 <- kmeans(norm3, centers = 2, nstart = 25)
fviz_cluster(k2, data = norm3,
             palette = c("#00AFBB", "#FC4E07"), # color palette, son 2, si fueran 4k serian 4
             ellipse.type = "t", # Concentration ellipse 
             ggtheme = theme_classic()
)



k4 <- kmeans(norm3, centers = 4, nstart = 15)
fviz_cluster(k4, data = norm3,
             palette = c("#2E9FDF", "#00AFBB", "#E7B800", "#FC4E07"), # color palette
             ellipse.type = "t", # Concentration ellipse 
             ggtheme = theme_classic()
)


#CLUSTER ANALYSIS
library("factoextra")
k4 <- kmeans(norm3, centers = 4, nstart = 15)
fviz_cluster(k4, data = norm3,
             palette = c("#00AFBB","#2E9FDF", "#E7B800", "#FC4E07"),
             ggtheme = theme_minimal(),
             main = "Partitioning Clustering Plot"
)

#DENDOGRAMA
library("factoextra")
# hacer el hierarchical clustering (CATEGORIA JERARQUICA) Y CORTARLO EN 4 CLUSTERS
res <- hcut(norm3, k = 4, stand = TRUE)
# Visualize
fviz_dend(res, rect = TRUE, cex = 0.5,
          k_colors = c("#00AFBB","#2E9FDF", "#E7B800", "#FC4E07"))



##keysize es la escala de colores de la izquierda
#cexRow y cel. tamaño letra
#Rowsidecolor permite agrupar por colores mediante el hclust
tiff(filename = "heatmapsFT_normalizedl.tiff",width = 768, height = 1024, units = "px", pointsize = 12, 
     compression = c("none"), bg = "white")
