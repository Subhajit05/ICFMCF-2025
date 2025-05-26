
library(cluster)


setwd("E:/Pub/Use of MLMs/Data")

procd_data <- read.csv("final_processed_data.csv")

procd_data <- procd_data[,-c(1,2,4,5,6,11,12,19)]

# Cluster details

## Cluster - 1  to 3 : ad_nifty & volume
## Cluster - 4 and 5 : vix_close and volume


# Creation of direction based clusters


clust <- pam(procd_data, k = 3)


km_cluster_data <- procd_data[,c(1,14)]

km_cluster <- kmeans(km_cluster_data, centers = 3)

cluster_comp <- round(prop.table(table(km_cluster$cluster))*100,2)

cluster_comp

clustered_data <- cbind(procd_data, cluster = km_cluster$cluster) 

cluster1 <- subset(clustered_data, subset = clustered_data$cluster==1)

cluster2 <- subset(clustered_data, subset = clustered_data$cluster==2)

cluster3 <- subset(clustered_data, subset = clustered_data$cluster==3)

file.create("dir_cluster1.csv")
file.create("dir_cluster2.csv")
file.create("dir_cluster3.csv")

write.csv(cluster1, "dir_cluster1.csv")

write.csv(cluster2, "dir_cluster2.csv")

write.csv(cluster3, "dir_cluster3.csv")


#####################################

# Creation of volatility based clusters

vol_cluster_data <- procd_data[, c(13, 14)]

km_cluster2 <- kmeans(vol_cluster_data,centers = 2)

cluster_comp2 <- round(prop.table(table(km_cluster2$cluster))*100,2)

cluster_comp2


clustered_data2 <- cbind(procd_data, cluster = km_cluster2$cluster)


cluster4 <- subset(clustered_data2, subset = clustered_data2$cluster==1)

cluster5 <- subset(clustered_data2, subset = clustered_data2$cluster==2)


file.create("vol_cluster4.csv")

file.create("vol_cluster5.csv")

write.csv(cluster4, "vol_cluster4.csv")

write.csv(cluster5, "vol_cluster5.csv")

###################################################

# Cluster composition

setwd("E:/PUb/Use of MLMs/Data/Clustered Data")
cluster1 <- read.csv("dir_cluster1.csv")

cluster2 <- read.csv("dir_cluster2.csv")

cluster3 <- read.csv("dir_cluster3.csv")

cluster4 <- read.csv("vol_cluster4.csv")

cluster5 <- read.csv("vol_cluster5.csv")

# Directional Composition

round(prop.table(table(cluster1$dr3)),2)

round(prop.table(table(cluster1$dr5)),2)

round(prop.table(table(cluster2$dr3)),2)

round(prop.table(table(cluster2$dr5)),2)

round(prop.table(table(cluster3$dr3)),2)

round(prop.table(table(cluster3$dr5)),2)

summary(cluster1)

summary(cluster2)

summary(cluster3)

summary(cluster4)

summary(cluster5)

hist(cluster4$vix_close, main = "Distribution of VIX", xlab = "Cluster 4")
hist(cluster5$vix_close, main = "Distribution of VIX", xlab = "Cluster 5")
hist(cluster1$ad_nifty, main = "Distribution of Chaikin's AD", xlab = "Cluster-1")
hist(cluster2$ad_nifty, main = "Distribution of Chaikin's AD", xlab = "Cluster-2")
hist(cluster3$ad_nifty, main = "Distribution of Chaikin's AD", xlab = "Cluster-3")


windows(10,10)

par(mfrow = c(1,3))

boxplot(cluster1$ad_nifty,cluster2$ad_nifty,cluster3$ad_nifty,
        cluster4$ad_nifty, cluster5$ad_nifty, main = "Distribution of Chainkins AD")


boxplot(cluster1$vol,cluster2$vol,cluster3$vol,
        cluster4$vol, cluster5$vol, main = "Volume profile of clusters")

boxplot(cluster1$vix_close,cluster2$vix_close,cluster3$vix_close,
        cluster4$vix_close, cluster5$vix_close, main = "Volatility profile of clusters")

#################################

library(factoextra)

fviz_cluster(cluster1, data = procd_data)
