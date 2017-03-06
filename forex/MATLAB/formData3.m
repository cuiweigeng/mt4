% v01

close all;clear;clc;
format bank;

%% read data
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

%% merge data
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
waveletParam.tptr = 'sqtwolog';
waveletParam.sorh = 's';
% waveletParam.scal = 'sln';
% waveletParam.wname = 'sym8';
waveletParam.scal = 'mln';   
waveletParam.wname = 'sym4';
waveletParam.lev = 5;

%% define param
lookForwardLen = 5;
row = 1; % num of indicator
col = 5; % indicator his
waveWin = 128;

%%
% filt = zeros(trainLen, 1); 
% tic
% for i=waveWin:trainLen
%     tmp = wden(train_c(i-waveWin+1:i), waveletParam.tptr, waveletParam.sorh, ...
%         waveletParam.scal, waveletParam.lev, waveletParam.wname);
%     filt(i) = tmp(end);
%     if(rem(i, 1000) == 0) 
%         toc
%         fprintf('proc num = %d, total num = %d\n', ...
%             i, trainLen-waveWin);
%         tic
%     end
% end

% filt = filt(waveWin:end);

% load filt;
% len = length(filt);
% trainData = zeros(len-lookForwardLen-col, row, col);
% verifyData = zeros(len-lookForwardLen-col, 1);
% for i=1:len-lookForwardLen-col
%     trainData(i,1,:) = normalization(filt(i:i+col-1));
%     verifyData(i,1) = filt(i+col+lookForwardLen-1) >= filt(i+col-1);
% end
% 
% fidTrain=fopen('trainImages', 'wb','ieee-be'); % big
% fidVerify=fopen('trainLabels','wb','ieee-be');
% fwrite(fidTrain, len-lookForwardLen-col, 'uint');
% fwrite(fidVerify, len-lookForwardLen-col, 'uint');
% for i=1:len-lookForwardLen-col
%     for j=1:row
%         for k=1:col
%             fwrite(fidTrain, trainData(i, j, k), 'uint');
%         end
%     end
%     fwrite(fidVerify, verifyData(i), 'uchar');
% end
% fclose(fidTrain);
% fclose(fidVerify);

% plot(train_c(waveWin:trainLen),'k');
% hold on;
% plot(filt, 'r');

%%
filename = 'C:\Users\ivan\Desktop\git\forex\MATLAB\result.txt';
formatSpec = '%11s%12s%s%[^\n\r]';
fileID = fopen(filename,'r');
dataArray = textscan(fileID, formatSpec, 'Delimiter', '', 'WhiteSpace', '',  'ReturnOnError', false);
fclose(fileID);
raw = repmat({''},length(dataArray{1}),length(dataArray)-1);
for cols=1:length(dataArray)-1
    raw(1:length(dataArray{cols}),cols) = dataArray{cols};
end
numericData = NaN(size(dataArray{1},1),size(dataArray,2));
for cols=[1,2,3]
    % Converts strings in the input cell array to numbers. Replaced non-numeric
    % strings with NaN.
    rawData = dataArray{cols};
    for rows=1:size(rawData, 1);
        % Create a regular expression to detect and remove non-numeric prefixes and
        % suffixes.
        regexstr = '(?<prefix>.*?)(?<numbers>([-]*(\d+[\,]*)+[\.]{0,1}\d*[eEdD]{0,1}[-+]*\d*[i]{0,1})|([-]*(\d+[\,]*)*[\.]{1,1}\d+[eEdD]{0,1}[-+]*\d*[i]{0,1}))(?<suffix>.*)';
        try
            result = regexp(rawData{rows}, regexstr, 'names');
            numbers = result.numbers;
            
            % Detected commas in non-thousand locations.
            invalidThousandsSeparator = false;
            if any(numbers==',');
                thousandsRegExp = '^\d+?(\,\d{3})*\.{0,1}\d*$';
                if isempty(regexp(thousandsRegExp, ',', 'once'));
                    numbers = NaN;
                    invalidThousandsSeparator = true;
                end
            end
            % Convert numeric strings to numbers.
            if ~invalidThousandsSeparator;
                numbers = textscan(strrep(numbers, ',', ''), '%f');
                numericData(rows, cols) = numbers{1};
                raw{rows, cols} = numbers{1};
            end
        catch me
        end
    end
end
R = cellfun(@(x) ~isnumeric(x) && ~islogical(x),raw); % Find non-numeric cells
raw(R) = {NaN}; % Replace non-numeric cells
VarName1 = cell2mat(raw(:, 1));
VarName2 = cell2mat(raw(:, 2));
VarName3 = cell2mat(raw(:, 3));
clearvars filename formatSpec fileID dataArray ans raw cols numericData rawData rows regexstr result numbers invalidThousandsSeparator thousandsRegExp me R;

%%
% filtTest = zeros(testLen, 1); 
% tic
% for i=waveWin:testLen
%     tmp = wden(test_c(i-waveWin+1:i), waveletParam.tptr, waveletParam.sorh, ...
%         waveletParam.scal, waveletParam.lev, waveletParam.wname);
%     filtTest(i) = tmp(end);
%     if(rem(i, 1000) == 0) 
%         toc
%         fprintf('proc num = %d, total num = %d\n', ...
%             i, testLen-waveWin);
%         tic
%     end
% end
% filtTest = filtTest(waveWin:end);

%%

load filtTest;
cla;plot(filtTest,'b');hold on;plot(test_c(waveWin:end),'k');hold on;
% plot(ma(test_c(waveWin:end),length(test_c(waveWin:end)),3),'y');hold on;
len = length(filtTest);
trainData = zeros(len-lookForwardLen-col, row, col);
verifyData = zeros(len-lookForwardLen-col, 1);
% for i=1:len-lookForwardLen-col
for i=1:1000
    trainData(i,1,:) = normalization(filtTest(i:i+col-1));
    if filtTest(i+col+lookForwardLen-1) > filtTest(i+col-1)
        verifyData(i,1) = 0;
    elseif filtTest(i+col+lookForwardLen-1) < filtTest(i+col-1)
        verifyData(i,1) = 1;
    else
        verifyData(i,1) = 2;
    end
    if VarName1(i) > VarName2(i)
        plot(i+col, filtTest(i+col),'r*');hold on;
    else
        plot(i+col, filtTest(i+col),'g*');hold on;
    end
%     verifyData(i,1) = filtTest(i+col+lookForwardLen-1) >= filtTest(i+col-1);
end

fidTrain=fopen('testImages', 'wb','ieee-be'); % big
fidVerify=fopen('testLabels','wb','ieee-be');
fwrite(fidTrain, len-lookForwardLen-col, 'uint');
fwrite(fidVerify, len-lookForwardLen-col, 'uint');
for i=1:len-lookForwardLen-col
    for j=1:row
        for k=1:col
            fwrite(fidTrain, trainData(i, j, k), 'uint');
        end
    end
    fwrite(fidVerify, verifyData(i), 'uchar');
end
fclose(fidTrain);
fclose(fidVerify);













