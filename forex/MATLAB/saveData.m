function saveData(H, L, C, PRD, dim, len, file1, file2)

format bank;

viewPoint=1;
tmpLen = len;

%% 求ma
fprintf('求取ma\n');
maHigh = ma(H, len, PRD);
maLow = ma(L, len, PRD);
maClose = ma(C, len, PRD);
clDat = C(1:len);
hiDat = H(1:len);
loDat = L(1:len);

%% 求rsi
fprintf('求取rsi\n');
rsi = rsindex(clDat,PRD);

%% 求cci
fprintf('求取cci\n');
cci = indicators([hiDat,loDat,clDat], 'cci' ,PRD, PRD, 0.015);

%% 求stoch
fprintf('求取stoch\n');
stochClose = stoch(C, len, PRD);

%% 求BB
fprintf('求取bollinger\n');
[mid, uppr, lowr] = bollinger(C(1:len), PRD, 0, 2.0);
uppr(1:PRD-1) = uppr(PRD); % 填充
lowr(1:PRD-1) = lowr(PRD);


%% 生成训练数据
% 去除周期计算长度
len = len-PRD+1;
clDat = clDat(PRD:end);
maHigh = maHigh(PRD:end);
maLow = maLow(PRD:end);
maClose = maClose(PRD:end);
uppr = uppr(PRD:end);
lowr = lowr(PRD:end);
stochClose = stochClose(PRD:end);
rsi = rsi(PRD:end);
cci = cci(PRD:end);
fprintf('去除前端周期长度:%d, 长度范围:%d-%d, 长度:%d\n',...
    PRD-1, PRD, tmpLen, len);

%figure(1);
%plot(maHigh(viewPoint:viewPoint+dim-1));

% 输入
% ex: len = 10 ---> [1 2 3 4 5 6 7 8 9 10]
%     dim = 3            1 2 3 4 5 6 7 8
tmpLen = len;
len = len-dim+1; 
fprintf('去除历史长度:%d, 长度范围:%d-%d, 长度:%d\n',...
    dim-1, dim, tmpLen, len);

%                    T(n=len)
% ind_1  a(n) a(n+1) a(n+2) ... a(n+dim-1) 
% ind_2  b(n) b(n+1) b(n+2) ... b(n+dim-1)
% ind_3  c(n) c(n+1) c(n+2) ... c(n+dim-1)
%                      ...
trainData = zeros(len, dim, dim);
for i=1:len
%     trainData(i,1,:) = normalization(maHigh(i:i+dim-1));
%     trainData(i,2,:) = normalization(maLow(i:i+dim-1));
    trainData(i,3,:) = normalization(maClose(i:i+dim-1));
    trainData(i,4,:) = normalization(uppr(i:i+dim-1));
    trainData(i,5,:) = normalization(lowr(i:i+dim-1));
    trainData(i,6,:) = normalization(stochClose(i:i+dim-1));
    trainData(i,1,:) = normalization(rsi(i:i+dim-1));
    trainData(i,2,:) = normalization(cci(i:i+dim-1));
end

%% 生成校验数据
% 注意同步 closeDat如下
% 块1 ---> c5 ...
% c0   c1   c2   c3   c4   c5   c6  c7...
% maC1 maC2 maC3 maC4 maC5 maC6
% maH1 maH2 maH3 maH4 maH5 maH6
clDat = clDat(dim:end);

% 校验 0:无趋势 1:上升 2:下降
% 此处向后延一个点
% 不算点trainLen
len = len - 1;
verify = zeros(1,len);
del = (clDat(2:end)-clDat(1:end-1));
for i=1:len
    if del(i) > 0
        verify(i) = 1;
    elseif del(i) < 0
        verify(i) = 2;
    else
        verify(i) = 0;
    end
end

% 因此输入需要对齐校验数据-1个点
trainData = trainData(1:end-1,1:end,1:end);
verifyLen = length(verify);
fprintf('校验数据长度:%d\n', verifyLen);

%% 保存数据
fprintf('保存数据,格式为大端数\n');
fidTrain=fopen(file1,'wb','ieee-be'); %大端
fidVerify=fopen(file2,'wb','ieee-be');
fwrite(fidTrain,verifyLen,'uint');
fwrite(fidVerify,verifyLen,'uint');
for i=1:verifyLen
    for j=1:6
        for k=1:6
            fwrite(fidTrain,trainData(i,j,k),'uint');
        end
    end
    fwrite(fidVerify,verify(i),'uchar');
end
fclose(fidTrain);
fclose(fidVerify);

%% 观察
figure(2);
for i=1:dim
    subplot(dim,1,i);
    plot(reshape(trainData(viewPoint,i,:), 1, dim));
end