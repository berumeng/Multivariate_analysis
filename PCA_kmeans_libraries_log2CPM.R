###Script para analizar los niveles de expresion realizando un PCA
##Librerias requeridas
library("cluster")

##Establecer la carpeta de trabajo
setwd("/Users/berumen/Desktop/Análisis_visualización_datos_R/R_script/Clusterplot/")

##cargar el set de datos
counts = read.table ("expLevels_frijol_MK.txt", header=TRUE, row.names=1)

#Calcular coeficientes de correlacion y generar la matrix de correlacion.
matrix1=cor(counts, use="complete.obs", method="pearson")
matrix1

#clusterizar usando kmeans
fit=kmeans(matrix1,7)
fit

#Graficar los componentes (PCA)
tiff(filename = "PCA_libraries_log2CPM.tiff", height=5,width=5, units = "in", 
     pointsize = 5, compression = c("lzw"), bg = "white", res = 300)
#tiff(filename = "PCA_librariesSinHYP_CPM_7clust_new.tiff",height=8.27,width=11.69, pointsize = 5, compression = c("none"), units="in",
#bg = "white", res = 800)

#Generar la gráfica
#col.pc Color de los puntos.
clusplot(matrix1, fit$cluster, color=FALSE, shade=FALSE, labels=2, lines=0, plotchar=TRUE, 
         cex=1.5, col.p=c("blue","blue","blue","blue","blue","darkred","darkred","darkred",
                          "darkred","darkred", "darkgreen","darkgreen","darkgreen","darkgreen","darkgreen",
                          "darkgreen","magenta","orange","orange","orange", "orange","orange",
                          "orange","black","black"), xlim=c(-8,8), ylim=c(-5.5,5.5),
         col.clus=c(1,1,1,1,1,1), cex.axis=1.5, cex.lab=1, cex.sub=1.5)
abline(0,0, col="gray", lty=2, lwd=0.2)
abline(v=0, col="gray", lty=2, lwd=0.2)
dev.off()
