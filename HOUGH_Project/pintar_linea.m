function y = pintar_linea(I,Rho_max,angle)
%for e1 = Acumulador 

imshow(I);hold on;
punt_recta = [Rho_max*cos((angle)*(pi/180)),Rho_max*sin((angle)*(pi/180))]; % y = m·x + b
m_perpen = punt_recta(2)/punt_recta(1);
b = punt_recta(2)+(m_perpen^-1)*punt_recta(1);
%fplot(@(x) (m*x+b),[0 1920],'b','linewidth',4);

% for x = 1:1920
%     yy = m*x+b;
%     if (yy >= 0) && (yy <= 1080)
%         I(yy,x) = 1;
%     end
% end
x = 0:0.01:1920;
y =  [m_perpen*x;-(m_perpen^-1)*x+b];

plot(x,y,'linewidth',4); hold on;
plot(punt_recta(1),punt_recta(2),'r*');

axis on;
set(gca,'XAxisLocation','top','YAxisLocation','left','ydir','reverse');
end