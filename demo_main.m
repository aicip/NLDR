clear; close all; clc;
addpath(genpath('./'));

imgfile = 'lena512.png';
ori_im=double(imread(imgfile));

for rate = 0.1:0.1:0.5;
    fprintf('----- Image: ** %s**  CS recovery with rate : %s -------\n', imgfile, num2str(rate));
    %% set parameters
    par.iters    =   15;
    par.nn       =   3;  % number of iterations for add feedback noise iterative reg.
    par.T        =   4;
    par.win      =   6;  % patch size
    par.nblk     =   46; % number of blk, meaning that find 45 similar patches plus itself get 46
    par.K0    =   3;
    par.K     =   15; % set new, orginally par.K=28;
    par.rate = rate;
    par.lamada     =   1.9; % could be optimized using FISTA
    par.t0         =   1.2;
    par.nSig       =   2.8;
    par.c0         =   0.5;
    par.c1         =   1.4*sqrt(2);
    par.step     =   min(6, par.win-1);
    par.ori_im   =   ori_im;
    [par.h  par.w]        =   size(ori_im);
    
    %% gen measurement function
    N            =   par.h *par.w;
    K            =    round( N*par.rate);
    P            =    randperm(N)';
    q            =    randperm(N/2-1)+1;
    OMEGA        =    q(1:ceil(K))';
    A            =    @(z) A_f(z, OMEGA, P);
    At           =    @(z) At_f(z, N, OMEGA, P);
    
    %%
    par.y        =   A(ori_im(:));
    [im_rec im_rec_tmp PSNR ]   =   nldr_rec(par, A, At);
    PSNR_last     =   csnr( im_rec, par.ori_im, 0, 0 );
    
    filename = ['Results\',imgfile,'_',num2str(rate),'.mat'];
    save(filename, 'im_rec','im_rec_tmp','PSNR','PSNR_last');
    clear im_rec im_rec_tmp PSNR PSNR_last filename;
    fprintf('===== Image: ** %s**  CS recovery with rate : %s  Done! =====\n', imgfile, num2str(rate));
end