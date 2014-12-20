close all;
% clc;
clear all;

B_min = 3;
B_max = 10000;
M = log2(B_max) + 8;
e = 0.01/100;

%%%%%%%%%%%%%%%%%%%
% B - (2^M / K) = e*B
% K = (2^M) / (B(1-e))

mat_size = B_max - B_min + 1;
B_mat=zeros(mat_size,1);
P_mat=zeros(mat_size,1);
K_mat=zeros(mat_size,1);
K_c_mat=zeros(mat_size,1);
R_mat=zeros(mat_size,1);
I_mat=zeros(mat_size,1);
E_mat=zeros(mat_size,1);
i=1;


for B=B_min:B_max
    K = ((2^M)/(B*(1-e)));
    K_c = floor((2^M)/(B*(1-e)));
%     K_c = ceil((2^M)/(B*(1-e)));
    p=ceil(log2(K_c));
    B_mat(i) = B;
    P_mat(i) = p;
    K_mat(i) = K;
    K_c_mat(i) = K_c;
    R_mat(i) = (2^M / K_c);
    I_mat(i) = i;
    E_mat(i) = (B - (2^M / K_c))/B;
    i=i+1;
end

abs(min(E_mat)) * 100

figure
subplot(3,1,1); plot(I_mat, B_mat, I_mat, R_mat); grid ON;
subplot(3,1,2); plot(B_mat, E_mat); grid ON;
subplot(3,1,3); plot(B_mat,P_mat);   grid ON;

% figure
% subplot(2,1,1); plot(B_mat,P_mat);   grid ON;
% xlabel('N'); 
% ylabel('P'); 
% subplot(2,1,2); plot(B_mat,K_mat);   grid ON;
% xlabel('N'); 
% ylabel('K'); 


