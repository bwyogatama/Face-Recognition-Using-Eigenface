	
function [FAR FRR EER] = ThresholdMode(FA,FR,w2)
    min=1000;
    FRR = FR/size(w2,2);
    FAR = FA/size(w2,2);
    for k=1:300
    selisih=abs(FAR(k)-FRR(k));
    if selisih<min
        min=selisih;
        EER=FAR(k);                     %EER saat FAR=FRR
    end
    end
end
