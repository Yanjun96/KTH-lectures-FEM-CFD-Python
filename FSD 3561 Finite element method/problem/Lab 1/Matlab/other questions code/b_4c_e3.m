clear;close all;clc;
% for equation (3)
xmin = 2; 
xmax = 4;
for i=[4,8,16,32,64]
N=i;

x=mesh(xmin,xmax,N);
g=[3 5];
kappa = [0 0];

A=StiffnessAssembler1D(x,@k,kappa);
M=MassAssembler1D(x,@p);
b=LoadAssembler1D(x,@f,g);

uh= A\b;
S= A+M;

fu_ex =@(x) x.^2-5*x+9; % exact solution for equation 3
%xmid=zeros(1,N);
%uhmid=zeros(1,N);
xsixpoint =[];
uhsixpoint =[];
for j=1:length(x)-1
%     xmid(j)=(x(j+1)+x(j))/2;
%     uhmid(j)=(uh(j+1)+uh(j))/2;
      xsixpoint = [xsixpoint; linspace(x(j), x(j+1), 6)];
      uhsixpoint = [uhsixpoint; linspace(uh(j), uh(j+1), 6)];
end
u_ex=fu_ex(xsixpoint);
%figure()

subplot(2,2,1)
semilogy(xsixpoint(1,:),uhsixpoint(1,:)-u_ex(1,:),LineWidth=2)
hold on;
subplot(2,2,2)
semilogy(xsixpoint(2,:),uhsixpoint(2,:)-u_ex(2,:),LineWidth=2)
hold on;
subplot(2,2,3)
semilogy(xsixpoint(3,:),uhsixpoint(3,:)-u_ex(3,:),LineWidth=2)
hold on;
subplot(2,2,4)
semilogy(xsixpoint(4,:),uhsixpoint(4,:)-u_ex(4,:),LineWidth=2)
hold on;
xlabel('x');
ylabel('Error');
legend('N=4,8,16,32,64')
%title('Equation 3, N=4 and 16 for the element centers error')
hold on; 

end
% u_ex=u_ex';
% 
% for j=1:length(u_ex)
% u_ex_mid=(u_ex(i)+u_ex(i+1))/2;
% end
% 
% error = uh-u_ex;
% 
% 
% plot(x',uh',LineWidth=2)
% hold on
% plot(x,u_ex');
% xlabel('x');
% ylabel('u');
% end
% legend('N=4','N=16')
% title('Equation 3, N=4 and 16 for the uh')

% k
function y=k(x)
y=x; 
end

% p
function y=p(x)
y=0*x;
end

% f
function y=f(x)
y=5-4*x;  % should be rhs funciton
end
