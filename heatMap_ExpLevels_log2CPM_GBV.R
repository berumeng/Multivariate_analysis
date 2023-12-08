###Script para analizar los niveles de expresion de las cuantificaciones de las diferentes estrategias de filtrado de reads
##Librerias requeridas
library(gplots)
library (RColorBrewer)

##Establecer la carpeta de trabajo
setwd("Ruta/de/trabajo")
##cargar el set de datos con nivles de expresión normalizados a cpm
Table1 = read.table("expLevels_frijol_MK.txt", header=TRUE, row.names=1)
head(Table1)

#Generar la matrix de los datos
Table2=data.matrix(Table1)
head(Table2)

## Normalization, re-format into matrix ##
#Table2[, 2:25] <- log(Table2[2:25], 2)
#Table2


##Establecer la escala de valores (0 a 10)
pair.break=seq(0,10,by=0.5)

#Establecer la escala de colores
mycol=colorpanel(n=20, low="ghostwhite", mid="gold", high="firebrick3")

##Calcular la distancia 
hr=hclust(dist(Table2), method="complete")

#Definir color de los clusters
#k, es el número clusters (aparecerán con color)
mycl=cutree(hr, k=6)
mycolhc=rainbow(length(unique(mycl)), start=0.1, end=0.9)
mycolhc=mycolhc[as.vector(mycl)]

#Características del heatmap.
##keysize es la escala de colores de la izquierda
#cexRow y cel. tamaño letra
#Rowsidecolor permite agrupar por colores mediante el hclust
tiff(filename = "name9e.tiff",width = 768, height = 1024, units = "px", pointsize = 12, 
     compression = c("none"), bg = "white")
heatmap.2(Table2,Rowv=as.dendrogram(hr), Colv="FALSE", dendrogram="row", col=mycol[1:20], 
          breaks=pair.break[1:21], key=TRUE, keysize=1, 
          trace="none", cexRow=1.1, cexCol=1.6, margin=c(15,15), densadj=0.10, 
          density.info=c("none"), RowSideColors=mycolhc)
dev.off()

