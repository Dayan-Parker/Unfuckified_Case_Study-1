clc,close all
load cluster_covid_data.mat
load classify_covid_data.mat


%centriods 
centriods;
centroid_labels = centriod_labels;

%% linear transformations
%convolution smoothing the test data




CONV_COVID_Rect_TEST = zeros(45,130);
%replace the number of rows with the correct amouont for the given data set
  

for i = 1:45
    CONV_COVID_Rect_TEST(i,:) = conv(CNTY_COVID_TEST(i,:),sm_rect,"same");
end

%replace the number of rows with the correct amouont for the given data set


save compotition.mat