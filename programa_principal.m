% RESOLU��O DA QUEST�O 2

clear all
close all

global t_exp I_exp 
global x0 UB LB
global icont 
global I_sim S_sim R_sim 

% Carregamento dos dados
data = xlsread('data_ep');

% Defini��o da vari�veis experimentais
t_exp = data(:,1);
I_exp = data(:,2);

% Contador 
icont = 0;

% Condi��o inicial para as equa��es diferenciais
x0 = [200e6 1 0];

% Par�metros
P0 = [1/30 1/30 1/10 1/10]; % Chute inicial 
UB = [1/5 1/5 10 10];       % Limite superior 
LB = [1/30 1/30 1/10 1/10]; % Limite inferior

% Normaliza��o
for i=1:length(P0)
    P0n(i)=(P0(i)-LB(i))/(UB(i)-LB(i)); 
end
n_par=length(P0);
LBn=zeros(n_par,1); 
UBn=ones(n_par,1);  

% Op��es para plotar a fun��o objetivo
options = struct('PlotFcns',@optimplotfval,'MaxFunctionEvaluations', 10000)

% Solu��o
[par,fval]=fmincon('func_objetivo',P0n,[],[],[],[],LBn,UBn,'',options);

% Desnormaliza��o
for i=1:length(par)
    parf(i)=par(i)*(UB(i)-LB(i))+LB(i);
end

% Par�metros finais
mif=parf(1);
rof=parf(2);
betaf=parf(3);
gamaf=parf(4);

% Imprimindo par�metros
fprintf('mi = %f\n', mif)
fprintf('ro = %f\n', rof)
fprintf('beta = %f\n', betaf)
fprintf('gama = %f\n', gamaf)

% Plotagem
plot(t_exp,S_sim,'ko',t_exp,R_sim,'mx',t_exp,I_sim,'b*');
title('Comportamento dos dados simulados');
xlabel('Tempo / dias') ;
ylabel('Quantidade de indiv�duos') ;
legend('Suscet�veis','Recuperados','Infectados');
saveas(gca,'Dados simulados','png');

plot(t_exp,I_exp,'bo',t_exp,I_sim,'r');
title('Comportamento dos infectados');
xlabel('Tempo / dias'); 
ylabel('Quantidade de infectados'); 
legend('Experimental','Modelo');
saveas(gca,'Resultados do modelo','png');


