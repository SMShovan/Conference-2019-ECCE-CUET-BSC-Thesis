%%loading data

%load dipeptide
%load AminoAcidC
%load pseudoAminoAcid
%load SOCNfeatures

data= featureEx;


xdata = data(:,:);
group = class(:);


newxdata = data;
newydata = class;


%% cross validate

k=10;
indices = crossvalind('Kfold',newydata,k);
cp = classperf(newydata);

%% fining best c and sigma

c= 2^-4;
sigma= 2^-4;
prevError=2;
error=2;

maxAccu=-1;
sensitivity=-10;
specificity=-10;

for p=1:4
    for q=1:4
        
        for i = 1:k
            test = (indices == i); train = ~test;
            
            svmStruct = sl                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   vtrain(newxdata(train,:),newydata(train),'Method','QP', ...
                'BoxConstraint',2^p,'ShowPlot',false,'kernel_function','rbf','RBF_Sigma', 2^q);
            
            testOutput= svmclassify(svmStruct,newxdata(test,:),'ShowPlot',false);
            
            classperf(cp,testOutput,test);
        end
        error= abs(cp.Sensitivity - cp.Specificity);
        
        if prevError> error
            
            prevError=error;
            maxAccu= cp.CorrectRate;
            sensitivity= cp.Sensitivity;
            specificity= cp.Specificity;
            c=p;
            sigma=q;
            
        end
        
    end
end


c
sigma
maxAccu
sensitivity
specificity

