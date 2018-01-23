function opt_TR = ThresholdSearch(w, labels, w2, labels2,N)
%% Loading the datasets into matrix w
[ w, labels ] = loadSubset(0); %training set of 10 subjects x 7 lighting conditions x (50x50 pixels) image
[ w2, labels2 ] = loadSubset(1);% test set of 10 subjects x 12 lighting conditions x (50x50 pixels) image


% w = training set,labels = training set labels
% w2 = test set,labels2 = test set labels
% N = number of eigenface components used (starting from the first
% eigenface corresponding to the highest eigenvalue)
% acc = accuracy (number of correct recognition/ total test set
% entries)
% mindist = minimum distance of a test set entry to a training set entry
% recog = recognition label, i,e the label of a training set entry which
% provides minimum distance to one test set entry
%% Initializations
v=w;                                % v contains the training set. 
N=162;
% N = Number of eigenface components used for each image (max(N) = number of images in the training set)
%% Subtracting the mean from v
O=single((ones(1,size(v,2)))); 
m=single((mean(v,2)));              % m is the mean of all images.
vzm=v-(m*O);                        % vzm is v with the mean removed. 

%% Calculating eigenvectors of the correlation matrix
% We are picking N eigenfaces corresponding to the first N largest eigen values.
L=single(vzm)'*single(vzm);
[V,D]=eig(L);
V=single(vzm)*V;
V=V(:,end:-1:end-(N-1));            % Pick the eigenvectors corresponding to the N largest eigenvalues. 
%% Calculating the signature weight for each image
cv=zeros(size(v,2),N);
for i=1:size(v,2);
    cv(i,:)=single(vzm(:,i))'*V;    % Each row in cv is the signature for one image.
end
%% Recognition 
%  Now, we run the algorithm and see if we can correctly recognize the face. 
recog = [];
dist = [];
mindist = [];

for j=1:size(w2,2)
r=w2(:,j);                        % r contains a test image
p=r-m;                            % Subtract the mean
s=single(p)'*V;
z=[];
for i=1:size(v,2)
    z=[z,norm(cv(i,:)-s,2)];
end
dist = [dist;z];

end

%mencari FAR, FRR, dan EER
%inisialisasi perhitungan
FAR=[];
FRR=[];
threshold=0:1:1000;

for TR=0:1000
    %inisialisasi jumlah false acceptance (FA) dan false rejection (FR)
    FA=0;
    FR=0;
    for i=1:size(w2,2)
        for j=1:size(v,2)
            baris = fix((i-1)/12);
            kolom = fix((j-1)/7);
            if (baris==kolom)           %perhitungan pada bagian matriks citra training sama dengan citra tes
                if (dist(i,j) > TR)     %jika distance > threshold, maka terjadi false rejection
                    FR = FR +1;
                end
            else                        %perhitungan pada bagian matriks citra training berbeda dengan citra tes
                if (dist(i,j) <= TR)    %jika distance > threshold, maka terjadi false acceptance
                    FA = FA +1;
                end
            end
        end
    end
    FAR(TR+1) = FA/7560;                %menghitung nilai FAR untuk tiap nilai threshold
    FRR(TR+1) = FR/840;                 %menghitung nilai FRR untuk tiap nilai threshold
end

figure,plot(threshold, FAR, threshold, FRR);    %menampilkan FAR dan FRR dalam satu grafik


%mencari EER dan threshold optimum
%inisialisasi
min=1000;           %inisialisasi nilai minimum yang besar

%EER adalah saat FAR=FRR, atau selisih keduanya paling minimum
for k=1:1001
    selisih=abs(FAR(k)-FRR(k));
    if selisih<min
        min=selisih;
        EER=FAR(k);                     %EER saat FAR=FRR
        opt_TR=k-1;                     %threshold minimum saat FAR=FRR, bernilai k-1 karena index FAR bernilai 1 sampai 1001
    end
end
end
