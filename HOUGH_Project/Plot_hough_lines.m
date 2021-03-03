function y = Plot_hough_lines(I,I_binaria,Acumulador,Rho_max,llindar,Discret_thetas,Tall_sup,Tall_inf)
[c1,c2] = size(I);
%image(img,'XData',[0 c2],'YData',[-1/4 1/4]);
imshow(I);
hold on;
% Agafar les rectes importants
M_lines = [];
[f,c] = size(Acumulador);
for e1 = 1:1:f
    for e2 = 1:1:c
        if Acumulador(e1,e2) > llindar
            M_lines = [M_lines;e1,e2];
            for i1 = (e1-20):1:(e1+20)
                for i2 = (e2-20):1:(e2+20)
                    try
                        Acumulador(i1,i2)=0;
                    end
                end
            end
        end
    end
end
%% Filtrar lineas semblants
M_lines
Rhos = M_lines(:,1);
Thetas = M_lines(:,2);
%% Conversio de index a angle
%Thetas_abans=Thetas
for e = 1:length(Thetas)
    Theta_convertit = Discret_thetas(Thetas(e));
    if Theta_convertit <= pi/2
        Thetas(e) = pi/2 - Theta_convertit;
    else
        Thetas(e) = -(Theta_convertit - pi/2);
    end
end
%% Trobar l'equaci� de les rectes   (y = m�x + b)
%Thetas_despres= Thetas
punt_recta = [Rhos.*cos(Thetas),Rhos.*sin(Thetas)];
m_perpen = punt_recta(:,2)./punt_recta(:,1);
b = punt_recta(:,2)+(m_perpen.^-1).*punt_recta(:,1);
%% Pintar les rectes

x = 0:0.1:c2;
y = -(m_perpen.^-1).*x+b;
y = y + Tall_sup; % correccio retall d'una imatge a laltre

% Dibuixar rectes dins del retall de la imatge
for e = 1: length(Rhos)
    y_plot = [0,c1-Tall_inf-Tall_sup];
    x_plot = (y_plot-b(e))./(-m_perpen(e)^-1)
    plot(x_plot,y_plot+Tall_sup,'linewidth',2,'color','b');
end
% y_plot = ones(length(Rhos),1).*[(c1-Tall_inf),Tall_sup] %% proves(no val)
% x_plot = (y_plot-b)./(-m_perpen.^-1)
%%
yp = m_perpen.*x;
%plot(x,y,'linewidth',2,'color','r'); hold on;
%plot(x,yp,'linewidth',1,'color','g');
%plot(punt_recta(:,1),punt_recta(:,2),'r*');  % pintar punts per on passa recta per origen i es perpendicular a la recta y

%axis([0 c2 a b]); no val per limitar rectes pk tambe retalla imatge
axis on;
set(gca,'XAxisLocation','top','YAxisLocation','left','ydir','reverse');
end