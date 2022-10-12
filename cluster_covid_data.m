clc,clear, close all
load('COVIDbyCounty.mat')  %load the data

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

%Displaying the sums of all silhouette values to more accuratly understand
%which smoothing method is most effective.

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


%the convolution with the linear function gave us the best convolution
%value

save cluster_covid_data.mat