data_file <- "fishies"
expl_file <- "fishtype"
group_name <- "Type"

# Simper on data with two groups
sp_data <- read.table(data_file,stringsAsFactors=FALSE)
gp_data <- read.table(expl_file,stringsAsFactors=FALSE)

zerorows <- NULL
for (i in 1:(dim(sp_data)[1])) {
  if (sum(sp_data[i,1:(dim(sp_data)[2])])==0) {
    zerorows <- c(zerorows,i)
  }
}

if (length(zerorows)>0) {
  sp_data <- sp_data[-zerorows,]
  gp_data <- sp_data[-zerorows,]
}

sp_output_between <- NULL
sp_output_within1 <- NULL
sp_output_within2 <- NULL
gp_col <- which(names(gp_data)==group_name)
gp_names <- unique(gp_data[,gp_col])

sp_data_1 <- sp_data[(which(gp_data[,gp_col]==gp_names[1])),]
sp_data_2 <- sp_data[(which(gp_data[,gp_col]==gp_names[2])),]
sp_data_1 <- data.matrix(sp_data_1)
sp_data_2 <- data.matrix(sp_data_2)

for (j in 1:(dim(sp_data_1)[1])) {
  temp_sp <- rowSums(abs(sweep(sp_data_2, 2, sp_data_1[j,], "-")))/(rowSums(sp_data_2)+sum(sp_data_1[j,]))
  temp_sp <- matrix(temp_sp,ncol=1)
  sp_output_between <- rbind(sp_output_between,temp_sp)
 }
write.table(sp_output_between,"sp_output_between",quote=FALSE,col.names=FALSE,row.names=FALSE)
rm(sp_output_between)

for (j in 1:(dim(sp_data_1)[1])) {
  temp_sp <- rowSums(abs(sweep(sp_data_1[-j,], 2, sp_data_1[j,], "-")))/(rowSums(sp_data_1[-j,])+sum(sp_data_1[j,]))
  temp_sp <- matrix(temp_sp,ncol=1)
  sp_output_within1 <- rbind(sp_output_within1,temp_sp)
 }
write.table(sp_output_within1,"sp_output_within1",quote=FALSE,col.names=FALSE,row.names=FALSE)
rm(sp_output_within1)

for (j in 1:(dim(sp_data_2)[1])) {
  temp_sp <- rowSums(abs(sweep(sp_data_2[-j,], 2, sp_data_2[j,], "-")))/(rowSums(sp_data_2[-j,])+sum(sp_data_2[j,]))
  temp_sp <- matrix(temp_sp,ncol=1)
  sp_output_within2 <- rbind(sp_output_within2,temp_sp)
 }
  