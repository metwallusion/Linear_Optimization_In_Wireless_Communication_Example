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

%% Matlab Solving Or Get A Matrix [SINCE WE CANNOT USE (linprog) FUNCTION WITH SYMS DATATYPES]
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

    