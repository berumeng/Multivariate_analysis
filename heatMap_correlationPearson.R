###Script para analizar la correlación entre las cuantificaciones de las diferentes estrategias de filtrado de reads

##Librerias requeridas
library(gplots)
library (RColorBrewer)

##Establecer la carpeta de trabajo
setwd("Ruta/de/trabajo")

##cargar el set de datos con nivles de expresión normalizados a cpm
counts = read.table ("cpm_Ot6735.txt", header=TRUE, row.names=1)

##Calcular y generar la matrix de coeficientes de correlación de Pearson entre las muestras 
matrix1=cor(counts, use="complete.obs", method="pearson")
#Revisar el formato de la matrix
matrix1
##Establecer la escala de valores
pair.break=seq(0.5,1,by=0.05)
##Establecer la escala de colores a usar
mycol=colorpanel(n=10, low="yellow", mid="gold", high="red2")
##Definir los parametros del archivo de imagen de salida
tiff(filename = "Ot6735_CompleteObs_pearson_CPM.tiff",height=5,width=5, pointsize = 5, 
     compression = c("none"), units="in", bg = "white", res = 300)
##Generar el mapa de calor con los datos de correlación de Pearson
heatmap.2 (matrix1, symm= TRUE, col=mycol[1:10], breaks=pair.break[1:11], keysize=1.5, 
          cexRow=3, cexCol=3, margin=c(10,10), trace=c("none"), densadj=0.10, 
          density.info=c("none"))
dev.off()
