load('COVIDbyCounty.mat')  %load the data
temp = CNTY_COVID.';   %transpose the COVID series so the columns = counties, rows = timestamps
temp1 = corr(temp);  %run correlation that looks at each column = county and compares them
plot(temp1);  %plot shows there is real correlation, which makes clustering worthwhile
max1 = max(temp1);  
subplot(1,2,1)   % look at the correlation trends for different counties
plot(temp1(1,:));
subplot(1,2,2)
plot(temp1(10,:));
%these data are worth clustering

CNTY_COVID_TRAIN=[CNTY_COVID(1:215,:)];  %segment the data into train / test
CNTY_COVID_TEST=[CNTY_COVID(216:225,:)];  %segment the data into train / text

SUM_CNTY_COVID_TRAIN=sum(CNTY_COVID_TRAIN.');  %for each county, across its timestamps, add the incremental # of cases for the case total
figure
pareto(SUM_CNTY_COVID_TRAIN,1);


temp3 = kmeans(CNTY_COVID_TRAIN,9);  %try clustering with 9 clusters, based on having 9 divisions
sil1 = silhouette(CNTY_COVID_TRAIN, temp3);  %compute quality of clustering w/ silhouette
figure
[sil1, H] = silhouette(CNTY_COVID_TRAIN, temp3);  %plot the silhouette values, to see if there are negatives or low values (bad)

%clustering into 9 divisions yields poor silhouette values, we can and should do better

%let’s try clustering with different values of k from 2:100 and then plotting the Sum of Sq distances from the respective centroids, to see if there’s an ‘elbow’ that shows us the optimal # of clusters to have
count=1;
for i=2:100
[junk1,junk2,sumd] = kmeans(CNTY_COVID_TRAIN,i);
tempk(:,count)=junk1;
silk(:,count)=silhouette(CNTY_COVID_TRAIN,tempk(:,count)); 
%figure
Sum_of_SquDist(count)=sum(sumd);
count=count+1;
end
figure
plot(Sum_of_SquDist);

%looking at this plot, we see somewhat of an ‘elbow’ in the area from k=4 through k=9
%Let’s look at silhouette graphs for different k values to see what’s best
figure
[silk(:,9), H] = silhouette(CNTY_COVID_TRAIN, tempk(:,9));
figure
[silk(:,8), H] = silhouette(CNTY_COVID_TRAIN, tempk(:,8));
figure
[silk(:,7), H] = silhouette(CNTY_COVID_TRAIN, tempk(:,7));
figure
[silk(:,6), H] = silhouette(CNTY_COVID_TRAIN, tempk(:,6)); 
figure
[silk(:,5), H] = silhouette(CNTY_COVID_TRAIN, tempk(:,5));
figure
[silk(:,4), H] = silhouette(CNTY_COVID_TRAIN, tempk(:,4));

% k=4 gives us the best silhouette so let’s go with k=4
[tempk(:,4),C,sumd]=kmeans(CNTY_COVID_TRAIN,4);
[silk(:,4), H] = silhouette(CNTY_COVID_TRAIN, tempk(:,4)); 

%now let’s get the centroids matrix C for k=4
centroids = C;
%take the 10 test vectors from CNTY_COVID_TEST and figure out which of the 4 cluster centroids it’s closest to
%compute its Euclidean distance
D=pdist2(centroids,CNTY_COVID_TEST);
%return the index of the closest cluster distance for each of the 10 counties in I
[D,I]=pdist2(centroids,CNTY_COVID_TEST,'euclidean','smallest',1);
%I has one row with 10 entries, each tells the cluster of the test county

%figure out the meaning of these centroids – do they represent times of peak volumes, times of a certain magnitude, times when there was a spike in certain geographies?

%now let’s try cleaning the training data by adding it across all the counties in a given geographic division in the CENSUS data set, for each of the 9 divisions in the CENSUS
% we want to produce a matrix that has 9 rows x 130 columns = sum of all counties in each of those 9 divisions across time 

SUM_DIVISION_COVID_TRAIN = zeros(9,130); 
tempsum=zeros(1,130);
for j=1:9
for r=1:215
if CNTY_CENSUS{r,3} == j
tempsum=(CNTY_COVID_TRAIN(r,:));
SUM_DIVISION_COVID_TRAIN(j,:)=SUM_DIVISION_COVID_TRAIN(j,:) + tempsum;   
%the new case counts for that division = whatever it was before + tempsum
end;
end;
end;

plot(SUM_DIVISION_COVID_TRAIN(1,:));
hold on
plot(SUM_DIVISION_COVID_TRAIN(2,:));
plot(SUM_DIVISION_COVID_TRAIN(3,:));
plot(SUM_DIVISION_COVID_TRAIN(4,:));
plot(SUM_DIVISION_COVID_TRAIN(5,:));
plot(SUM_DIVISION_COVID_TRAIN(6,:));
plot(SUM_DIVISION_COVID_TRAIN(7,:));
plot(SUM_DIVISION_COVID_TRAIN(8,:));
plot(SUM_DIVISION_COVID_TRAIN(9,:));

I

plot(CNTY_COVID_TEST(1,:));
hold on
plot(CNTY_COVID_TEST(3,:));
plot(CNTY_COVID_TEST(4,:));
plot(CNTY_COVID_TEST(5,:));
plot(CNTY_COVID_TEST(9,:));

%%

figure 
plot(CNTY_COVID_TEST(1,:))
hold on
plot(CNTY_COVID_TEST(2,:))
plot(CNTY_COVID_TEST(8,:))
plot(CNTY_COVID_TEST(9,:))
plot(CNTY_COVID_TEST(10,:))