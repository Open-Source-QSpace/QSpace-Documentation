Complete source code can be downloaded from [DMRG](./DMRGHubbard2D.zip).

```
clear;

%%% begin input parameters %%%

t = 1; % nn-hopping amplitude
t_ = -0.2; % nnn-hopping amplitude
U = 8; % onsite repulsion

width = 5; % width of cylinder
height = 4; % height of cylinder
fPBC = true; % periodic boundary conditions along y

sym = 'SU2'; % U(1)_{charge} x SU(2)_{spin}
%sym = 'U1'; % U(1)_{charge} x U(1)_{spin}

D = 2000; % MPS bond dimension
w = ham.get_num_mpo_states( sym, height, fPBC, t_ );
D_prime = floor(D/w);
D_hat = D;
D_tilde = floor(D/10);

num_sweeps = 1000; % number of sweeps
num_davidson = 3; % number of davidson steps
eps_davidson = 1e-10; % threshold for termination of davidson
num_zero = 1e-10; % numerical zero

% pick type of optimization
%opt_enum = 1; % twosite
opt_enum = 2; % shrewd cbe 

%%% end input paramters %%%

N = width*height;
if strcmp(sym,'U1')
	[F,Z,S,I] = getLocalSpace('FermionS','Acharge,Aspin');
else
	[F,Z,S,I] = getLocalSpace('FermionS','Acharge,SU2spin');
end
local_space = {F,Z,S,I};

% initialize tensor network
network = Network;
network.mps = ham.get_prod_state(N,sym);
network.mpo = ham.get_mpo( t, t_, U, sym, width, height, fPBC );
network.model_iden = I.E;
network.D = D;
network.D_prime = D_prime;
network.D_hat = D_hat;
network.D_tilde = D_tilde;
network.num_davidson = num_davidson;
network.eps_davidson = eps_davidson;
network.num_zero = num_zero;
network.num_zero = num_zero;
network.opt_enum = opt_enum;
network.timetracker = TimeTracker;

fprintf("DMRG ground state calculation for the Hubbard model on a cylinder\n\n");

if strcmp(sym,'U1')
	fprintf("Acharge,Aspin\n");
else
	fprintf("Acharge,SU2spin\n");
end
if fPBC==1
	fprintf("periodic boundary conditions in y\n");
else
	fprintf("open boundary conditions in y\n");
end
fprintf("t: %.16f\n",t);
fprintf("t_: %.16f\n",t_);
fprintf("U: %.16f\n",U);
fprintf("width: %i\n",width);
fprintf("height: %i\n",height);

fprintf("D: %i\n",D);
fprintf("D_prime: %i\n",D_prime);
fprintf("D_hat: %i\n",D_hat);
fprintf("D_tilde: %i\n",D_tilde);
fprintf("num_sweeps: %i\n",num_sweeps);
fprintf("num_davidson: %.16f\n",num_davidson);
fprintf("eps_davidson: %.16f\n",eps_davidson);
fprintf("num_zero: %i\n",num_zero);

if opt_enum==1
	fprintf("twosite opt\n");
end
if opt_enum==2
	fprintf("shrewd cbe opt\n");
end
fprintf("\n\n");

% contract from right to left in the beginning
for i=(N:-1:3)
	network.env_contract(i,i+1);
end

if opt_enum==1
	% sweep and optimize twosite
	for i=(1:num_sweeps)
		network.twosite_sweep(i);
		network.print_time();
		pid = sprintf('%i',feature('getpid'));
		[tmp mem_usage] = system(['cat /proc/' pid '/status | grep VmRSS']);
		fprintf("RSS: %i MB\n", round(str2num(strtrim(extractAfter(extractBefore(mem_usage, ' kB'), ':'))) / 1000));
		[tmp mem_usage] = system(['cat /proc/' pid '/status | grep VmHWM']);
		fprintf("Peak RSS: %i MB\n\n", round(str2num(strtrim(extractAfter(extractBefore(mem_usage, ' kB'), ':'))) / 1000));
	end
else
	% sweep and optimize cbe-onesite
	for i=(1:num_sweeps)
		network.cbe_sweep(i);
		network.print_time();
		pid = sprintf('%i',feature('getpid'));
		[tmp mem_usage] = system(['cat /proc/' pid '/status | grep VmRSS']);
		fprintf("RSS: %i MB\n", round(str2num(strtrim(extractAfter(extractBefore(mem_usage, ' kB'), ':'))) / 1000));
		[tmp mem_usage] = system(['cat /proc/' pid '/status | grep VmHWM']);
		fprintf("Peak RSS: %i MB\n\n", round(str2num(strtrim(extractAfter(extractBefore(mem_usage, ' kB'), ':'))) / 1000));
	end
end
```