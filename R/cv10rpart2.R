cv10rpart2 <-
function(datos)
{
# This function finds out the number of instances correctly classified by the
# decision tree classifier,rpart, using 10- fold cross validation
# and one repetition
# Requieres the rpart library 
# inputs:
# datos: the dataset to be used
# Edgar Acuna-Caroline Rodriguez, March 2004
#----------------------------------------------- 
 library(rpart)
 datos=as.data.frame(datos)
 n <- dim(datos)[1]
 p <- dim(datos)[2]
 nombres<-colnames(datos)
 f1<-as.formula(paste(nombres[p],".",sep="~"))
 
 salida <- matrix(0, 1, 10)
 azar <- datos[rank(runif(n)),  ]
 azar[, p] <- as.factor(azar[, p])
 parti <- floor(n/10)
 for(j in 1:10) 
  {
   cc <- ((j - 1) * parti + 1):(j * parti)
   if(j == 10) 
   {
    cc <- ((j - 1) * parti + 1):n
   }
   datap <- azar[cc,  ]
   datat <- azar[ - cc,  ]
   arbol <- rpart(f1, data = datat, method="class")
   pd1<-predict(arbol,datap)
   pd2=max.col(pd1)
   salida[j] <- sum(pd2!=datap[, p])
  }
 
 gooderr<- n-sum(salida)
 
 return(gooderr)
}

