filename = 'C:\Users\ivan\Desktop\git\forex\MATLAB\result.txt';
delimiter = '';
formatSpec = '%f%[^\n\r]';
fileID = fopen(filename,'r');
dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'EmptyValue' ,NaN, 'ReturnOnError', false);
fclose(fileID);
VarName1 = dataArray{:, 1};
clearvars filename delimiter formatSpec fileID dataArray ans;

% plot(VarName1);

input=1; %指定元素
t=VarName1'==input;
out=find(diff([t false])==-1)-find(diff([false t])==1)+1; %输出结果
for i=1:max(out)
    a(i)=sum(out==i)
end
plot(a)