function fo= func_objetivo(par)

global t_exp I_exp 
global I_sim S_sim R_sim
global ro mi beta gama 
global icont 
global x0 UB LB

% A cada itera��o, os par�metros s�o desnormalizados
for i=1:length(par)
    par_p(i)=par(i)*(UB(i)-LB(i))+LB(i);
end

% Defini��o dos par�metros
ro = par_p(1);
mi = par_p(2);
beta = par_p(3);
gama = par_p(4);

icont = icont + 1

% Solu��o diferencial
[t,ys]=ode45('diferencial',t_exp,x0);

S_sim=ys(:,1); % Suscet�veis
I_sim=ys(:,2); % Infectados
R_sim=ys(:,3); % Recuperados

% Fun��o objetivo
fo=sum((I_sim-I_exp).^2);

end

