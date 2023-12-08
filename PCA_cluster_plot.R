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

#PCA (analisis de componentes rpincipales)
library("FactoMineR")
library(factoextra)
res.pca <- PCA(norm3,  graph = FALSE)

# Extract eigenvalues/variances
get_eig(res.pca)

# Visualize eigenvalues/variances
fviz_screeplot(res.pca, addlabels = TRUE, ylim = c(0, 50))

#Visualizar valores de dimensiones
fviz_eig(res.pca)

#VARIABLES PCA....
fviz_pca_var(res.pca, col.var = "black")

#PCA con colores
fviz_pca_var(res.pca, col.var="contrib",
             gradient.cols = c("#00AFBB", "#E7B800", "#FC4E07"),
             ggtheme = theme_classic()
)


# Contributions of variables to PC1
fviz_contrib(res.pca, choice = "var", axes = 1, top = 10)

# Contributions of variables to PC2
fviz_contrib(res.pca, choice = "var", axes = 2, top = 10)

# 3. Use gradient color
fviz_pca_ind(res.pca, col.ind = "cos2",
             gradient.cols = c("#00AFBB", "#E7B800", "#FC4E07"),
             ggtheme = theme_classic() #tema clasico, quita el fondo
)

# Biplot of individuals and variables
fviz_pca_biplot(res.pca, repel = TRUE)

#########################################
# ANTES PCA analysis #PARA ESTE PCA SE NECESITAN TODAS LAS MEDICIONES Y SE NECESITAN CARACTERES
#SE AGRUPA DE MANERA INDIVIDUAL.
#SE PUEDE HACER USANDO LOS DATOS DE "IRis"
data("iris")
iris.pca <- PCA(iris[,-5], graph = FALSE)
# Visualize
# Use habillage to specify groups for coloring
fviz_pca_ind(iris.pca,
             label = "none", # hide individual labels
             habillage = iris$Species, # color by groups
             palette = c("#00AFBB", "#E7B800", "#FC4E07"),
             addEllipses = TRUE # Concentration ellipses
)

#####################################





