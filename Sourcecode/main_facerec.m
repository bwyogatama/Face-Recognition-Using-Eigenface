%% Face recognition
% This algorithm uses the eigenface system (based on pricipal component
% analysis - PCA) to recognize faces. For more information on this method
% refer to http://cnx.org/content/m12531/latest/

%% Clear everything before starting
clear all;close all;clc;


%% Loading the datasets into matrix w
[ w, labels ] = loadSubset(2); %training set of 10 subjects x 7 lighting conditions x (50x50 pixels) image
[ w2, labels2 ] = loadSubset(3);% test set of 10 subjects x 12 lighting conditions x (50x50 pixels) image

%% Perform face recognition with varying N (number of eigenface components)
Acc=[];MinDist=[];Recog=[];
for N=1:size(w,2)
    [acc, mindist, recog] = face_recognition(w, labels, w2, labels2,N);
    Acc= [Acc, acc];
    MinDist= [MinDist; mindist];
    Recog = [Recog; recog];
end

%threshold = ThresholdSearch (w,labels,w2,labels2);
figure, plot(1:1:size(w,2),Acc); axis([1 size(w,2) 0 1]); title ('Number of EigenFace Components vs Accuracy')