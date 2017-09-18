clear
clc
%conv1
% input_size=128
% conv_size=5;
% stride=1;
% pad=0;
% 
% output_size=(input_size-conv_size+2*pad)/stride+1
% 
% %pool1
% input_size=output_size;
% pool_size=4;
% stride=4;
% pad=0;
% output_size=(input_size-conv_size+2*pad)/stride+1

%conv2
input_size=31;
conv_size=5;
stride=1;
pad=0;

output_size=(input_size-conv_size+2*pad)/stride+1

%pool2
input_size=output_size;
pool_size=2;
stride=2;
pad=0;
output_size=(input_size-conv_size+2*pad)/stride+1

