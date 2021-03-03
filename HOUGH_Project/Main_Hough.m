close all;
clear all;
%%
% 'http://hotelriazor.com.mx/img/tips_de_viajero/4.jpg'
%RGB = imread('Im_car.png');
%RGB = imread('L_45.png');
RGB = imread('Prova_2.png');

I = rgb2gray(RGB);
I0 = im2double(I);
[f,c] = size(I); Tall_sup = 50;Tall_inf = 0; % 500, 320 va be per Im_car
I = imcrop(I0,[0 Tall_sup c (f-Tall_sup-Tall_inf)]);

%%
subplot(1,2,1)
imshow(I0);title('Image original');
subplot(1,2,2)
imshow(I); title('Image retallada');

%% Treure ombres
background = imopen(I,strel('disk',15));
% % Display the Background Approximation as a Surface
% figure
% surf(double(background(1:8:end,1:8:end))),zlim([0 255]);
% ax = gca;
% ax.YDir = 'reverse';
% I2 = I - background;
% I3 = imadjust(I2);
%I = imbinarize(I);
imshow(I)
%bw = bwareaopen(bw,50);
%imshow(I4)
%% Extreure les vores, esquelet + dilatacio
Iv = edge(I,'canny');
Iv_del = bwareaopen(Iv,500);  % eliminar elements petits
imshow(Iv)

SE = strel('disk',6);  % creacio d'un element estructural
%Ivd = imdilate(Iv,SE,6);   % operació de dilatacio

%% Transformada de Hough
Discret_thetas=(pi*0.2:0.005:pi*0.8); 
[Acumulador,Rho_max] = trans_Hough_casera(Iv,Discret_thetas);
figure(5)
subplot(1,2,1)
imshow(Iv)
subplot(1,2,2)
Plot_hough_lines(RGB,Iv,Acumulador,Rho_max,0.6,Discret_thetas,Tall_sup,Tall_inf);

%%
% SE = strel('disk',6);  % creacio d'un element estructural
% Ivd = imdilate(Iv,SE);   % operació de dilatacio
% Iesq = bwmorph(Ivd,'skel',20);
% %% Gràfics / Imatges
% figure(2)
% subplot(2,3,1)
% imshow(I)
% subplot(2,3,2)
% imshow(I4)
% subplot(2,3,3)
% imshow(Iv)
% subplot(2,3,4)
% imshow(Ivd)
% subplot(2,3,5)
% imshow(Iv_del)
% subplot(2,3,6)
% pbaspect([1 1 1])
%%
% figure(3)
% imshow(Acumulador)
% axis on;
% set(gca,'XAxisLocation','top','YAxisLocation','left','ydir','reverse');
% %% Proves
% figure(4)
% pintar_linea(I,500,80); % 1527/2


