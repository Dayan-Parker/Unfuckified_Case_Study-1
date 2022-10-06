% LABEL EACH PLOT and INCLUDE IN THE REPORT

%%loading all this dumb shit 
clc, clear, close all
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

%CNTY_COVID_TRAIN=[CNTY_COVID(1:215,:)];  %segment the data into train / test
%CNTY_COVID_TEST=[CNTY_COVID(216:225,:)];  %segment the data into train / text

%% more of dayan beeing a goofy guy

CNTY_CENSUS_1 = CNTY_CENSUS.DIVISION == 1;
CNTY_CENSUS_2 = CNTY_CENSUS.DIVISION == 2;
CNTY_CENSUS_3 = CNTY_CENSUS.DIVISION == 3;
CNTY_CENSUS_4 = CNTY_CENSUS.DIVISION == 4;
CNTY_CENSUS_5 = CNTY_CENSUS.DIVISION == 5;
CNTY_CENSUS_6 = CNTY_CENSUS.DIVISION == 6;
CNTY_CENSUS_7 = CNTY_CENSUS.DIVISION == 7;
CNTY_CENSUS_8 = CNTY_CENSUS.DIVISION == 8;
CNTY_CENSUS_9 = CNTY_CENSUS.DIVISION == 9;



%% traing/test seperation


%Leave five middle rows in between the beginning and end rows for each division

CNTY_COVID_TRAIN1=[CNTY_COVID(1:10,:)];%test set is 11:15
CNTY_COVID_TRAIN2=[CNTY_COVID(16:35,:)];%test set is 36:40
CNTY_COVID_TRAIN3=[CNTY_COVID(41:60,:)];%test set is 61:65
CNTY_COVID_TRAIN4=[CNTY_COVID(66:85,:)];%test set is 86:90
CNTY_COVID_TRAIN5=[CNTY_COVID(91:110,:)];%test set is 111:115
CNTY_COVID_TRAIN6=[CNTY_COVID(116:135,:)];%test set is 136:140
CNTY_COVID_TRAIN7=[CNTY_COVID(141:160,:)];%test set is 161:165
CNTY_COVID_TRAIN8=[CNTY_COVID(166:185,:)];%test set is 186:190
CNTY_COVID_TRAIN9=[CNTY_COVID(191:210,:)];%test set is 211:215
CNTY_COVID_TRAIN10=[CNTY_COVID(216:225,:)];
CNTY_COVID_TRAIN=cat(1,CNTY_COVID_TRAIN1,CNTY_COVID_TRAIN2,...
    CNTY_COVID_TRAIN3,CNTY_COVID_TRAIN4,CNTY_COVID_TRAIN5,...
    CNTY_COVID_TRAIN6,CNTY_COVID_TRAIN7,CNTY_COVID_TRAIN8,...
    CNTY_COVID_TRAIN9,CNTY_COVID_TRAIN10);

%{
scale census data
CNTY_CENUS_TRAIN1=[CNTY_CENUS(1:10,:)];%test set is 11:15
CNTY_CENUS_TRAIN2=[CNTY_COVID(16:35,:)];%test set is 36:40
CNTY_CENUS_TRAIN3=[CNTY_COVID(41:60,:)];%test set is 61:65
CNTY_CENUS_TRAIN4=[CNTY_COVID(66:85,:)];%test set is 86:90
CNTY_CENUS_TRAIN5=[CNTY_COVID(91:110,:)];%test set is 111:115
CNTY_CENUS_TRAIN6=[CNTY_COVID(116:135,:)];%test set is 136:140
CNTY_CENUS_TRAIN7=[CNTY_COVID(141:160,:)];%test set is 161:165
CNTY_CENUS_TRAIN8=[CNTY_COVID(166:185,:)];%test set is 186:190
CNTY_CENUS_TRAIN9=[CNTY_COVID(191:210,:)];%test set is 211:215
CNTY_CENUS_TRAIN10=[CNTY_COVID(216:225,:)];
CNTY_CENUS_TRAIN=cat(1,CNTY_COVID_TRAIN1,CNTY_COVID_TRAIN2,...
    CNTY_COVID_TRAIN3,CNTY_COVID_TRAIN4,CNTY_COVID_TRAIN5,...
    CNTY_COVID_TRAIN6,CNTY_COVID_TRAIN7,CNTY_COVID_TRAIN8,...
    CNTY_COVID_TRAIN9,CNTY_COVID_TRAIN10);
%}
%combine all those left-out middle rows in each division to form the test set
CNTY_COVID_TEST1=[CNTY_COVID(11:15,:)];%test set is 11:15
CNTY_COVID_TEST2=[CNTY_COVID(36:40,:)];%test set is 36:40
CNTY_COVID_TEST3=[CNTY_COVID(61:65,:)];%test set is 61:65
CNTY_COVID_TEST4=[CNTY_COVID(86:90,:)];%test set is 86:90
CNTY_COVID_TEST5=[CNTY_COVID(111:115,:)];%test set is 111:115
CNTY_COVID_TEST6=[CNTY_COVID(136:140,:)];%test set is 136:140
CNTY_COVID_TEST7=[CNTY_COVID(161:165,:)];%test set is 161:165
CNTY_COVID_TEST8=[CNTY_COVID(186:190,:)];%test set is 186:190
CNTY_COVID_TEST9=[CNTY_COVID(211:215,:)];%test set is 211:215
CNTY_COVID_TEST=cat(1,CNTY_COVID_TEST1,CNTY_COVID_TEST2,...
    CNTY_COVID_TEST3,CNTY_COVID_TEST4,CNTY_COVID_TEST5,...
    CNTY_COVID_TEST6,CNTY_COVID_TEST7,CNTY_COVID_TEST8,...
    CNTY_COVID_TEST9);



%% DAYAN GOOFS AROUND

%creat smoothing functions
sm_rect = 1/51*ones(1,51);  %50 length vector containing a singular value
g = 0:50;
sm_ham = -1/(51*2)*cos(1/51*2*pi*g) + 1/(51*2); %creating a hamming curve to compare smoothing too

%convolution smoothing time
CONV_COVID_Rect = zeros(180,130);
CONV_COVID_Ham = zeros(180,130);
   
for i = 1:length(CNTY_COVID_TRAIN)
    CONV_COVID_Rect(i,:) = conv(CNTY_COVID_TRAIN(i,:),sm_rect,"same");
    CONV_COVID_Ham(i,:) = conv(CNTY_COVID_TRAIN(i,:),sm_ham,"same");
end

%plot the smoothing methods
figure
subplot(3,2,1);
plot(dates,CNTY_COVID_TRAIN)
title("raw data")

subplot (3,2,2);
plot(sm_rect)
hold on
plot(sm_ham)
title("smoothing curves")
hold off

subplot(3,2,[3,4]);
plot(dates,CONV_COVID_Rect)
title("Rectangular Smoothing")

subplot(3,2,[5,6]);
plot(dates,CONV_COVID_Ham)
title("Hamming Smoothing")

%cleaned up plots
figure
subplot(3,2,1);
plot(dates,CNTY_COVID_TRAIN(1,:))
title("raw data row 1")

subplot (3,2,2);
plot(sm_rect)
hold on
plot(sm_ham)
title("smoothing curves")
hold off

subplot(3,2,[3,4]);
plot(dates,CONV_COVID_Rect(1,:))
title("Rectangular Smoothing row 1")

subplot(3,2,[5,6]);
plot(dates,CONV_COVID_Ham(1,:))
title("Hamming Smoothing row 1")

%% DAYAN's K-means
[clust_ham,centroids_ham] = kmeans(CONV_COVID_Ham,9,'Replicates',100);
[clust_rect,centroids_rect] = kmeans(CONV_COVID_Rect,9,'Replicates',100);
[clust,centroids] = kmeans(CNTY_COVID_TRAIN,9,'Replicates',100);

sill_Val_ham = silhouette(CONV_COVID_Ham,clust_ham);

sill_Val_rect = silhouette(CONV_COVID_Rect,clust_rect);

sill_Val = silhouette(CNTY_COVID_TRAIN,clust);

figure
silhouette(CONV_COVID_Ham,clust_ham);
figure
silhouette(CONV_COVID_Rect,clust_rect);
figure
silhouette(CNTY_COVID_TRAIN,clust_rect);

%% K-means bull she-ite
%{
%generate an elbow diagram to see if any k values better than others for this newly-grouped training data set of 9 divisions?
count=1;
for i=1:8
    [junk1,junk2,sumd] = kmeans(SUM_DIVISION_COVID_TRAIN,i);
    tempksum(:,count)=junk1;
    silkksum(:,count)=silhouette(SUM_DIVISION_COVID_TRAIN,tempksum(:,count));
    %figure
    Sum_of_SquDist_k0(count)=sum(sumd);
    count=count+1;
end
figure
plot(Sum_of_SquDist_k0);

%shows k=2 or k=3 as elbow point, so check silhouette plots at k=3 & k=4 to see which is best
[silkksum(:,2), H] = silhouette(SUM_DIVISION_COVID_TRAIN, tempksum(:,2));
[silkksum(:,3), H] = silhouette(SUM_DIVISION_COVID_TRAIN, tempksum(:,3));

%k=3 has the best silhouette values, even better than k=2
%so now run kmeans with k=3 on the training data and capture the centroids
[tempksum(:,3),Csum,sumd]=kmeans(SUM_DIVISION_COVID_TRAIN,3);
[silkksum(:,3), H] = silhouette(SUM_DIVISION_COVID_TRAIN, tempksum(:,3));
centroids = Csum;

%take the 45 test vectors from CNTY_COVID_TEST and figure out which of the 3 cluster centroids it’s closest to
%compute its Euclidean distance
D=pdist2(centroids,CNTY_COVID_TEST);
%return the index of the closest cluster distance for each of the 45 counties in I
[D,I]=pdist2(centroids,CNTY_COVID_TEST,'euclidean','smallest',1);

%I has one row with 45 entries, each tells the cluster of the test county,
%let’s see what cluster the test counties were assigned to
% they were ALL assigned to the same cluster #2 (??!)

%plot some of the counties and look for shared characteristics
figure
plot(CNTY_COVID_TEST(2,:));
hold on
plot(CNTY_COVID_TEST(10,:));
plot(CNTY_COVID_TEST(27,:));
plot(CNTY_COVID_TEST(34,:));
plot(CNTY_COVID_TEST(45,:));
hold off
%LABEL for cluster #2: low case counts with 5 peaks

tempksum(:,3) %shows us which division groups 1-9 of the training data were assigned to which of the 3 clusters
% 3     3    1     1     1     1     1     2     2

%all of these were assigned to cluster #1
figure
hold on
plot(SUM_DIVISION_COVID_TRAIN(2,:));
plot(SUM_DIVISION_COVID_TRAIN(3,:));
plot(SUM_DIVISION_COVID_TRAIN(4,:));
plot(SUM_DIVISION_COVID_TRAIN(5,:));
hold off
%LABEL for cluster #1: super high case counts with 4 peaks

%all of these were assigned to cluster #3
figure
hold on
plot(SUM_DIVISION_COVID_TRAIN(1,:));
plot(SUM_DIVISION_COVID_TRAIN(2,:));
hold off
%LABEL for cluster #3: super high case counts with 3 peaks


%generate labels
%now create a (k=3)x1 matrix of centroid labels with text strings for our descriptors of each centroid/cluster using the labels above

centroids_labels = ['super high 4 peaks';'low 5 peaks';'super high 3 peaks']

%CONCLUSION: in this Approach #2 there was a linear transformation on the original data set by combining them across geographic divisions and then using those summed up series to derive the clusters.  Clearly this approach eliminates a bit of the noise in the 180 individual county trajectories in the training data set by combining them into just 9 total trajectories, which leads to much more efficient clustering, going from 5 clusters in Approach 1 to just 3 clusters in Approach 2 with clearer differentiation among the cluster members.
%}