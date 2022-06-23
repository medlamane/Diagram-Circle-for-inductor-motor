% Developed by Med Lamane 
%I0   : No-load current
%Arg0 : No-load current-voltage phase shift
%I1   : Short circuit current
%Arg1 : Short circuit current-voltage phase shift
%Ig   : Operating current
%r    : Stator resistor
%U    : Compound voltage at the stator
clc, clear all
U = 220;    r=0;
I0=28;  Arg0=90;
I1=364; Arg1=80;
Ig=364;

Pjs = 3*r*I1^2;

P0=[I0 (Arg0/360)*2*pi];
P1=[I1 (Arg1/360)*2*pi];

P_0=[P0(1)*cos(P0(2)) P0(1)*sin(P0(2))];
P_1=[P1(1)*cos(P1(2)) P1(1)*sin(P1(2))];
p0=[0 P_0(1)]; x0=[0 P_0(2)];
p1=[0 P_1(1)]; x1=[0 P_1(2)];
del=[P_0(1) P_1(1)]; x2=[P_0(2) P_1(2)];
h1 = (Pjs/(sqrt(3)*U))+P_0(1);
H1 = [Pjs P_1(2)];
%fonction med = ax+b

a=(P_0(1)-P_1(1))/(P_0(2)-P_1(2));
b=P_0(1)-a*P_0(2);
P_m=(P_0+P_1)/2;
t=[0:0.1:I1];%t=t+P_m(1);
M=P_m(2)+b+a*P_m(1);
med =-(a*t+b)+M;
plot(x0,p0,'r')
hold on
grid minor
plot(x1,p1,'r')
plot(x2 ,del)
plot(P_1(2),h1,'ro')
plot(med,t)
i=1;
K =-(a*t(i)+b)+M;
Op=0;
while t(i) <= P_0(1)
    
 K =-(a*t(i)+b)+M;
 Op=[K t(i)];
 i=i+1;
end

    theta = 0:10^-4:pi;
rayon = sqrt((P_1(1)-Op(2))^2+(P_1(2)-Op(1))^2);
x = Op(1)+rayon*cos(theta);
y = Op(2)+rayon*sin(theta);
plot(x,y)
%d=sqrt(x.^2+y.^2);
%axis equal
 theta = 0:0.01:pi/2;
xg = Ig*cos(theta);
yg = Ig*sin(theta);
plot(xg,yg,'g')
i=1;
d=0; Xg=0;Yg=0;
while abs(d-Ig)>10^-2
d=sqrt(x(i)^2+y(i)^2);
    Xg=x(i);
    Yg=y(i);
   i=i+1; 
end
plot(Xg,Yg,'go')
xlabel('Current (I)')
ylabel('Voltage (V)')
% Pinf %%
a1 = (P_0(1)-h1)/(P_0(2)-P_1(2));
b1 = P_0(1)-a1*P_0(2);
t1=[P_0(2):0.1:2*Op(1)];
D1=a1*t1+b1;
plot(t1,D1)
Pu = sqrt(3)*U*(Yg-(a*Xg+b))
Ptr = sqrt(3)*U*(Yg-(a1*Xg+b1))
Pa = sqrt(3)*U*(Yg)
S = sqrt(3)*U*Ig;
cosphi = Pa/S
g=(Ptr-Pu)/Ptr
