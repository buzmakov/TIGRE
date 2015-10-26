function [x,errorL2]= CGLS_CBCT(proj,geo,angles,niter)

reg=zeros(geo.nVoxel');

x=zeros(geo.nVoxel');
d=proj;
r0=Atb(proj,geo,angles);
r0=r0+0.01*reg;% Tikh Regularization;

t=Ax(r0,geo,angles);
reg=0.01*r0;% Tikh Regularization;



p=r0;

errorL2=zeros(niter,1);
for ii=1:niter
    
    alpha=norm(r0(:),2)^2/norm(t(:),2)^2;
    x=x+alpha*p;
    d=d-alpha*t;
    r1=Atb(d,geo,angles);
    r1=r1+0.01*reg;% Tikh Regularization;
    
    % Save error
    errorL2(ii)=norm(r1(:),2)^2;
    
    
    beta=norm(r1(:),2)^2/norm(r0(:),2)^2;
    p=r1+beta*p;
    t=Ax(p,geo,angles);
    reg=0.01*p; % Tikh Regularization;
    
    r0=r1;
    if mod(ii,50)==0
        disp(['Iteration: ',num2str(ii)]);
    end
    
end




end