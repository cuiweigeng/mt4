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

indCalcLen = waveletLen/32;
if indCalcLen <= indPrd+dim+1;
    fprintf('indCalcLen err');
    return;
end
    
%% start !!!
for i=1:len-lookForwardLen-waveletLen
    range = i:waveletLen+i-1;
    
    %% time start at waveletLen
    tmpH = wden(H(range), waveletParam.tptr, waveletParam.sorh, ...
        waveletParam.scal, waveletParam.lev, waveletParam.wname) * 100000; 
    tmpL = wden(L(range), waveletParam.tptr, waveletParam.sorh, ...
        waveletParam.scal, waveletParam.lev, waveletParam.wname) * 100000; 
    tmpC = wden(C(range), waveletParam.tptr, waveletParam.sorh, ...
        waveletParam.scal, waveletParam.lev, waveletParam.wname) * 100000; 
    
    %% indicator, calc 1/4, must > prd+dim
%     maH = ma(tmpH, waveletLen, indPrd);
%     maL = ma(tmpL, waveletLen, indPrd);
    
%     cla;
%     tmpC = wden(C(1:waveletLen+i-1), waveletParam.tptr, waveletParam.sorh, ...
%         waveletParam.scal, waveletParam.lev, waveletParam.wname) * 100000;
%     plot(C(range)*100000,'k');hold on;
%     plot(tmpC(range),'b*');hold on;
%     plot(realCw(range),'r--');
    
    maH = indicators(tmpH(end-indCalcLen:end), 'sma', indPrd);
    maL = indicators(tmpL(end-indCalcLen:end), 'sma', indPrd);
    maC = indicators(tmpC(end-indCalcLen:end), 'sma', indPrd);

    rsiC = rsindex(tmpC(end-indCalcLen:end), indPrd);

    stochC = stoch(tmpC(end-indCalcLen:end), ...
        length(tmpC(end-indCalcLen:end)), indPrd);

    [mid, uppr, lowr] = bollinger(tmpC(end-indCalcLen:end), indPrd, 0, 2.0);
    
    cciC = indicators([tmpH(end-indCalcLen:end), ...
        tmpL(end-indCalcLen:end), ...
        tmpC(end-indCalcLen:end)], 'cci' ,indPrd, indPrd, 0.015);
    
    %% get the last waveletLen ---> train data
%     trainData(i, 1, :) = normalization(maH(end-lookForwardLen+1:end));
%     trainData(i, 2, :) = normalization(maL(end-lookForwardLen+1:end));
    trainData(i, 3, :) = normalization(maC(end-dim+1:end));
    trainData(i, 4, :) = normalization(uppr(end-dim+1:end));
    trainData(i, 5, :) = normalization(lowr(end-dim+1:end));
    trainData(i, 6, :) = normalization(stochC(end-dim+1:end));
    trainData(i, 1, :) = normalization(rsiC(end-dim+1:end));
    trainData(i, 2, :) = normalization(cciC(end-dim+1:end));
    
    %% valid data
%     rangeReal = [range, range(end)+1:range(end)+lookForwardLen];
    realCw = wden(C(1:waveletLen+i+lookForwardLen-1), ...
        waveletParam.tptr, waveletParam.sorh, waveletParam.scal, ...
        waveletParam.lev, waveletParam.wname) * 100000; 

    lookForwardCw = realCw(end);
    if lookForwardCw - realCw(range(end)) > 0
        verifyData(i) = 1;
    elseif lookForwardCw - realCw(range(end)) < 0
        verifyData(i) = 2;
    else
        verifyData(i) = 0;
    end
    
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
end

fclose(fidTrain);
fclose(fidVerify);



