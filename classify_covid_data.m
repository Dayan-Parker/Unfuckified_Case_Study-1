%% Labeling centriods
clear, clc, close all

load cluster_covid_data.mat

%convolution smoothing the test data
CONV_COVID_Rect_TEST = zeros(45,130);
  

for i = 1:45 
    CONV_COVID_Rect_TEST(i,:) = conv(CNTY_COVID_TEST(i,:),sm_rect,"same");
end


clusters_sort = sortrows(clust_rect,'descend');

%findig the average vectors for each cluster from the test data

avg_1 = mean(CONV_COVID_Rect(clusters_sort == 1,:));
avg_2 = mean(CONV_COVID_Rect(clusters_sort == 2,:));
avg_3 = mean(CONV_COVID_Rect(clusters_sort == 3,:));
avg_4 = mean(CONV_COVID_Rect(clusters_sort == 4,:));
avg_5 = mean(CONV_COVID_Rect(clusters_sort == 5,:));
avg_6 = mean(CONV_COVID_Rect(clusters_sort == 6,:));
avg_7 = mean(CONV_COVID_Rect(clusters_sort == 7,:));
avg_8 = mean(CONV_COVID_Rect(clusters_sort == 8,:));
avg_9 = mean(CONV_COVID_Rect(clusters_sort == 9,:));

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
else
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


centriods = centroids_rect;
centriod_labels = ["Division 1"; "Division 7"; "Division 4"; "Division 3"; "Division 8"; "Division 5"; "Division 6"; "Division 2"; "Division 1"];
labeled_centriods = [centriod_labels,centroids_rect];


save classify_covid_data.mat