function saveData2(H, L, C, indPrd, ...
                   lookForwardLen, dim, ...
                   waveletLen, waveletParam, ...
                   len, file1, file2)

%% train Wavelet 
trainData = zeros(len-lookForwardLen-waveletLen, dim, dim);
verifyData = zeros(len-lookForwardLen-waveletLen, 1);
fidTrain=fopen(file1, 'wb','ieee-be'); % big
fidVerify=fopen(file2,'wb','ieee-be');
fwrite(fidTrain, len-lookForwardLen-waveletLen, 'uint');
fwrite(fidVerify, len-lookForwardLen-waveletLen, 'uint');

% realCw = wden(C, waveletParam.tptr, waveletParam.sorh, waveletParam.scal, ...
%     waveletParam.lev, waveletParam.wname) * 100000; 

% plot(C*100000,'k');hold on;plot(realCw,'r--');

indCalcLen = indPrd+dim;
% indCalcLen = waveletLen/32;
% if indCalcLen <= indPrd+dim+1;
%     fprintf('indCalcLen err');
%     return;
% end
    
%% start !!!
tic;
for i=1:len-lookForwardLen-waveletLen
%     tic;
    range = i:waveletLen+i-1;
    
    %% time start at waveletLen
%     tmpH = wden(H(range), waveletParam.tptr, waveletParam.sorh, ...
%         waveletParam.scal, waveletParam.lev, waveletParam.wname) * 100000; 
%     tmpL = wden(L(range), waveletParam.tptr, waveletParam.sorh, ...
%         waveletParam.scal, waveletParam.lev, waveletParam.wname) * 100000; 
    tmpC = wden(C(range), waveletParam.tptr, waveletParam.sorh, ...
        waveletParam.scal, waveletParam.lev, waveletParam.wname) * 100000; 
    
%     toc
%     tic

    %% indicator, calc 1/4, must > prd+dim
 
%     cla;
%     realCw = wden(C(1:waveletLen+i+lookForwardLen-1), ...
%         waveletParam.tptr, waveletParam.sorh, waveletParam.scal, ...
%         waveletParam.lev, waveletParam.wname) * 100000; 
%     plot(C(range(1):range(end)+lookForwardLen)*100000,'k');hold on;
%     plot(tmpC,'b*');hold on;
%     plot(realCw(range(1):range(end)+lookForwardLen),'r--');
    
%     maH = indicators(tmpH(end-indCalcLen:end), 'sma', indPrd);
%     maL = indicators(tmpL(end-indCalcLen:end), 'sma', indPrd);
    maC = indicators(tmpC(end-indCalcLen+1:end), 'sma', indPrd);

    rsiC = rsindex(tmpC(end-indCalcLen+1:end), indPrd);

    stochC = stoch(tmpC(end-indCalcLen+1:end), ...
        length(tmpC(end-indCalcLen+1:end)), indPrd);

    [~, uppr, lowr] = bollinger(tmpC(end-indCalcLen+1:end), indPrd, 0, 2.0);
    
    rocC = indicators(tmpC(end-indCalcLen+1:end), ...
        'roc', indPrd);
%     cciC = indicators([tmpH(end-indCalcLen:end), ...
%         tmpL(end-indCalcLen:end), ...
%         tmpC(end-indCalcLen:end)], 'cci' ,indPrd, indPrd, 0.015);
%     toc
%     tic
    %% get the last waveletLen ---> train data
%     trainData(i, 1, :) = normalization(maH(end-lookForwardLen+1:end));
%     trainData(i, 2, :) = normalization(maL(end-lookForwardLen+1:end));
    trainData(i, 3, :) = normalization(maC(end-dim+1:end));
    trainData(i, 4, :) = normalization(uppr(end-dim+1:end));
    trainData(i, 5, :) = normalization(lowr(end-dim+1:end));
    trainData(i, 6, :) = normalization(stochC(end-dim+1:end));
    trainData(i, 1, :) = normalization(rsiC(end-dim+1:end));
%     trainData(i, 2, :) = normalization(cciC(end-dim+1:end));
    trainData(i, 2, :) = normalization(rocC(end-dim+1:end));
    
%     toc
%     tic
    %% valid data
%     realCw = wden(C(1:waveletLen+i+lookForwardLen-1), ...
%         waveletParam.tptr, waveletParam.sorh, waveletParam.scal, ...
%         waveletParam.lev, waveletParam.wname) * 100000; 
    
    realCw = wden(C(i:waveletLen+i+lookForwardLen-1), ...
        waveletParam.tptr, waveletParam.sorh, waveletParam.scal, ...
        waveletParam.lev, waveletParam.wname) * 100000; 
    
    lookForwardCw = realCw(end);
%     if lookForwardCw - realCw(range(end)) >= 0
    if lookForwardCw - realCw(end-lookForwardLen) >= 0
        verifyData(i) = 0;
    else 
        verifyData(i) = 1;
    end
%     toc
%     tic
    %%

    for j=1:dim
        for k=1:dim
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



