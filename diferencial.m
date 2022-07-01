function yder = diferencial(t,y)

global ro mi beta gama 

% Variáveis 
S = y(1);
I = y(2);
R = y(3);

% Equações
N = S + I + R;
dS_dt = mi*N-ro*S-(beta/N)*I*S;
dI_dt = (beta/N)*I*S-gama*I-ro*I;
dR_dt = gama*I - ro*R;

% Resultados
yder(1) = dS_dt;
yder(2) = dI_dt;
yder(3) = dR_dt;
yder=yder';

end

