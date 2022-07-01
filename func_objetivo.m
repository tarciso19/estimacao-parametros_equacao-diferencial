function fo= func_objetivo(par)

global t_exp I_exp 
global I_sim S_sim R_sim
global ro mi beta gama 
global icont 
global x0 UB LB

% A cada iteração, os parâmetros são desnormalizados
for i=1:length(par)
    par_p(i)=par(i)*(UB(i)-LB(i))+LB(i);
end

% Definição dos parâmetros
ro = par_p(1);
mi = par_p(2);
beta = par_p(3);
gama = par_p(4);

icont = icont + 1

% Solução diferencial
[t,ys]=ode45('diferencial',t_exp,x0);

S_sim=ys(:,1); % Suscetíveis
I_sim=ys(:,2); % Infectados
R_sim=ys(:,3); % Recuperados

% Função objetivo
fo=sum((I_sim-I_exp).^2);

end

