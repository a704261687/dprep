clean <-
function (w,tol.col=0.5,tol.row=0.3,name="") 

{

#w: matrix that will be cleaned
#tol.col: maximum percentage of missing to be allowed for columns
#tol.row: maximum percentage of missing in relevant variables to be allowed
#attrib: matrix, mx1, containing column index of relevant variables

w=as.data.frame(w)
w=as.matrix(w) 
if (sum(is.na(w))==0) cat ("No cleaning required.\n")
else
 { 
  filename=paste("Clean.rep.",name,sep="")
  zz <- textConnection(filename, "w")
  rep.title=paste("Cleaning report for the matrix: ",name)
  sink(zz)
  cat("\n",rep.title,"\n\n")
  sink()

  #Find column indexes of columns with NA 
  sumcol=which(colSums(is.na(w))!=0,arr.ind=TRUE)

  if (length(sumcol)!=0)  
   {
    #clean columns
  
    dr=dim(w)[1]
    dc=dim(w)[2]
    if (length(sumcol)==1)
     {
      per.miss.col=sum(is.na(w[,sumcol]))/dr
      
      #Report of variables to be removed
      colmiss=colnames(w)[sumcol]
      
table.miss=data.frame(cbind(Variables=colmiss,Percent.of.missing=(per.miss.col*100)),row.names
=NULL)
      print(table.miss)
      cat("\n")
 
     sink(zz)
     print(table.miss)
     cat("\n")
     sink()

      if (per.miss.col>tol.col)
        {
         cat("Only one variable eliminated: ",colnames(w)[above.tol],"\n\n")

         sink(zz)
 cat("Only one variable eliminated: ",colnames(w)[above.tol],"\n\n")
         sink()

         w=w[,-sumcol] 
         w=as.matrix(w)
        }
     }
    else
    {
    #find percent of missing
    per.miss.col=colSums(is.na(w[,sumcol]))/dr

    #find index of columns with NA over tolerance
    above.tol=sumcol[which(per.miss.col>tol.col,arr.ind=TRUE)]
    
    #Preparing report on percents missing per variable
    colmiss=colnames(w)[sumcol]
    
table.miss=data.frame(cbind(Variables=colmiss,Percent.of.missing=(per.miss.col*100)),row.names
=NULL)
    print(table.miss)
    cat("\n")
     
    sink(zz)
    print(table.miss)
    cat("\n")
    sink()

    if (length(above.tol)==dim(w)[2])
     { 
      cat("All variables have missing values above tolerance level.\n\n") 

      sink(zz)
      cat("All variables have missing values above tolerance level.\n\n")
      sink()
     }
    else 
     if (length(above.tol)!=0)      
      {
       #Report of columns to be eliminated
       col.above.tol=matrix(colnames(w)[above.tol],length(above.tol),1)
       colnames(col.above.tol)="Variables eliminated"
       rownames(col.above.tol)=c(1:length(above.tol))
       print(col.above.tol)
       cat("\n\n")
      
       sink(zz)
       print(col.above.tol)
       cat("\n\n")
       sink()

       #Column elimination
       w=w[,-above.tol]
       w=as.matrix(w)
      }
   
    }
    
   
    #recalculate for new w and row cleaning
    dr=dim(w)[1]
    dc=dim(w)[2]
     
   }

  #Find index of rows with missing values
  sumrow=which(rowSums(is.na(w))!=0,arr.ind=TRUE)
  
  if (length(sumrow)!=0)
   {
    if (length(sumrow)==1)
       {
        per.miss.row=sum(is.na(w[sumrow,]))/dc
        #clean rows
        if (per.miss.row>tol.row)
           {
            cat("Number of instances eliminated: 1\n")
            cat("Instance eliminated              :",sumrow,"\n\n")

            sink(zz)
         cat("Number of instances eliminated: 1\n")
            cat("Instance eliminated              :",sumrow,"\n\n")
            sink()

            w=w[-sumrow,] 
           }
        }
    else
      {
      #begin to clean rows
      #calculate percent of rows with missing
      per.miss.row=rowSums(is.na(w[sumrow,]))/dc
      
      #calculate percent of rows with missing
      #rowmiss=
      #cat("Percent of rows with missing: ",per.miss.row*100,"\n")
      #cat("Number of rows with missing: ",rowSums(is.na(w[sumrow,])),"\n")
      #sink(zz)
      #cat("Percent of rows with missing: ",per.miss.row*100,"\n")
      #cat("Number of rows with missing: ",rowSums(is.na(w[sumrow,])),"\n")
      #sink()

      #find index of rows with NA over tolerance
      above.tol=sumrow[which(per.miss.row>tol.row,arr.ind=TRUE)]
      if (length(above.tol)==dr) cat("All instances have missing values above tolerance level.\n") 
      else 
      if (length(above.tol)!=0)
       {
        cat("Number of instances eliminated:",length(above.tol),"\n")
        cat("Instance eliminated           :",as.numeric(above.tol),"\n\n")

        sink(zz)
        cat("Number of instances eliminated:",length(above.tol),"\n")
        cat("Instance eliminated           :",as.numeric(above.tol),"\n\n")
        sink()

        w=w[-(above.tol),] 
       }
      }
    }
   }

w=as.matrix(w)
cat("Maximum number of values to be imputed: ",sum(is.na(w)),"\n")

sink(zz)
cat("Maximum number of values to be imputed: ",sum(is.na(w)),"\n")
sink()
close(zz) 
#print(w)
return(w)
}

