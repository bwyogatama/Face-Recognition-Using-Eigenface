%% Face recognition
% This algorithm uses the eigenface system (based on pricipal component
% analysis - PCA) to recognize faces. For more information on this method
% refer to http://cnx.org/content/m12531/latest/

%% Clear everything before starting
clear all;close all;clc;

%% For writing all processed picture to new subset 4,3,5
%display();


%% Loading the datasets into matrix w
[ w, labels ] = loadSubset(2); %training set of 10 subjects x 7 lighting conditions x (50x50 pixels) image
[ w2, labels2 ] = loadSubset(3);% test set of 10 subjects x 12 lighting conditions x (50x50 pixels) image


%% Perform face recognition with varying N (number of eigenface components)
Acc=[];MinDist=[];Recog=[]; FAR_f=[]; FRR_f=[];
N=44;
for threshold=1:300
    [acc, mindist, recog, FAR, FRR] = face_recognition_th(w, labels, w2, labels2, N, threshold);
    Acc= [Acc, acc];
    MinDist= [MinDist; mindist];
    Recog = [Recog; recog];
    FAR_f = [FAR_f, FAR];
    FRR_f = [FRR_f, FRR];
end

[EER TR] = HitungEER(FAR_f,FRR_f);
EER;
TR;

figure, legend(plot(1:1:threshold, FRR_f, 1:1:threshold, FAR_f, 1:1:threshold, Acc),'FRR','FAR','Acc'); axis([1 threshold 0 1]); title ('FAR-FRR-Acc vs Threshold')
%plot(1:1:5, FRR_f);