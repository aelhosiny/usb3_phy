clc;
clear all;
close all;

error_max = 0.1;

N=10;
M=4;

B = 2^N-1;

% B - (2^M)/K = max_eror;


K = 1/((B-error_max)/(2^M));

p = log2(abs(K));

N_min = 2;
N_max = 20;
M = 5;
e = 0.001;
 
% (B - 2^M / K) / B = e

% K = ceil(abs((B - 2^M)/(B*e)));

mat_size = N_max - N_min + 1;
N_mat=zeros(mat_size,1);
P_mat=zeros(mat_size,1);
i=1;
for N=2:N_max
    B = 2^N -1;
    K = ceil(abs((B - 2^M)/(B*e)));
    p=ceil(log(K));
    N_mat(i) = N;
    P_mat(i) = p;
end

figure
legend('M=5', 'e=0.01');
plot(N_mat,P_mat);   grid ON;
xlabel('N'); 
ylabel('P'); 




