v01
1，校验数据使用窗口的概念，减低运算量
2，指标只计算 PRD+DIM 长度，减低运算量
3，去除最高与最低点的小波运算，减低运算量
4，roc替换cci
数据tag-v01的参数为：
matlan:
indPrd = 20;
waveletLen = 1024;
lookForwardLen = 10;

dim = 6;
python:
learning_rate = 0.0005
training_iters = 500000
batch_size = 288
display_step = 100

正确率：0.81624
-------------------------------
matlan:
indPrd = 20;
waveletLen = 512;
lookForwardLen = 10;

dim = 6;
python:
learning_rate = 0.0005
training_iters = 500000
batch_size = 288
display_step = 100

正确率：0.807764
-------------------------------
matlan:
indPrd = 20;
waveletLen = 4096;
lookForwardLen = 10;

dim = 6;
python:
learning_rate = 0.0005
training_iters = 500000
batch_size = 288
display_step = 100

正确率：0.8219

-------------------------------
matlan:
indPrd = 20;
waveletLen = 128;
lookForwardLen = 10;

dim = 6;
python:
learning_rate = 0.0005
training_iters = 500000
batch_size = 288
display_step = 100

正确率：0.774199

