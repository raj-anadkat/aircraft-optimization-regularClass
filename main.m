payload = 0; %lbs
friction = 0.1;
e = 2.71828;
fuse_width = 10;
liftFactor = 0.8;

%%%%%%%%avionics inputs
staticThrust = 6 ; %kg
dia = 22;
pitch = 12;
rpm = 3800;
ve_theo = (rpm*0.0254*pitch)/60;
ve_prac = 21.13;
exit = (ve_theo + ve_prac)/2;

staticThrustN = staticThrust*9.8 ;
alpha = staticThrustN/(exit^2);

%%%%%%%%%%%%%%%%

wingConfig = xlsread('aerodynamic_design_points.xlsx','FULL','A2:J448'); %change file location accoring to your excel

wingData = wingConfig(:,:);

%%%%%%%%%%%%%% ONE BALL CONFIG
S = 1; %no of spherical balls
cargoLength = 9; %inches

for a = 1:1:447 %%%%%%%%%%%%%% change end point of 'a' accoring to number of rows of excel
design_point = wingData(a,1);
span = wingData(a,2);
rootChord = wingData(a,3);
tipChord = wingData(a,4);
rectangularPercentage = wingData(a,5);
cl = wingData(a,9);
cd = wingData(a,10);
area = 0.00064516*((span*((rectangularPercentage*rootChord)+0.5*(100-rectangularPercentage)*(rootChord+tipChord))/(100))-fuse_width*rootChord);
normalarea = 0.00064516*((span*((rectangularPercentage*rootChord)+0.5*(100-rectangularPercentage)*(rootChord+tipChord))/(100)));

AR = (span*span)/normalarea;

 
dynamicThrust = staticThrustN;
if(span==60)
    mass = 9.7 + 0.938*S;
end
if(span==70)
    mass = 10 + 0.938*S;
end
if(span==80)
    mass = 10.3 + 0.938*S;
end
if(span==90)
    mass = 10.6 + 0.938*S;
end
if(span==100)
    mass = 11 + 0.938*S;
end
if(span==110)
    mass = 11.5 + 0.938*S;
end
if(span==120)
    mass = 12 + 0.938*S;
end

 

while(dynamicThrust>=0 && payload <= 40)
    payload = payload+0.0005;
    allUpWeight = payload + mass;

vStall = sqrt((2*allUpWeight*9.8)/(1.225*area*cl*2.2));
vLift = liftFactor * vStall;
dynamicThrust = staticThrustN - (alpha*vLift^2);


%%%%%%%%%%% integral constant calculation:
A = (((staticThrustN*2.2)/allUpWeight)-(friction*9.81));
B = ((1.225*area*0.5*(cd-(friction*cl)) + alpha)*2.2)/allUpWeight;
%%%%%%%%%%%%%%%%%%%%%

takeoffDistance = ((log(abs(A)/abs((A-(B*(vLift^2))))))/(2*B))*3.28;

if (takeoffDistance >=95) && (takeoffDistance <=95.015)
cargoWeight = payload;

FS = 120*((3*S + cargoWeight)/(span + cargoLength));
netWeight = cargoWeight + mass;

    
disp(['Design Point: ',num2str(design_point),' , ','Span: ',num2str(span),' , ','RC: ',num2str(rootChord),' , ','TC: ',num2str(tipChord),' , ','rect%: ',num2str(rectangularPercentage),' , ','cl: ',num2str(cl),' , ','cd: ',num2str(cd),' , ',' Payload: ',num2str(payload),' , ','Score: ',num2str(FS), ' , ',' All up: ',num2str(netWeight),' vLift: ',num2str(vLift),' 1 ball']);

end

end

payload = 0;

end

%%%%%%%%%%%%%% TWO BALL HORIZONTAL CONFIG
S = 2; %no of spherical balls
cargoLength = 18; %inches

for a = 1:1:447 %%%%%%%%%%%%%% change end point of 'a' accoring to number of rows of excel
design_point = wingData(a,1);
span = wingData(a,2);
rootChord = wingData(a,3);
tipChord = wingData(a,4);
rectangularPercentage = wingData(a,5);
cl = wingData(a,9);
cd = wingData(a,10);
area = 0.00064516*((span*((rectangularPercentage*rootChord)+0.5*(100-rectangularPercentage)*(rootChord+tipChord))/(100))-fuse_width*rootChord);

 
dynamicThrust = staticThrustN;
if(span==60)
    mass = 9.7 + 0.938*S + 0.27;
end
if(span==70)
    mass = 10 + 0.938*S +0.27 ;
end
if(span==80)
    mass = 10.3 + 0.938*S +0.27 ;
end
if(span==90)
    mass = 10.6 + 0.938*S + 0.27;
end
if(span==100)
    mass = 11 + 0.938*S + 0.27;
end
if(span==110)
    mass = 11.5 + 0.938*S +0.27 ;
end
if(span==120)
    mass = 12 + 0.938*S + 0.27 ;
end

 

while(dynamicThrust>=0 && payload <= 40)
    payload = payload+0.0005;
    allUpWeight = payload + mass;

vStall = sqrt((2*allUpWeight*9.8)/(1.225*area*cl*2.2));
vLift = liftFactor * vStall;
dynamicThrust = staticThrustN - (alpha*vLift^2);


%%%%%%%%%%% integral constant calculation:
A = (((staticThrustN*2.2)/allUpWeight)-(friction*9.81));
B = ((1.225*area*0.5*(cd-(friction*cl)) + alpha)*2.2)/allUpWeight;
%%%%%%%%%%%%%%%%%%%%%

takeoffDistance = ((log(abs(A)/abs((A-(B*(vLift^2))))))/(2*B))*3.28;

if (takeoffDistance >=95) && (takeoffDistance <=95.015)
cargoWeight = payload;

FS = 120*((3*S + cargoWeight)/(span + cargoLength));
netWeight = cargoWeight + mass;

    
disp(['Design Point: ',num2str(design_point),' , ','Span: ',num2str(span),' , ','RC: ',num2str(rootChord),' , ','TC: ',num2str(tipChord),' , ','rect%: ',num2str(rectangularPercentage),' , ','cl: ',num2str(cl),' , ','cd: ',num2str(cd),' , ',' Payload: ',num2str(payload),' , ','Score: ',num2str(FS), ' , ',' All up: ',num2str(netWeight),' vLift: ',num2str(vLift),' 2 BALL HORIZONTAL']);

end

end

payload = 0;

end

%%%%%%%%%%%%%% TWO BALL VERTICAL CONFIG
S = 2; %no of spherical balls
cargoLength = 9; %inches

for a = 1:1:447 %%%%%%%%%%%%%% change end point of 'a' accoring to number of rows of excel
design_point = wingData(a,1);
span = wingData(a,2);
rootChord = wingData(a,3);
tipChord = wingData(a,4);
rectangularPercentage = wingData(a,5);
cl = wingData(a,9);
cd = wingData(a,10);
area = 0.00064516*((span*((rectangularPercentage*rootChord)+0.5*(100-rectangularPercentage)*(rootChord+tipChord))/(100))-fuse_width*rootChord);

 
dynamicThrust = staticThrustN;
if(span==60)
    mass = 9.7 + 0.938*S + 0.292;
end
if(span==70)
    mass = 10 + 0.938*S +0.292 ;
end
if(span==80)
    mass = 10.3 + 0.938*S +0.292 ;
end
if(span==90)
    mass = 10.6 + 0.938*S + 0.292;
end
if(span==100)
    mass = 11 + 0.938*S + 0.292;
end
if(span==110)
    mass = 11.5 + 0.938*S +0.292 ;
end
if(span==120)
    mass = 12 + 0.938*S + 0.292 ;
end

 

while(dynamicThrust>=0 && payload <= 40)
    payload = payload+0.0005;
    allUpWeight = payload + mass;

vStall = sqrt((2*allUpWeight*9.8)/(1.225*area*cl*2.2));
vLift = liftFactor * vStall;
dynamicThrust = staticThrustN - (alpha*vLift^2);


%%%%%%%%%%% integral constant calculation:
A = (((staticThrustN*2.2)/allUpWeight)-(friction*9.81));
B = ((1.225*area*0.5*(cd-(friction*cl)) + alpha)*2.2)/allUpWeight;
%%%%%%%%%%%%%%%%%%%%%

takeoffDistance = ((log(abs(A)/abs((A-(B*(vLift^2))))))/(2*B))*3.28;

if (takeoffDistance >=95) && (takeoffDistance <=95.015)
cargoWeight = payload;

FS = 120*((3*S + cargoWeight)/(span + cargoLength));
netWeight = cargoWeight + mass;

    
disp(['Design Point: ',num2str(design_point),' , ','Span: ',num2str(span),' , ','RC: ',num2str(rootChord),' , ','TC: ',num2str(tipChord),' , ','rect%: ',num2str(rectangularPercentage),' , ','cl: ',num2str(cl),' , ','cd: ',num2str(cd),' , ',' Payload: ',num2str(payload),' , ','Score: ',num2str(FS), ' , ',' All up: ',num2str(netWeight),' vLift: ',num2str(vLift),'2 BALL VERTICAL']);

end

end

payload = 0;

end

%%%%%%%%%%%%%% THREE BALL TRIANGLE CONFIG
S = 3; %no of spherical balls
cargoLength = 18; %inches

for a = 1:1:447 %%%%%%%%%%%%%% change end point of 'a' accoring to number of rows of excel
design_point = wingData(a,1);
span = wingData(a,2);
rootChord = wingData(a,3);
tipChord = wingData(a,4);
rectangularPercentage = wingData(a,5);
cl = wingData(a,9);
cd = wingData(a,10);
area = 0.00064516*((span*((rectangularPercentage*rootChord)+0.5*(100-rectangularPercentage)*(rootChord+tipChord))/(100))-fuse_width*rootChord);

 
dynamicThrust = staticThrustN;
if(span==60)
    mass = 9.7 + 0.938*S + 0.98;
end
if(span==70)
    mass = 10 + 0.938*S +0.98 ;
end
if(span==80)
    mass = 10.3 + 0.938*S +0.98 ;
end
if(span==90)
    mass = 10.6 + 0.938*S + 0.98;
end
if(span==100)
    mass = 11 + 0.938*S + 0.98;
end
if(span==110)
    mass = 11.5 + 0.938*S +0.98 ;
end
if(span==120)
    mass = 12 + 0.938*S + 0.98 ;
end

 

while(dynamicThrust>=0 && payload <= 40)
    payload = payload+0.0005;
    allUpWeight = payload + mass;

vStall = sqrt((2*allUpWeight*9.8)/(1.225*area*cl*2.2));
vLift = liftFactor * vStall;
dynamicThrust = staticThrustN - (alpha*vLift^2);


%%%%%%%%%%% integral constant calculation:
A = (((staticThrustN*2.2)/allUpWeight)-(friction*9.81));
B = ((1.225*area*0.5*(cd-(friction*cl)) + alpha)*2.2)/allUpWeight;
%%%%%%%%%%%%%%%%%%%%%

takeoffDistance = ((log(abs(A)/abs((A-(B*(vLift^2))))))/(2*B))*3.28;

if (takeoffDistance >=95) && (takeoffDistance <=95.015)
cargoWeight = payload;

FS = 120*((3*S + cargoWeight)/(span + cargoLength));
netWeight = cargoWeight + mass;

    
disp(['Design Point: ',num2str(design_point),' , ','Span: ',num2str(span),' , ','RC: ',num2str(rootChord),' , ','TC: ',num2str(tipChord),' , ','rect%: ',num2str(rectangularPercentage),' , ','cl: ',num2str(cl),' , ','cd: ',num2str(cd),' , ',' Payload: ',num2str(payload),' , ','Score: ',num2str(FS), ' , ',' All up: ',num2str(netWeight),' vLift: ',num2str(vLift),'3 BALL TRIANGLE']);

end

end

payload = 0;

end
%%%%%%%%%%%%%% FOUR BALL SQUARE CONFIG
S = 4; %no of spherical balls
cargoLength = 18; %inches

for a = 1:1:447 %%%%%%%%%%%%%% change end point of 'a' accoring to number of rows of excel
design_point = wingData(a,1);
span = wingData(a,2);
rootChord = wingData(a,3);
tipChord = wingData(a,4);
rectangularPercentage = wingData(a,5);
cl = wingData(a,9);
cd = wingData(a,10);
area = 0.00064516*((span*((rectangularPercentage*rootChord)+0.5*(100-rectangularPercentage)*(rootChord+tipChord))/(100))-fuse_width*rootChord);

 
dynamicThrust = staticThrustN;
if(span==60)
    mass = 9.7 + 0.938*S + 1.08;
end
if(span==70)
    mass = 10 + 0.938*S + 1.08 ;
end
if(span==80)
    mass = 10.3 + 0.938*S + 1.08 ;
end
if(span==90)
    mass = 10.6 + 0.938*S + 1.08;
end
if(span==100)
    mass = 11 + 0.938*S + 1.08;
end
if(span==110)
    mass = 11.5 + 0.938*S + 1.08 ;
end
if(span==120)
    mass = 12 + 0.938*S + 1.08 ;
end

 

while(dynamicThrust>=0 && payload <= 40)
    payload = payload+0.0005;
    allUpWeight = payload + mass;

vStall = sqrt((2*allUpWeight*9.8)/(1.225*area*cl*2.2));
vLift = liftFactor * vStall;
dynamicThrust = staticThrustN - (alpha*vLift^2);


%%%%%%%%%%% integral constant calculation:
A = (((staticThrustN*2.2)/allUpWeight)-(friction*9.81));
B = ((1.225*area*0.5*(cd-(friction*cl)) + alpha)*2.2)/allUpWeight;
%%%%%%%%%%%%%%%%%%%%%

takeoffDistance = ((log(abs(A)/abs((A-(B*(vLift^2))))))/(2*B))*3.28;

if (takeoffDistance >=95) && (takeoffDistance <=95.015)
cargoWeight = payload;

FS = 120*((3*S + cargoWeight)/(span + cargoLength));
netWeight = cargoWeight + mass;

    
disp(['Design Point: ',num2str(design_point),' , ','Span: ',num2str(span),' , ','RC: ',num2str(rootChord),' , ','TC: ',num2str(tipChord),' , ','rect%: ',num2str(rectangularPercentage),' , ','cl: ',num2str(cl),' , ','cd: ',num2str(cd),' , ',' Payload: ',num2str(payload),' , ','Score: ',num2str(FS), ' , ',' All up: ',num2str(netWeight),' vLift: ',num2str(vLift),'4 BALL SQUARE']);

end

end

payload = 0;

end

%%%%%%%%%%%%%% FIVE BALL TRIANGLE CONFIG
S = 5; %no of spherical balls
cargoLength = 27; %inches

for a = 1:1:447 %%%%%%%%%%%%%% change end point of 'a' accoring to number of rows of excel
design_point = wingData(a,1);
span = wingData(a,2);
rootChord = wingData(a,3);
tipChord = wingData(a,4);
rectangularPercentage = wingData(a,5);
cl = wingData(a,9);
cd = wingData(a,10);
area = 0.00064516*((span*((rectangularPercentage*rootChord)+0.5*(100-rectangularPercentage)*(rootChord+tipChord))/(100))-fuse_width*rootChord);

 
dynamicThrust = staticThrustN;
if(span==60)
    mass = 9.7 + 0.938*S + 1.8;
end
if(span==70)
    mass = 10 + 0.938*S + 1.8 ;
end
if(span==80)
    mass = 10.3 + 0.938*S + 1.8 ;
end
if(span==90)
    mass = 10.6 + 0.938*S + 1.8;
end
if(span==100)
    mass = 11 + 0.938*S + 1.8;
end
if(span==110)
    mass = 11.5 + 0.938*S + 1.8 ;
end
if(span==120)
    mass = 12 + 0.938*S + 1.8 ;
end

 

while(dynamicThrust>=0 && payload <= 40)
    payload = payload+0.0005;
    allUpWeight = payload + mass;

vStall = sqrt((2*allUpWeight*9.8)/(1.225*area*cl*2.2));
vLift = liftFactor * vStall;
dynamicThrust = staticThrustN - (alpha*vLift^2);


%%%%%%%%%%% integral constant calculation:
A = (((staticThrustN*2.2)/allUpWeight)-(friction*9.81));
B = ((1.225*area*0.5*(cd-(friction*cl)) + alpha)*2.2)/allUpWeight;
%%%%%%%%%%%%%%%%%%%%%

takeoffDistance = ((log(abs(A)/abs((A-(B*(vLift^2))))))/(2*B))*3.28;

if (takeoffDistance >=95) && (takeoffDistance <=95.015)
cargoWeight = payload;

FS = 120*((3*S + cargoWeight)/(span + cargoLength));
netWeight = cargoWeight + mass;

    
disp(['Design Point: ',num2str(design_point),' , ','Span: ',num2str(span),' , ','RC: ',num2str(rootChord),' , ','TC: ',num2str(tipChord),' , ','rect%: ',num2str(rectangularPercentage),' , ','cl: ',num2str(cl),' , ','cd: ',num2str(cd),' , ',' Payload: ',num2str(payload),' , ','Score: ',num2str(FS), ' , ',' All up: ',num2str(netWeight),' vLift: ',num2str(vLift),'5 BALL TRIANGLE']);

end

end

payload = 0;

end
%%%%%%%%%%%%%% SIX BALL RECTANGLE CONFIG
S = 6; %no of spherical balls
cargoLength = 27; %inches

for a = 1:1:447 %%%%%%%%%%%%%% change end point of 'a' accoring to number of rows of excel
design_point = wingData(a,1);
span = wingData(a,2);
rootChord = wingData(a,3);
tipChord = wingData(a,4);
rectangularPercentage = wingData(a,5);
cl = wingData(a,9);
cd = wingData(a,10);
area = 0.00064516*((span*((rectangularPercentage*rootChord)+0.5*(100-rectangularPercentage)*(rootChord+tipChord))/(100))-fuse_width*rootChord);

 
dynamicThrust = staticThrustN;
if(span==60)
    mass = 9.7 + 0.938*S + 1.9;
end
if(span==70)
    mass = 10 + 0.938*S + 1.9 ;
end
if(span==80)
    mass = 10.3 + 0.938*S + 1.9 ;
end
if(span==90)
    mass = 10.6 + 0.938*S + 1.9;
end
if(span==100)
    mass = 11 + 0.938*S + 1.9;
end
if(span==110)
    mass = 11.5 + 0.938*S + 1.9 ;
end
if(span==120)
    mass = 12 + 0.938*S + 1.9 ;
end

 

while(dynamicThrust>=0 && payload <= 40)
    payload = payload+0.0005;
    allUpWeight = payload + mass;

vStall = sqrt((2*allUpWeight*9.8)/(1.225*area*cl*2.2));
vLift = liftFactor * vStall;
dynamicThrust = staticThrustN - (alpha*vLift^2);


%%%%%%%%%%% integral constant calculation:
A = (((staticThrustN*2.2)/allUpWeight)-(friction*9.81));
B = ((1.225*area*0.5*(cd-(friction*cl)) + alpha)*2.2)/allUpWeight;
%%%%%%%%%%%%%%%%%%%%%

takeoffDistance = ((log(abs(A)/abs((A-(B*(vLift^2))))))/(2*B))*3.28;

if (takeoffDistance >=95) && (takeoffDistance <=95.015)
cargoWeight = payload;

FS = 120*((3*S + cargoWeight)/(span + cargoLength));
netWeight = cargoWeight + mass;

    
disp(['Design Point: ',num2str(design_point),' , ','Span: ',num2str(span),' , ','RC: ',num2str(rootChord),' , ','TC: ',num2str(tipChord),' , ','rect%: ',num2str(rectangularPercentage),' , ','cl: ',num2str(cl),' , ','cd: ',num2str(cd),' , ',' Payload: ',num2str(payload),' , ','Score: ',num2str(FS), ' , ',' All up: ',num2str(netWeight),' vLift: ',num2str(vLift),' 6 BALL RECTANGLE']);

end

end

payload = 0;

end



