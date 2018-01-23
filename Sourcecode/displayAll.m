function displayAll(subset,resize)

[hasil, labels] = loadSubset(subset);
d = [];
e = [];
i = 2;

for subjects = 1:length(labels)
            c = hasil(:,subjects);
            c = reshape(c, 50, 50);
            
            %preprocessing
            c = preprocessing(c,resize);
            
            %write image
            path = strcat('/Users/BWYogatama/Documents/Foto/subset',num2str(subset+2,'%lu'),'/person',num2str(labels(subjects), '%lu'),'_',num2str(i, '%02i'),'.PNG');
            imwrite(c,path);
            
			if i==2 
                i = 3;
            elseif i==3 
                i = 5;
            elseif i==5
				i=6;
			elseif i==6
				i=7;
			elseif i==7
				i=8;
            else
			i = 2;
            end
			
			
            d = cat(2, d, c);
     if mod(subjects,15)==0
         e = cat(1,e,d);
         d=[];
     end
end
figure, imshow(e)
end