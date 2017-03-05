% v01

function saveData2(H, L, C, indPrd, ...
                   lookForwardLen, row, col, ...
                   waveletLen, waveletParam, ...
                   len, file1, file2)

%% train Wavelet 
trainData = zeros(len-lookForwardLen-waveletLen, row, col);
verifyData = zeros(len-lookForwardLen-waveletLen, 1);
fidTrain=fopen(file1, 'wb','ieee-be'); % big
fidVerify=fopen(file2,'wb','ieee-be');
fwrite(fidTrain, len-lookForwardLen-waveletLen, 'uint');
fwrite(fidVerify, len-lookForwardLen-waveletLen, 'uint');

indCalcLen = indPrd+col;
    
%% start !!!
tic;
for i=1:len-lookForwardLen-waveletLen
%     tic;
    range = i:waveletLen+i-1;
    
    %% time start at waveletLen
    cWlTmp = wden(C(range), waveletParam.tptr, waveletParam.sorh, ...
        waveletParam.scal, waveletParam.lev, waveletParam.wname) * 100000; 
    
%     toc
%     tic

    %% indicator, calc 1/4, must > prd+dim
 
%     cla;
%     cWl = wden(C(1:waveletLen+i+lookForwardLen-1), ...
%         waveletParam.tptr, waveletParam.sorh, waveletParam.scal, ...
%         waveletParam.lev, waveletParam.wname) * 100000; 
%     plot(C(range(1):range(end)+lookForwardLen)*100000,'k');hold on;
%     plot(cWlTmp,'b*');hold on;
%     plot(cWl(range(1):range(end)+lookForwardLen),'r--');
    
    maC = indicators(cWlTmp(end-indCalcLen+1:end), 'sma', indPrd);

%     rsiC = rsindex(cWlTmp(end-indCalcLen+1:end), indPrd);

%     stochC = stoch(cWlTmp(end-indCalcLen+1:end), ...
%         length(cWlTmp(end-indCalcLen+1:end)), indPrd);

%     [~, ~, lowr] = bollinger(cWlTmp(end-indCalcLen+1:end), indPrd, 0, 2.0);
    
%     rocC = indicators(cWlTmp(end-indCalcLen+1:end), ...
%         'roc', indPrd);
%     cciC = indicators([tmpH(end-indCalcLen:end), ...
%         tmpL(end-indCalcLen:end), ...
%         cWlTmp(end-indCalcLen:end)], 'cci' ,indPrd, indPrd, 0.015);
%     toc
%     tic
    %% get the last waveletLen ---> train data
%     trainData(i, 1, :) = normalization(maH(end-lookForwardLen+1:end));
%     trainData(i, 2, :) = normalization(maL(end-lookForwardLen+1:end));
%     trainData(i, 3, :) = normalization(maC(end-col+1:end));
%     trainData(i, 4, :) = normalization(uppr(end-col+1:end));
%     trainData(i, 5, :) = normalization(lowr(end-col+1:end));
%     trainData(i, 6, :) = normalization(stochC(end-col+1:end));
%     trainData(i, 1, :) = normalization(rsiC(end-col+1:end));
%     trainData(i, 2, :) = normalization(cciC(end-col+1:end));
%     trainData(i, 2, :) = normalization(rocC(end-col+1:end));
    
    trainData(i, 1, :) = normalization(maC(end-col+1:end));
    
%     toc
%     tic
    %% valid data 
    range = i:waveletLen+i+lookForwardLen-1;
    cWl = wden(C(range), ...
        waveletParam.tptr, waveletParam.sorh, waveletParam.scal, ...
        waveletParam.lev, waveletParam.wname) * 100000; 
    
%     if lookForwardCw - cWl(end-lookForwardLen) >= 0
    if cWl(end) - cWlTmp(end) >= 0
        verifyData(i) = 0;
    else 
        verifyData(i) = 1;
    end
%     toc
%     tic
    %%

    for j=1:row
        for k=1:col
            fwrite(fidTrain, trainData(i, j, k), 'uint');
        end
    end
    fwrite(fidVerify, verifyData(i), 'uchar');

    %% info
    if(rem(i, 1000) == 0) 
        toc
        fprintf('proc num = %d, total num = %d\n', ...
            i, len-lookForwardLen-waveletLen);
        tic
    end
%     toc
%     fprintf('run');
end

fclose(fidTrain);
fclose(fidVerify);



