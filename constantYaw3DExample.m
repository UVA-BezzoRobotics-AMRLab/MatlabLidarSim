clc; clear all; close all
addpath("utils"); addpath("vol3d")
%Initialize empty map
mapSize = [100,120,100];
occMap = zeros(mapSize);
%Draw an obstacle in the empty map using meshgrid
startx = 8; starty = 4; startz = 8;
cubeSize = 2;
[xOb,yOb,zOb] = meshgrid(startx:startx+cubeSize,starty:starty+cubeSize,startz:startz+cubeSize);
obstacle = [xOb(:),yOb(:),zOb(:)];
idx1 = sub2ind(mapSize,yOb(:),xOb(:),zOb(:));
occMap(idx1) = 1;
%Turn obstacles into x,y,z coordinates
idx2 = find(occMap);
[r_o,c_o,h_o] = ind2sub(mapSize,idx2);
y_o = r_o; x_o = c_o; z_o = h_o;
obs = [x_o,y_o,z_o];

%Initialize vehicle
pos = [1;1;10; 0; 0; pi/4]; %x,y,z then pitch,roll,yaw of sensor
knownMap = ones(mapSize)*0.5; %initialize known map
%Set sensor parameters
angles = -pi/4:pi/16:pi/4; 
[ang_phi,ang_psi] = meshgrid(angles,angles); %pitch/yaw of sensor
angles3D = [ang_phi(:),ang_psi(:)];
maxRange = 10; %Define max range
max_v = 2; max_a = pi/4; %Max linear & angular velocity
%Example plot with constant x,y movement and yaw
for i = 1:100
    [z,rayPts,obsInRange,endPts] = lidarSim3D(angles3D,pos,obs,maxRange,maxRange*2,mapSize);
    knownMap = updateOccupancyMap(z,knownMap,mapSize);
    hold on
    %Plot occupancy matrix
    h = vol3d('cdata',occMap.*50,'XData',[1,size(occMap,2)],'YData',[1,size(occMap,1)],'ZData',[1,size(occMap,3)]);
    colormap(h.parent,flipud(bone));
    xlabel('x'); ylabel('y'); zlabel('z')
    %Plot convex hull of UAV and sensor end points
    endPts(end+1,:) = pos(1:3)';
    k = convhull(endPts,'Simplify',true);
    trisurf(k,endPts(:,1),endPts(:,2),endPts(:,3),'facecolor', 'r','facealpha',0.1,'edgecolor', 'none')
    %Plot UAV
    plotUAV3D(pos(1:3)',pos(6),0.6,0.3)
    xlim([0 mapSize(2)])
    ylim([0 mapSize(1)])
    view(38,24)
    pos = pos + max_v*[1; 1; 0; 0; 0; pi/16];
    drawnow
    F(i) = getframe(gcf);
    hold off
    cla;
end
makeVideo2(F,'3DYawExample') %Make video
