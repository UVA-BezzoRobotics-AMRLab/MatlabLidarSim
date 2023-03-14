clc; clear all; close all
%Initialize empty map
mapSize = [100,120];
occMap = zeros(mapSize);
%Initialize obstacles
occMap((4:10),(8:10)) = 1;
[r_o,c_o] = find(occMap);
y_o = r_o; x_o = c_o;
obs = [x_o,y_o];


%Initialize vehicle
pos = [-1;-1;pi/4];
knownMap = ones(mapSize)*0.5; %initialize known map
angles = -pi/4:pi/32:pi/4; %initialize sensor parameters
maxRange = 10; %initialize sensor max range
max_v = 2; max_a = pi/4; %Max linear & angular velocity
for i = 1:100
    %Update known map
    [z,rayPts,obsInRange,endPts] = lidarSim(angles,pos,obs,maxRange,maxRange,mapSize);
    knownMap = updateOccupancyMap(z,knownMap,mapSize);
    hold on
    %Plot occupancy matrix
    imagesc(permute(knownMap,[2 1])); colormap(flipud(bone))
    endPts(end+1,:) = pos(1:2,1)';
    rayShp = patch(endPts(:,1),endPts(:,2),'r','FaceAlpha',0.25,'LineStyle','none');
    %Plot UGV
    plotUGV(pos(1:2)',pos(3),0.6,'r');
    xlim([0 mapSize(1)])
    ylim([0 mapSize(2)])
    pos = pos + max_v*[cos(pos(3)); sin(pos(3)); 0];
    drawnow
    hold off
    cla;
end
