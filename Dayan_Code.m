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

%sort the cenus data in the same manor
CENSUS_1 = CNTY_CENSUS.DIVISION(1:10,:);%test set is 11:15
CENSUS_2 = CNTY_CENSUS.DIVISION(16:35,:);%test set is 36:40
CENSUS_3=CNTY_CENSUS.DIVISION(41:60,:);%test set is 61:65
CENSUS_4=CNTY_CENSUS.DIVISION(66:85,:);%test set is 86:90
CENSUS_5=CNTY_CENSUS.DIVISION(91:110,:);%test set is 111:115
CENSUS_6=CNTY_CENSUS.DIVISION(116:135,:);%test set is 136:140
CENSUS_7=CNTY_CENSUS.DIVISION(141:160,:);%test set is 161:165
CENSUS_8=CNTY_CENSUS.DIVISION(166:185,:);%test set is 186:190
CENSUS_9=CNTY_CENSUS.DIVISION(191:210,:);%test set is 211:215
CENSUS_10=CNTY_CENSUS.DIVISION(216:225,:);
CENSUS_TRAIN=cat(1,CENSUS_1,CENSUS_2,...
    CENSUS_3,CENSUS_4,CENSUS_5,...
    CENSUS_6,CENSUS_7,CENSUS_8,...
    CENSUS_9,CENSUS_10);



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

%sort the cenus data in the same manor
CENSUS_1t = CNTY_CENSUS.DIVISION(11:15,:);%test set is 11:15
CENSUS_2t = CNTY_CENSUS.DIVISION(36:40,:);%test set is 36:40
CENSUS_3t=CNTY_CENSUS.DIVISION(61:65,:);%test set is 61:65
CENSUS_4t=CNTY_CENSUS.DIVISION(86:90,:);%test set is 86:90
CENSUS_5t=CNTY_CENSUS.DIVISION(111:115,:);%test set is 111:115
CENSUS_6t=CNTY_CENSUS.DIVISION(136:140,:);%test set is 136:140
CENSUS_7t=CNTY_CENSUS.DIVISION(161:165,:);%test set is 161:165
CENSUS_8t=CNTY_CENSUS.DIVISION(186:190,:);%test set is 186:190
CENSUS_9t=CNTY_CENSUS.DIVISION(211:215,:);%test set is 211:215
CENSUS_TEST=cat(1,CENSUS_1t,CENSUS_2t,CENSUS_3t,CENSUS_4t,CENSUS_5t,CENSUS_6t,CENSUS_7t,CENSUS_8t,CENSUS_9t);


%% Smoothinig using convolution
%create smoothing functions
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
plot(dates,CNTY_COVID_TRAIN(1:2,:))
title("raw data row 1")

subplot (3,2,2);
plot(sm_rect)
hold on
plot(sm_ham)
title("smoothing curves")
hold off

subplot(3,2,[3,4]);
plot(dates,CONV_COVID_Rect(1:2,:))
title("Rectangular Smoothing row 1")

subplot(3,2,[5,6]);
plot(dates,CONV_COVID_Ham(1:2,:))
title("Hamming Smoothing row 1")

%% K-means clustering

[clust_ham,centroids_ham] = kmeans(CONV_COVID_Ham,9,'Replicates',100);
[clust_rect,centroids_rect] = kmeans(CONV_COVID_Rect,9,'Replicates',100);
[clust,centroids_norm] = kmeans(CNTY_COVID_TRAIN,9,'Replicates',100);

sill_Val_ham = sum(silhouette(CONV_COVID_Ham,clust_ham));

sill_Val_rect = sum(silhouette(CONV_COVID_Rect,clust_rect));

sill_Val = sum(silhouette(CNTY_COVID_TRAIN,clust));

figure
silhouette(CONV_COVID_Ham,clust_ham);
title("Sihouette of convolution smoothing Hamming Curve")
figure
silhouette(CONV_COVID_Rect,clust_rect);
title("Sihouette of convolution smoothing linear Curve")
figure
silhouette(CNTY_COVID_TRAIN,clust);
title("Sihouette of the unchanged clusters")

%using the linear convoluted data gave the best results

%Displaying the sums of all silhouette values to more accuratly understand
%which smoothing method is most effective.
ham_sill = sum(sill_Val_ham);
rect_sill = (sill_Val_rect);
normal_sill = (sill_Val);


%% Labeling through graphical analysis


%convolution smoothing the test data
CONV_COVID_Rect_TEST = zeros(45,130);


for i = 1:45
    CONV_COVID_Rect_TEST(i,:) = conv(CNTY_COVID_TEST(i,:),sm_rect,"same");
end


clusters_sort = sortrows(clust_rect,'descend');

%findig the average vectors for each cluster from the test data

%sort for cluster 1
if sum(size(CONV_COVID_Rect(clusters_sort == 1,:))) > sum([1,130])
    avg_1 = mean(CONV_COVID_Rect(clusters_sort == 1,:));
else
    avg_1 = CONV_COVID_Rect(clusters_sort == 1,:);
end

%sort for cluster 2
if sum(size(CONV_COVID_Rect(clusters_sort == 2,:))) > sum([1,130])
    avg_2 = mean(CONV_COVID_Rect(clusters_sort == 2,:));
else
    avg_2 = CONV_COVID_Rect(clusters_sort == 2,:);
end

%sort for cluster 3
if sum(size(CONV_COVID_Rect(clusters_sort == 3,:))) > sum([1,130])
    avg_3 = mean(CONV_COVID_Rect(clusters_sort == 3,:));
else
    avg_3 = CONV_COVID_Rect(clusters_sort == 3,:);
end

%sort for cluster 4
if sum(size(CONV_COVID_Rect(clusters_sort == 4,:))) > sum([1,130])
    avg_4 = mean(CONV_COVID_Rect(clusters_sort == 4,:));
else
    avg_4 = CONV_COVID_Rect(clusters_sort == 4,:);
end

%sort for cluster 5
if sum(size(CONV_COVID_Rect(clusters_sort == 5,:))) > sum([1,130])
    avg_5 = mean(CONV_COVID_Rect(clusters_sort == 5,:));
else
   avg_5 = CONV_COVID_Rect(clusters_sort == 5,:);
end

%sort for cluster 6
if sum(size(CONV_COVID_Rect(clusters_sort == 6,:))) > sum([1,130])
    avg_6 = mean(CONV_COVID_Rect(clusters_sort == 6,:));    
else
    avg_6 = CONV_COVID_Rect(clusters_sort == 6,:);
end

%sort for cluster 7
if sum(size(CONV_COVID_Rect(clusters_sort == 7,:))) > sum([1,130])
    avg_7 = mean(CONV_COVID_Rect(clusters_sort == 7,:));
    
else
    avg_7 = CONV_COVID_Rect(clusters_sort == 7,:);
end

%for cluster 8
if sum(size(CONV_COVID_Rect(clusters_sort == 8,:))) > sum([1,130])
    avg_8 = mean(CONV_COVID_Rect(clusters_sort == 8,:)); 
    elseg
    avg_8 = CONV_COVID_Rect(clusters_sort == 8,:);
end

%for cluster 9
if sum(size(CONV_COVID_Rect(clusters_sort == 1,:))) > sum([1,130])
    avg_9 = mean(CONV_COVID_Rect(clusters_sort == 1,:));
else
    avg_9 = CONV_COVID_Rect(clusters_sort == 1,:);
end

avg_clust = [avg_1; avg_2; avg_3; avg_4; avg_5; avg_6; avg_7; avg_8; avg_9];
%findig the average vectors for each division in the test data

avg_labeled_1 = mean(CONV_COVID_Rect_TEST(CENSUS_TEST == 1,:));
avg_labeled_2 = mean(CONV_COVID_Rect_TEST(CENSUS_TEST == 2,:));
avg_labeled_3 = mean(CONV_COVID_Rect_TEST(CENSUS_TEST == 3,:));
avg_labeled_4 = mean(CONV_COVID_Rect_TEST(CENSUS_TEST == 4,:));
avg_labeled_5 = mean(CONV_COVID_Rect_TEST(CENSUS_TEST == 5,:));
avg_labeled_6 = mean(CONV_COVID_Rect_TEST(CENSUS_TEST == 6,:));
avg_labeled_7 = mean(CONV_COVID_Rect_TEST(CENSUS_TEST == 7,:));
avg_labeled_8 = mean(CONV_COVID_Rect_TEST(CENSUS_TEST == 8,:));
avg_labeled_9 = mean(CONV_COVID_Rect_TEST(CENSUS_TEST == 9,:));

avg_labeled = [avg_labeled_1;avg_labeled_2;avg_labeled_3;avg_labeled_4;avg_labeled_5;avg_labeled_6;avg_labeled_7;avg_labeled_8;avg_labeled_9];

cent_1 = zeros(9,130);
cent_2 = zeros(9,130);
cent_3 = zeros(9,130);
cent_4 = zeros(9,130);
cent_5 = zeros(9,130);
cent_6 = zeros(9,130);
cent_7 = zeros(9,130);
cent_8 = zeros(9,130);
cent_9 = zeros(9,130);

%Graph the avgerage k-means clusters and average labeled data
figure
subplot(2,2,[1,2])
plot(dates, avg_1)
hold on
plot(dates, avg_2)
plot(dates, avg_3)
plot(dates, avg_4)
plot(dates, avg_5)
plot(dates, avg_6)
plot(dates, avg_7)
plot(dates, avg_8)
plot(dates, avg_9)
title("Kmeans Clusters")
legend("Cluster 1","Cluster 2","Cluster 3","Cluster 4","Cluster 5","Cluster 6","Cluster 7","Cluster 8","Cluster 9")
hold off

subplot(2,2,[3,4])
plot(dates, avg_labeled_1)
hold on
plot(dates, avg_labeled_2)
plot(dates, avg_labeled_3)
plot(dates, avg_labeled_4)
plot(dates, avg_labeled_5)
plot(dates, avg_labeled_6)
plot(dates, avg_labeled_7)
plot(dates, avg_labeled_8)
plot(dates, avg_labeled_9)
title("Labeled Clusters")
legend("Division 1","Division 2","Division 3","Division 4","Division 5","Division 6","Division 7","Division 8","Division 9")
hold off

%find the diffrence between each element of each clusters and the avg
%labeled graph
for j = 1:9
    for i = 1:130
    cent_1(j,i) = avg_clust(j,i) - avg_labeled(1,i);
    cent_2(j,i) = avg_clust(j,i) - avg_labeled(2,i);
    cent_3(j,i) = avg_clust(j,i) - avg_labeled(3,i);
    cent_4(j,i) = avg_clust(j,i) - avg_labeled(4,i);
    cent_5(j,i) = avg_clust(j,i) - avg_labeled(5,i);
    cent_6(j,i) = avg_clust(j,i) - avg_labeled(6,i);
    cent_7(j,i) = avg_clust(j,i) - avg_labeled(7,i);
    cent_8(j,i) = avg_clust(j,i) - avg_labeled(8,i);
    cent_9(j,i) = avg_clust(j,i) - avg_labeled(9,i);
    end

end

%label the clusters based on which cluster has the smallest diffrence
%between it and the division

for i = 1:9
    cent_1s (i,:) = abs(sum(cent_1(i,:)));
    cent_2s (i,:) = abs(sum(cent_2(i,:)));
    cent_3s (i,:) = abs(sum(cent_3(i,:)));
    cent_4s (i,:) = abs(sum(cent_4(i,:)));
    cent_5s (i,:) = abs(sum(cent_5(i,:)));
    cent_6s (i,:) = abs(sum(cent_6(i,:)));
    cent_7s (i,:) = abs(sum(cent_7(i,:)));
    cent_8s (i,:) = abs(sum(cent_8(i,:)));
    cent_9s (i,:) = abs(sum(cent_9(i,:)));
end

[min_1, idx_1] = min(cent_1s);
[min_2, idx_2] = min(cent_2s);
[min_3, idx_3] = min(cent_3s);
[min_4, idx_4] = min(cent_4s);
[min_5, idx_5] = min(cent_5s);
[min_6, idx_6] = min(cent_6s);
[min_7, idx_7] = min(cent_7s);
[min_8, idx_8] = min(cent_8s);
[min_9, idx_9] = min(cent_9s);

division_1 = idx_1;
division_2 = idx_2;
division_3 = idx_3;
division_4 = idx_4;
division_5 = idx_5;
division_6 = idx_6;
division_7 = idx_7;
division_8 = idx_8;
division_9 = idx_9;


centriods = centriods_rect;
centriod_labels = ["Division 1"; "Division 2"; "Division 4"; "Division 3"; "Division 8"; "Division 5"; "Division 6"; "Division 2"; "Division 1"]
labeled_centriods = [centriod_labels,centroids_rect];


