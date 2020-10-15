clear
clc

% Generate adjacent matrix Adj (Note: ensure the file path and file name is valid)
LSmat='LS_nor_cor_abs.txt';
MLmat='ML_matrix.txt';
MSmat='MS_nor_cor_abs.txt';
LS=load(LSmat);
MS=load(MSmat);
ML=load(MLmat);
Adj=[LS,ML';ML,MS];

% Generate known lncRNA-miRNA interaction index
index=zeros(262,3150);
for i=1:262
    l=length(find(Adj(3150+i,1:3150)));
    index(i,1:l)=find(Adj(3150+i,1:3150));
end

%  Vross-validationc subcontract(k=5)
indices=zeros(size(index));
for i=1:262
    m=length(find(index(i,:)~=0));   
    if m==1
        indices(i,1:m)=randperm(5,1);
    else
        indices(i,1:m) = crossvalind('Kfold', index(i,1:m), 5);
    end
end

labels=zeros(1,262*3150);
p=length(find(Adj(3151:3412,1:3150)==1));
d=0;

% cross-validationc,k=5
for k=1:5 
    AdjTraining=Adj;
    for i=1:262
         for j=1:3150
             if indices(i,j)==k
             AdjTraining(3150+i,index(i,j))=0;
             AdjTraining(index(i,j),3150+i)=0;
             end
         end
    end
    
    AdjProb=Adj-AdjTraining;
    N=length(Adj);
    probMatrix=zeros(N,N);
    
    % Set the size of perturbations and number of independent perturbations
    pertuSize=ceil(0.1*(length(find(AdjTraining==1)))/2);
    perturbations=8;
    
    for pertus=1:perturbations
        AdjUnpertu=AdjTraining;
        index3=find(tril(AdjTraining));
        [i,j]=ind2sub(size(tril(AdjTraining)),index3);
        for pp=1:pertuSize
            rand_num=ceil(length(i)*rand(1));
            select_ID1=i(rand_num);
            select_ID2=j(rand_num);
            i(rand_num)=[];
            j(rand_num)=[];
            AdjUnpertu(select_ID1,select_ID2)=0;
            AdjUnpertu(select_ID2,select_ID1)=0;
        end
        AdjUnpertu=full(AdjUnpertu);
        probMatrix=probMatrix+perturbation(AdjUnpertu,AdjTraining);
    end

    % calculate the AUC score
    index1=find(tril(AdjProb,-1));
    weight1=probMatrix(index1);
    index2=find(tril(~Adj,-1));
    weight2=probMatrix(index2); 
   
    labels(1,d+1:length(weight1))=1;
    Positive(1,d+1:d+length(weight1))=weight1;
    d=d+length(weight1);
    labels(1,p+1:p+length(weight2))=0;
    Negative_1(k,1:length(weight2))=weight2;
    
end

    Negative=mean(Negative_1);
    scores=[Positive,Negative];
    [X,Y,T,AUC] = perfcurve(labels,scores,1);

    figure(2)
    plot(X,Y);
    hold on;
    xlabel('FPR')
    ylabel('TPR')
    set(gca,'FontName','Times New Roman');
   
    title('ROC on SPMLMI dataset');
    