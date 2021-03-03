function y = Hough_complet(Frame,c,c_max)
if c == c_max    
    I = rgb2gray(Frame);
    I = im2double(I);
    I = im2double(I);
    [f,c] = size(I); Tall_sup = 335;Tall_inf = 200; % 500, 320 va be per Im_car
    I = imcrop(I,[0 Tall_sup c (f-Tall_sup-Tall_inf)]);

    Iv = edge(I,'canny');
    
    Discret_thetas=(pi*0.2:0.05:pi*0.8); 
    [Acumulador,Rho_max] = trans_Hough_casera(Iv,Discret_thetas);

    [y,x_plot,y_plot]=Plot_hough_lines(Frame,Iv,Acumulador,Rho_max,0.95,Discret_thetas,Tall_sup,Tall_inf);
else
    try
        plot(x_plot,y_plot+Tall_sup,'linewidth',2,'color','b');
    end
end
end

