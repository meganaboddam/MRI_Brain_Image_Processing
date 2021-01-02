clear all;close all;clc
%%%  PART I
 
%Extract images from files
image1 = imread('Waves1(1).bmp');
image2 = imread('Waves2(1).bmp');
image3 = imread('Waves3.bmp');
 
%2D FFT of image 1
[Fx,Fy,im_fft] = FFT_2D(image1,10,10);
figure(1)
im=imagesc(Fx,Fy,abs(im_fft));
title ('2D FFT of Wave 1','FontSize', 14)
xlabel('Horizontal Contribution cycles/cm','FontSize', 14)
ylabel('Vertical Contribution cycles/cm','FontSize', 14)
colorbar
 
%2D FFT of image 2
[Fx2,Fy2,im_fft2] = FFT_2D(image2,10,10);
figure(2)
im2=imagesc(Fx2,Fy2,abs(im_fft2));
title ('2D FFT of Wave 2','FontSize', 14)
xlabel('Horizontal Contribution cycles/cm','FontSize', 14)
ylabel('Vertical Contribution cycles/cm','FontSize', 14)
colorbar
 
%2D FFT of image 3
[Fx3,Fy3,im_fft3] = FFT_2D(image3,10,10);
figure(3)
im3=imagesc(Fx3,Fy3,abs(im_fft3));
title ('2D FFT of Wave 3','FontSize', 24)
xlabel('Horizontal Contribution cycles/cm','FontSize', 24)
ylabel('Vertical Contribution cycles/cm','FontSize', 24)
colorbar
 
%Plot the horizontal and vertical spatial frequency contributions (image 1)
x_contribution1 = sum(abs(im_fft),1);
y_contribution1 = sum(abs(im_fft),2);
 
figure(4)
subplot(2,1,1);
plot(Fx,x_contribution1)
title('Horizontal spatial frequency Contributions of Wave 1','FontSize', 14)
xlabel('Cycles/cm','FontSize', 14)
ylabel('Amplitude of FFT','FontSize', 14)
subplot(2,1,2);
plot(Fy,y_contribution1);
title('Vertical spatial frequency Contributions of Wave 1','FontSize', 14)
xlabel('Cycles/cm','FontSize', 14)
ylabel('Amplitude of FFT','FontSize', 14)
 
 
 
%Plot the horizontal and vertical spatial frequency contributions (image 2)
x_contribution2 = sum(abs(im_fft2),1);
y_contribution2 = sum(abs(im_fft2),2);
 
figure(5)
subplot(2,1,1);
plot(Fx,x_contribution2);
title('Horizontal spatial frequency Contributions of Wave 2','FontSize', 14)
xlabel('Cycles/cm','FontSize', 14)
ylabel('Amplitude of FFT','FontSize', 14)
subplot(2,1,2);
plot(Fy,y_contribution2);
title('Vertical spatial frequency Contributions of Wave 2','FontSize', 14)
xlabel('Cycles/cm','FontSize', 14)
ylabel('Amplitude of FFT','FontSize', 14)
 
 
 
%Plot the horizontal and vertical spatial frequency contributions (image 3)
x_contribution3 = sum(abs(im_fft3),1);
y_contribution3 = sum(abs(im_fft3),2);
 
figure(6)
subplot(2,1,1);
plot(Fx,x_contribution3);
title('Horizontal spatial frequency Contributions of Wave 3','FontSize', 14)
xlabel('Cycles/cm','FontSize', 14)
ylabel('Amplitude of FFT','FontSize', 14)
subplot(2,1,2);
plot(Fy,y_contribution3);
title('Vertical spatial frequency Contributions of Wave 3','FontSize', 14)
xlabel('Cycles/cm','FontSize', 14)
ylabel('Amplitude of FFT','FontSize', 14)








%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
%%% PART II
 
%Extract MRI image file
mr_image = dicomread('IM0102.dcm');
 
%Perform 2D FFT on image
[FxMRI,FyMRI,fft_MRI] = FFT_2D(mr_image,24,24); 
figure(7)  %Plot image
imagesc(FxMRI,FyMRI,abs(fft_MRI));
title('2D FFT of MRI','FontSize',14)
xlabel('spatial frequency (cycles/cm)','FontSize',14);
ylabel('spatial frequency (cycles/cm)','FontSize',14);
 
 
%Determine side lengths of each masking square 
dim = 256^2;
Remove_10= round(sqrt(.1*dim)); %Side length of lower 10% frequencies mask
Remove_30= round(sqrt(.3*dim)); %Side length of lower 30% frequencies mask
Remove_50= round(sqrt(.5*dim)); %Side length of lower 50% frequencies mask
Remove_70= round(sqrt(.7*dim)); %Side length of lower 70% frequencies mask
Remove_90 = round(sqrt(.9*dim)); %Side length of lower 90% frequencies mask
 
 
 
%Create mask 1: removes the 90% higher frequencies, leaving 10% lower
%frequencies
mask1 = zeros(256,256);
mask1(88:169,88:169) = 1;
 
Area10_fft = fft_MRI.*mask1; %Apply Filter
ifft10 = ifft2(Area10_fft); 
 
figure(8)   %Plot filtered image            
imagesc(abs(ifft10)); 
title('MRI Image After Filtering Out Higher 90% Frequencies','FontSize',14)
 
figure(9)   %Plot original image
imagesc(mr_image)
title('Original MRI Image (Without Filtering)','FontSize',14); 
 
 
 
%Remove lower 10 percent of frequencies
%Center the spatial frequency-stopping mask in middle of matrix
interval10 = [(round(128-Remove_10/2)):(round(128 + Remove_10/2))]; 
mask2 = ones(256,256);
mask2(interval10,interval10) = 0;  
 
Area10_fft = fft_MRI.*mask2; %Apply filter
ifft10percent = ifft2(Area10_fft);
 
figure(10)  %Plot filtered image
imagesc(abs(ifft10percent)); 
title('MRI Image After Removing Lower 10% of Frequencies','FontSize',14)
 
figure(11)
imagesc(mask2)
title('Lower 10% Mask')
 
 
 
%Remove lower 30 percent of frequencies
%Center the spatial frequency-stopping mask in middle of matrix
interval30 = [(round(128-Remove_30/2)):(round(128 + Remove_30/2))]; 
mask30percent = ones(256,256);
mask30percent(interval30,interval30) = 0;
 
Area30_fft = fft_MRI.*mask30percent; %Apply filter
ifft30 = ifft2(Area30_fft); 
 
figure(12)  %Plot filtered image
imagesc(abs(ifft30)); 
title('Removal of Lower 30% Frequencies','FontSize',14)
 
figure(13)
imagesc(mask30percent)
title('Lower 30% Mask')
 
 
 
%Remove lower 50 percent of frequencies
%Center the spatial frequency-stopping mask in middle of matrix
interval50 = [(round(128-Remove_50/2)):(round(128 + Remove_50/2))]; 
mask50percent = ones(256,256);
mask50percent(interval50,interval50) = 0;
 
Area50_fft = fft_MRI.*mask50percent; %Apply filter
ifft50 = ifft2(Area50_fft); 
 
figure(14)  %Plot filtered image
imagesc(abs(ifft50)); 
title('Removal of Lower 50% Frequencies','FontSize',14)
 
figure(15)
imagesc(mask50percent)
title('Lower 50 Mask')
 
 
 
%Remove lower 70 percent of frequencies
%Center the spatial frequency-stopping mask in middle of matrix
interval70 = [(round(128-Remove_70/2)):(round(128 + Remove_70/2))]; 
mask70percent = ones(256,256);
mask70percent(interval70,interval70) = 0;
 
Area70_fft = fft_MRI.*mask70percent; %Apply filter
ifft70 = ifft2(Area70_fft); 
 
figure(16)  %Plot filtered image
imagesc(abs(ifft70)); 
title('Removal of Lower 70% Frequencies','FontSize',14)
 
figure(17)
imagesc(mask70percent)
title('Lower 70% Mask')
 
 
 
%Remove lower 90 percent of frequencies
%Center the spatial frequency-stopping mask in middle of matrix
interval90 = [(round(128-Remove_90/2)):(round(128 + Remove_90/2))]; 
mask90percent = ones(256,256);
mask90percent(interval90,interval90) = 0;
 
Area90_fft = fft_MRI.*mask90percent; %Apply filter
ifft90 = ifft2(Area90_fft); 
 
figure(18)  %Plot filtered image
imagesc(abs(ifft90)); 
title('Removal of Lower 90% Frequencies','FontSize',14)
 
figure(19)
imagesc(mask90percent)
title('Lower 90% Mask')
