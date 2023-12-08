##Establecer la carpeta de trabajo
setwd("Ruta/de/trabajo")

#Cluster dendograma
counts = read.table ("expLevels_frijol_MK.txt", header=TRUE, row.names=1)
head(counts)

#Calcular coeficientes de correlacion y generar la matrix de correlacion.
matrix1=cor(counts, use="complete.obs", method="pearson")
matrix1

#clusterizar usando hclust
hc <- hclust(dist(matrix1), "average")
plot(hc)

#Guardar y crear la imagen (en el directorio establecido)
tiff(filename = "_DendogramaClust_libraries_Average_CPM_14_frijol.tiff", width=1024, height=768, 
     units = "px", pointsize = 12, compression = c("lzw"), bg = "white", res =NA)
plot(hc, pch=20, cex=1.5, cex.main=1, cex.axis=1.3, cex.lab=1.3, cex.sub=1.3)
dev.off()

