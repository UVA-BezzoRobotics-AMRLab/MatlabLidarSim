function plotUAV3D(center,rot,wspan,wblades)
if nargin == 3
    wblades = 20;
end
    pt1 =  center + wspan.*[cos(rot+pi/4) sin(rot+pi/4) 0];
    pt2 =  center - wspan.*[cos(rot+pi/4) sin(rot+pi/4) 0];
    pt3 =  center - wspan.*[cos(rot-pi/4) sin(rot-pi/4) 0];
    pt4 =  center + wspan.*[cos(rot-pi/4) sin(rot-pi/4) 0];
    
    body = [pt1;pt2;pt3;pt4];
    
    plot3(body(1:2,1),body(1:2,2),body(1:2,3),'k','LineWidth',2.5)
    plot3(body(3:4,1),body(3:4,2),body(3:4,3),'k','LineWidth',2.5)
    for i = 1:4
        [bladeX{i},bladeY{i},bladeZ{i}] = ellipsoid(body(i,1),body(i,2),body(i,3)+wspan/10,wblades,wblades,0);
        surf(bladeX{i},bladeY{i},bladeZ{i},'EdgeColor','none','FaceColor',[0.5,0.5,0.5],'FaceAlpha',0.5)
    end
end