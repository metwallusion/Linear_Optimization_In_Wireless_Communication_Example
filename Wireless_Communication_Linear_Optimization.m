%% Input Definitions
n=input('Enter The Number Of Users Of A Wireless Com. System: ') %Define n users
syms p [1 n] %Power Array
syms h [1 n] %Channel Array
syms thr [1 n] %Threshold Array
sinr=[];

%% Sinal To Interference Ratio Equation
for i=1:n
tmp = p(i)*h(i)/(sum(p.*h)-(p(i)*h(i)));
sinr=[sinr tmp ];
end

%% Matlab Solving Or Get A Matrix [SINCE WE CANNOT USE (linprog) FUNCTION WITH SYMS DATATYPES UNLESS WE ASSUME NUMBERS]
A=[];
B=[];
[N,D] = numden(sinr); %Denominator and numerator split where N= hi*pi and D = sum(p.*h)-(p(i)*h(i))
signal_to_interference_ratio = sinr
chr = 'Where Numerator Denotes The Multiplication Of Channel H(i) Allocated To User By Its Power P(i)';
chr = [chr newline 'Where Denominator Denotes The Interference Of All Other Users, a.k.a Sum(H(Not = i)*P(Not = i))']
Numerator = N
Denominator = D
%Objective Display
Optimization_Problem ='Minimizing p1+ ... + pn'; 
Optimization_Problem=[Optimization_Problem newline 'Subject To'];
Optimization_Problem=[Optimization_Problem newline '  hi*pi - thr*Sum(hj*pj) >=0, i = 1,...,n'];
Optimization_Problem=[Optimization_Problem newline '  p1, ... , pn>=0'];

for i=1:n
    for j=1:n
        if i==j
            tmp = h(j); %All of the elements on the diagonals are to be optimized so A(1,1) = H(1), A(2,2) = H(2), etc.
            %to ensure the channel is out of interference
        else
            tmp = - thr(i)*h(j); %Otherwise (Interferences)
        end
        A=[A tmp];
    end
end
A=reshape(A,n,n);
C_Transposed = ones(1,n)';
b = 0; 
Optimization_Problem = [Optimization_Problem newline '       1. C-transposed Becomes'];
Optimization_Problem=[Optimization_Problem newline '       2. Matrix A Becomes'];
Optimization_Problem=[Optimization_Problem newline '       3. b Becomes']

C_Transposed
A
b

%% Assumption Of Numbers And Solve Using (linprog) Function
f=ones(1,n);
thr= 0.4 + (0.6-0.4) .* rand(n,1); %Assume that the threshold is dynamic and varying between 0.4 and 0.6
h= 0 + 1.*rand(n,1); %The channel is assumed to have a higher variance in between 0 and 1 which means that the mean is 0.5
A=[];
for i=1:n
    for j=1:n
        if i==j
            tmp = h(j); %All of the elements on the diagonals are to be optimized so A(1,1) = H(1), A(2,2) = H(2), etc.
            %to ensure the channel is out of interference
        else
            tmp = - thr(i)*h(j); %Otherwise (Interferences)
        end
        A=[A tmp];
    end
end
A=-reshape(A,n,n); %-ve as our objective is to have Ax >= b and the default for linprog is <=b


b=0.1*ones(1,n); %b theoretically must be 0 but in matlab if it is set to 0 we get a non-trivial solution for x a,k,a x=0 0 0
%so we set the b to 0.1 instead of 0
lb=[];
ub=[];
Aeq=[];
beq=[];
H_Channel_For_Each_User_Assumed = h
With_Threshold_Assumed_For_Each_User = thr
x = linprog(f,Aeq,beq,A,b,lb,ub);
Powers_To_Be_Transmitted_Ptxi_For_A_Reliable_Communication_Scenario = abs(x)

    
