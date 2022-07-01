% RESOLUÇÃO DA QUESTÃO 2

clear all
close all

global t_exp I_exp 
global x0 UB LB
global icont 
global I_sim S_sim R_sim 

% Carregamento dos dados
data = xlsread('data_ep');

% Definição da variáveis experimentais
t_exp = data(:,1);
I_exp = data(:,2);

% Contador 
icont = 0;

% Condição inicial para as equações diferenciais
x0 = [200e6 1 0];

% Parâmetros
P0 = [1/30 1/30 1/10 1/10]; % Chute inicial 
UB = [1/5 1/5 10 10];       % Limite superior 
LB = [1/30 1/30 1/10 1/10]; % Limite inferior

% Normalização
for i=1:length(P0)
    P0n(i)=(P0(i)-LB(i))/(UB(i)-LB(i)); 
end
n_par=length(P0);
LBn=zeros(n_par,1); 
UBn=ones(n_par,1);  

% Opções para plotar a função objetivo
options = struct('PlotFcns',@optimplotfval,'MaxFunctionEvaluations', 10000)

% Solução
[par,fval]=fmincon('func_objetivo',P0n,[],[],[],[],LBn,UBn,'',options);

% Desnormalização
for i=1:length(par)
    parf(i)=par(i)*(UB(i)-LB(i))+LB(i);
end

% Parâmetros finais
mif=parf(1);
rof=parf(2);
betaf=parf(3);
gamaf=parf(4);

% Imprimindo parâmetros
fprintf('mi = %f\n', mif)
fprintf('ro = %f\n', rof)
fprintf('beta = %f\n', betaf)
fprintf('gama = %f\n', gamaf)

% Plotagem
plot(t_exp,S_sim,'ko',t_exp,R_sim,'mx',t_exp,I_sim,'b*');
title('Comportamento dos dados simulados');
xlabel('Tempo / dias') ;
ylabel('Quantidade de indivíduos') ;
legend('Suscetíveis','Recuperados','Infectados');
saveas(gca,'Dados simulados','png');

plot(t_exp,I_exp,'bo',t_exp,I_sim,'r');
title('Comportamento dos infectados');
xlabel('Tempo / dias'); 
ylabel('Quantidade de infectados'); 
legend('Experimental','Modelo');
saveas(gca,'Resultados do modelo','png');


