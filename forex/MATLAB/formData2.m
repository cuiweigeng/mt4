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
indPrd = 20;
waveletLen = 1024;
lookForwardLen = 10;
dim = 6;

%% 
fprintf('fetch train data:\n');
saveData2(train_h, train_l, train_c, indPrd, ...
    lookForwardLen, dim, waveletLen, waveletParam, ...
    trainLen, 'trainImages', 'trainLabels');

%%
fprintf('fetch test data:\n');
saveData2(test_h, test_l, test_c, indPrd, ...
    lookForwardLen, dim, waveletLen, waveletParam, ...
    testLen, 'testImages', 'testLabels');












