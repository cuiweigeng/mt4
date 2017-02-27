close all;clear;clc;
format bank;

%% read and merge data
[YMD2003, HHMM2003, O2003, H2003, L2003, C2003, V2003] ...
    = read_csv('GU_H1\GBPUSD_H1_2003.csv');
[YMD2004, HHMM2004, O2004, H2004, L2004, C2004, V2004] ...
    = read_csv('GU_H1\GBPUSD_H1_2004.csv');
[YMD2005, HHMM2005, O2005, H2005, L2005, C2005, V2005] ...
    = read_csv('GU_H1\GBPUSD_H1_2005.csv');
[YMD2006, HHMM2006, O2006, H2006, L2006, C2006, V2006] ...
    = read_csv('GU_H1\GBPUSD_H1_2006.csv');
[YMD2007, HHMM2007, O2007, H2007, L2007, C2007, V2007] ...
    = read_csv('GU_H1\GBPUSD_H1_2007.csv');
[YMD2008, HHMM2008, O2008, H2008, L2008, C2008, V2008] ...
    = read_csv('GU_H1\GBPUSD_H1_2008.csv');
[YMD2009, HHMM2009, O2009, H2009, L2009, C2009, V2009] ...
    = read_csv('GU_H1\GBPUSD_H1_2009.csv');
[YMD2010, HHMM2010, O2010, H2010, L2010, C2010, V2010] ...
    = read_csv('GU_H1\GBPUSD_H1_2010.csv');
[YMD2011, HHMM2011, O2011, H2011, L2011, C2011, V2011] ...
    = read_csv('GU_H1\GBPUSD_H1_2011.csv');
[YMD2012, HHMM2012, O2012, H2012, L2012, C2012, V2012] ...
    = read_csv('GU_H1\GBPUSD_H1_2012.csv');
[YMD2013, HHMM2013, O2013, H2013, L2013, C2013, V2013] ...
    = read_csv('GU_H1\GBPUSD_H1_2013.csv');
[YMD2014, HHMM2014, O2014, H2014, L2014, C2014, V2014] ...
    = read_csv('GU_H1\GBPUSD_H1_2014.csv');

YMD = [YMD2003', YMD2004', YMD2005', YMD2006', YMD2007', ...
    YMD2008', YMD2009', YMD2010', YMD2011', YMD2012', ...
    YMD2013', YMD2014']';
HHMM = [HHMM2003', HHMM2004', HHMM2005', HHMM2006', HHMM2007', ...
    HHMM2008', HHMM2009', HHMM2010', HHMM2011', HHMM2012', ...
    HHMM2013', HHMM2014']';
O = [O2003', O2004', O2005', O2006', O2007', ...
    O2008', O2009', O2010', O2011', O2012', ...
    O2013', O2014']';
H = [H2003', H2004', H2005', H2006', H2007', ...
    H2008', H2009', H2010', H2011', H2012', ...
    H2013', H2014']';
L = [L2003', L2004', L2005', L2006', L2007', ...
    L2008', L2009', L2010', L2011', L2012', ...
    L2013', L2014']';
C = [C2003', C2004', C2005', C2006', C2007', ...
    C2008', C2009', C2010', C2011', C2012', ...
    C2013', C2014']';
V = [V2003', V2004', V2005', V2006', V2007', ...
    V2008', V2009', V2010', V2011', V2012', ...
    V2013', V2014']';

%% splt to train and test data
trainPercent = 0.9;
oriLen = length(YMD);
trainLen = round(oriLen*trainPercent);
testLen = oriLen-trainLen;

train_ymd  = YMD(1:trainLen);
train_hhmm = HHMM(1:trainLen);
train_o    = O(1:trainLen);
train_h    = H(1:trainLen);
train_l    = L(1:trainLen);
train_c    = C(1:trainLen);
train_v    = V(1:trainLen);

test_ynd  = YMD(trainLen+1:trainLen+testLen);
test_hhmm = HHMM(trainLen+1:trainLen+testLen);
test_o    = O(trainLen+1:trainLen+testLen);
test_h    = H(trainLen+1:trainLen+testLen);
test_l    = L(trainLen+1:trainLen+testLen);
test_c    = C(trainLen+1:trainLen+testLen);
test_v    = V(trainLen+1:trainLen+testLen);

%% clear no use data
clear YMD2003 HHMM2003 O2003 H2003 L2003 C2003 V2003;
clear YMD2004 HHMM2004 O2004 H2004 L2004 C2004 V2004;
clear YMD2005 HHMM2005 O2005 H2005 L2005 C2005 V2005;
clear YMD2006 HHMM2006 O2006 H2006 L2006 C2006 V2006;
clear YMD2007 HHMM2007 O2007 H2007 L2007 C2007 V2007;
clear YMD2008 HHMM2008 O2008 H2008 L2008 C2008 V2008;
clear YMD2009 HHMM2009 O2009 H2009 L2009 C2009 V2009;
clear YMD2010 HHMM2010 O2010 H2010 L2010 C2010 V2010;
clear YMD2011 HHMM2011 O2011 H2011 L2011 C2011 V2011;
clear YMD2012 HHMM2012 O2012 H2012 L2012 C2012 V2012;
clear YMD2013 HHMM2013 O2013 H2013 L2013 C2013 V2013;
clear YMD2014 HHMM2014 O2014 H2014 L2014 C2014 V2014;

%% define wavelet param
tptr = 'sqtwolog';
sorh = 's';
% scal = 'sln';
% wname = 'sym8';
scal = 'mln';
wname = 'sym4';
lev = 5;

%% define indicator param
PRD = 20;
dim = 6;

%% train Wavelet
seqStart = 1024;
trainData = zeros(trainLen-dim-seqStart+1, dim, dim);
valid = zeros(trainLen-dim-seqStart+1, 1);
fidTrain=fopen('trainImages', 'wb','ieee-be'); %´ó¶Ë
fidVerify=fopen('trainLabels','wb','ieee-be');
fwrite(fidTrain, verifyLen, 'uint');
fwrite(fidVerify, verifyLen, 'uint');

tic
for i=seqStart:trainLen-dim
    %% time start at seqStart
    tmpLen = length(1:i);
    tmpO = wden(train_o(1:i), tptr, sorh, scal, lev, wname) * 100000; 
    tmpH = wden(train_h(1:i), tptr, sorh, scal, lev, wname) * 100000; 
    tmpL = wden(train_l(1:i), tptr, sorh, scal, lev, wname) * 100000; 
    tmpC = wden(train_c(1:i), tptr, sorh, scal, lev, wname) * 100000; 
    
    %% ma
    fprintf('calc MA\n');
    maO = ma(tmpC, tmpLen, PRD);

    %% rsi
    fprintf('calc RSI\n');
    rsiC = rsindex(tmpC, PRD);
    rsiC(1:PRD) = rsiC(PRD+1);
    
    %% STOCH
    fprintf('calc stoch\n');
    stochC = stoch(tmpC, tmpLen, PRD);

    %% BB
    fprintf('calc bollinger\n');
    [mid, uppr, lowr] = bollinger(tmpC, PRD, 0, 2.0);
    uppr(1:PRD-1) = uppr(PRD); % fill
    lowr(1:PRD-1) = lowr(PRD);
    
    %% Çócci
    fprintf('calc CCI\n');
    cciC = indicators([tmpH, tmpL, tmpC], 'cci' ,PRD, PRD, 0.015);
    cciC(1:PRD-1) = cciC(PRD);
    
    %% remove PRD, time start at (seqStart+PRD)
    tmpH = tmpH(PRD + 1:end);
    tmpL = tmpL(PRD + 1:end);
    tmpC = tmpC(PRD + 1:end);
    uppr = uppr(PRD + 1:end);
    lowr = lowr(PRD + 1:end);
    stochC = stochC(PRD + 1:end);
    rsiC = rsiC(PRD + 1:end);
    cciC = cciC(PRD + 1:end);
    
    %% train data
    trainData(i-seqStart+1, 3, :) = normalization(tmpC(end-dim+1:end));
    trainData(i-seqStart+1, 4, :) = normalization(uppr(end-dim+1:end));
    trainData(i-seqStart+1, 5, :) = normalization(lowr(end-dim+1:end));
    trainData(i-seqStart+1, 6, :) = normalization(stochC(end-dim+1:end));
    trainData(i-seqStart+1, 1, :) = normalization(rsiC(end-dim+1:end));
    trainData(i-seqStart+1, 2, :) = normalization(cciC(end-dim+1:end));
    
    %% valid data
    prvLen = 6;
    prvC = wden(train_c(1:i+prvLen), tptr, sorh, scal, lev, wname) * 100000; 
    if prvC(end) - prvC(end-prvLen) > 0
        valid(i-seqStart+1) = 1;
    elseif prvC(end) - prvC(end-prvLen) < 0
        valid(i-seqStart+1) = 2;
    else
        valid(i-seqStart+1) = 0;
    end
    
    %%
    for j=1:6
        for k=1:6
            fwrite(fidTrain, trainData(i-seqStart+1, j, k), 'uint');
        end
    end
    fwrite(fidVerify, verify(i-seqStart+1), 'uchar');
    
    %% info
    if(rem(i,1000) == 0) 
        toc
        fprintf('proc matrix row = %d, total row = %d\n', i, matRow);
        tic
    end
end

fclose(fidTrain);
fclose(fidVerify);


%% 
fprintf('export train data:\n');
saveData(train_h, train_l, train_c, PRD, dim, trainLen, ...
         'trainImages', 'trainLabels');

fprintf('export test data:\n');
saveData(test_h, test_l, test_c, PRD, dim, testLen, ...
         'testImages', 'testLabels');











