function [EER TR] = HitungEER(FAR_f,FRR_f)
min=9999;
for k=1:300
    selisih=abs(FAR_f(k)-FRR_f(k));
    if selisih<min
        min=selisih;
        EER=FAR_f(k);                     %EER saat FAR=FRR
        TR=k;                     
    end
end