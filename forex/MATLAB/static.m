close all;clear;clc;
format bank;

%%
[YMD2003, HHMM2003, O2003, H2003, L2003, C2003, V2003] = read_csv('C:\Users\Administrator\Documents\MATLAB\GU_H1\GBPUSD_H1_2003.csv');
[YMD2004, HHMM2004, O2004, H2004, L2004, C2004, V2004] = read_csv('C:\Users\Administrator\Documents\MATLAB\GU_H1\GBPUSD_H1_2004.csv');
[YMD2005, HHMM2005, O2005, H2005, L2005, C2005, V2005] = read_csv('C:\Users\Administrator\Documents\MATLAB\GU_H1\GBPUSD_H1_2005.csv');
[YMD2006, HHMM2006, O2006, H2006, L2006, C2006, V2006] = read_csv('C:\Users\Administrator\Documents\MATLAB\GU_H1\GBPUSD_H1_2006.csv');
[YMD2007, HHMM2007, O2007, H2007, L2007, C2007, V2007] = read_csv('C:\Users\Administrator\Documents\MATLAB\GU_H1\GBPUSD_H1_2007.csv');
[YMD2008, HHMM2008, O2008, H2008, L2008, C2008, V2008] = read_csv('C:\Users\Administrator\Documents\MATLAB\GU_H1\GBPUSD_H1_2008.csv');
[YMD2009, HHMM2009, O2009, H2009, L2009, C2009, V2009] = read_csv('C:\Users\Administrator\Documents\MATLAB\GU_H1\GBPUSD_H1_2009.csv');
[YMD2010, HHMM2010, O2010, H2010, L2010, C2010, V2010] = read_csv('C:\Users\Administrator\Documents\MATLAB\GU_H1\GBPUSD_H1_2010.csv');
[YMD2011, HHMM2011, O2011, H2011, L2011, C2011, V2011] = read_csv('C:\Users\Administrator\Documents\MATLAB\GU_H1\GBPUSD_H1_2011.csv');
[YMD2012, HHMM2012, O2012, H2012, L2012, C2012, V2012] = read_csv('C:\Users\Administrator\Documents\MATLAB\GU_H1\GBPUSD_H1_2012.csv');
[YMD2013, HHMM2013, O2013, H2013, L2013, C2013, V2013] = read_csv('C:\Users\Administrator\Documents\MATLAB\GU_H1\GBPUSD_H1_2013.csv');
[YMD2014, HHMM2014, O2014, H2014, L2014, C2014, V2014] = read_csv('C:\Users\Administrator\Documents\MATLAB\GU_H1\GBPUSD_H1_2014.csv');

% [YMD2003, HHMM2003, O2003, H2003, L2003, C2003, V2003] = read_csv('C:\Users\Administrator\Documents\MATLAB\GU_M5\GBPUSD_M5_2003.csv');
% [YMD2004, HHMM2004, O2004, H2004, L2004, C2004, V2004] = read_csv('C:\Users\Administrator\Documents\MATLAB\GU_M5\GBPUSD_M5_2004.csv');
% [YMD2005, HHMM2005, O2005, H2005, L2005, C2005, V2005] = read_csv('C:\Users\Administrator\Documents\MATLAB\GU_M5\GBPUSD_M5_2005.csv');
% [YMD2006, HHMM2006, O2006, H2006, L2006, C2006, V2006] = read_csv('C:\Users\Administrator\Documents\MATLAB\GU_M5\GBPUSD_M5_2006.csv');
% [YMD2007, HHMM2007, O2007, H2007, L2007, C2007, V2007] = read_csv('C:\Users\Administrator\Documents\MATLAB\GU_M5\GBPUSD_M5_2007.csv');
% [YMD2008, HHMM2008, O2008, H2008, L2008, C2008, V2008] = read_csv('C:\Users\Administrator\Documents\MATLAB\GU_M5\GBPUSD_M5_2008.csv');
% [YMD2009, HHMM2009, O2009, H2009, L2009, C2009, V2009] = read_csv('C:\Users\Administrator\Documents\MATLAB\GU_M5\GBPUSD_M5_2009.csv');
% [YMD2010, HHMM2010, O2010, H2010, L2010, C2010, V2010] = read_csv('C:\Users\Administrator\Documents\MATLAB\GU_M5\GBPUSD_M5_2010.csv');
% [YMD2011, HHMM2011, O2011, H2011, L2011, C2011, V2011] = read_csv('C:\Users\Administrator\Documents\MATLAB\GU_M5\GBPUSD_M5_2011.csv');
% [YMD2012, HHMM2012, O2012, H2012, L2012, C2012, V2012] = read_csv('C:\Users\Administrator\Documents\MATLAB\GU_M5\GBPUSD_M5_2012.csv');
% [YMD2013, HHMM2013, O2013, H2013, L2013, C2013, V2013] = read_csv('C:\Users\Administrator\Documents\MATLAB\GU_M5\GBPUSD_M5_2013.csv');
% [YMD2014, HHMM2014, O2014, H2014, L2014, C2014, V2014] = read_csv('C:\Users\Administrator\Documents\MATLAB\GU_M5\GBPUSD_M5_2014.csv');


YMD = [YMD2003', YMD2004', YMD2005', YMD2006', YMD2007', YMD2008', YMD2009', YMD2010', YMD2011', YMD2012', YMD2013', YMD2014'];
HHMM = [HHMM2003', HHMM2004', HHMM2005', HHMM2006', HHMM2007', HHMM2008', HHMM2009', HHMM2010', HHMM2011', HHMM2012', HHMM2013', HHMM2014'];
O = [O2003', O2004', O2005', O2006', O2007', O2008', O2009', O2010', O2011', O2012', O2013', O2014'];O=O';
H = [H2003', H2004', H2005', H2006', H2007', H2008', H2009', H2010', H2011', H2012', H2013', H2014'];H=H';
L = [L2003', L2004', L2005', L2006', L2007', L2008', L2009', L2010', L2011', L2012', L2013', L2014'];L=L';
C = [C2003', C2004', C2005', C2006', C2007', C2008', C2009', C2010', C2011', C2012', C2013', C2014'];C=C';
V = [V2003', V2004', V2005', V2006', V2007', V2008', V2009', V2010', V2011', V2012', V2013', V2014'];V=V';

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

%% FFT
n = 5000;
C_fft = fft(C);
C_fft(n:end-n) = 0;
C_ = real(ifft(C_fft));
plot(C(200:212),'k'); hold on; plot(C_(200:212),'r');

%% static
len = length(HHMM);

disC = 0.00000;
disH = 0.00000;
disL = 0.00000;

PRD = 89;
ma_c = ma(C,length(C),PRD);
%C_ = V;
%up = C(2:end).*V(2:end)-C(1:end-1).*V(2:end)>0;
% up = (C(2:end)-C(1:end-1)>=disC) & (H(2:end)-H(1:end-1)>=disH) ...
%       & (L(2:end)-L(1:end-1)>=disL) & (C(2:end)<ma_c(2:end)') ...
%       & (V(2:end)-V(1:end-1)>0);
up = (C(2:end)-C(1:end-1)<disC) & (C(2:end)<ma_c(2:end)');
input = 1;
t=up==input;
t = t';
rlt=find(diff([t false])==-1)-find(diff([false t])==1)+1;

pic = zeros(1,max(rlt));
for i=1:max(rlt)
    pic(i) = sum(rlt==i)/length(rlt);
end
% plot(pic)

[valPos,val] = find(up==1);

endPos = 1;
his=1;
ss1 = C(valPos(1:end-endPos)+his+1)>C(valPos(1:end-endPos)+his) ...
    &C(valPos(1:end-endPos)+his+1)>ma_c(valPos(1:end-endPos)+his+1)';
sum(ss1)/length(val)

ss2 = C(valPos(1:end-endPos)+his+1)<C(valPos(1:end-endPos)+his) ...
    &C(valPos(1:end-endPos)+his+1)>ma_c(valPos(1:end-endPos)+his+1)';
sum(ss2)/length(val)

ss3 = C(valPos(1:end-endPos)+his+1)>C(valPos(1:end-endPos)+his) ...
    &C(valPos(1:end-endPos)+his+1)<ma_c(valPos(1:end-endPos)+his+1)';
sum(ss3)/length(val)

ss4 = C(valPos(1:end-endPos)+his+1)<C(valPos(1:end-endPos)+his) ...
    &C(valPos(1:end-endPos)+his+2)<ma_c(valPos(1:end-endPos)+his+1)';
sum(ss4)/length(val)

MaxPrd = 48;
MinPrd = 12;
minDis = 30; % use fuzzy mode place

for i=MaxPrd:length(HHMM)-MaxPrd
    for prd=MinPrd:MaxPrd
        C_=C(i:i+prd);
    end
end



len = length(HHMM);
HHMM_STR = char(HHMM);
compPattern = '30';
rlt=zeros(1,len);
for i=1:len
    rlt(i) = strcmp(HHMM_STR(i,4:5), compPattern);
end

[val,valPos]=find(rlt==1);
len=length(val);

upCnt=(C(valPos)-O(valPos))>0;
dnCnt=(C(valPos)-O(valPos))<0;
eqCnt=(C(valPos)-O(valPos))==0;

input = 1;
t=upCnt==input;
t = t';
upOut=find(diff([t false])==-1)-find(diff([false t])==1)+1;

flg = 0;
sumCnt = 0;
passCnt = 0;
for i=2:length(upOut)-1
    if upOut(i) > upOut(i-1)
        flg = 1;
        sumCnt = sumCnt + 1;
    end
    if flg == 1 && upOut(i) < upOut(i+1)
        passCnt = passCnt + 1;
    end
    flg = 0;
end

prob = passCnt/sumCnt*100;

pic = zeros(1,max(upOut));
for i=1:max(upOut)
    pic(i) = sum(upOut==i)/length(upOut);
end
subplot(211);
plot(pic)

input = 1;
t=dnCnt==input;
t = t';
dnOut=find(diff([t false])==-1)-find(diff([false t])==1)+1 ;

pic = zeros(1,max(dnOut));
for i=1:max(dnOut)
    pic(i) = sum(dnOut==i)/length(dnOut);
end
subplot(212);
plot(pic)





































