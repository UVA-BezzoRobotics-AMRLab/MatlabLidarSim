function [zCells,rayPts,obsInRange,endPts] = lidarSim3D(angles,pos,obs,maxRange,resolution,gridSize)
    %Simulate lidar - return cell updates
    %zCells: intermediate lidar points (for plotting) with measured value
    %rayPts: All points tested between robot and max range
    %obsInRange: Obstacles within max lidar range
    %endPts: End of lidarScan - mimics LiDAR return (used for plot shape)
    pos = squeeze(pos);
    rayPts = zeros(maxRange*resolution*size(angles,1),4); 
    endPts = zeros(maxRange*resolution*size(angles,1),3);
    rpCount = 0;
    epCount = 0;
    obsInRange = [];
    x1 = pos(1);
    y1 = pos(2);
    z1 = pos(3);
    anglesH = pos([4,6])'+ [pi/2 0] + angles;
    for i = 1:length(angles)
        x2 = x1+sin(anglesH(i,1))*cos(anglesH(i,2))*maxRange;
        y2 = y1+sin(anglesH(i,1))*sin(anglesH(i,2))*maxRange;
        z2 = z1+cos(anglesH(i,1))*maxRange;
        %Divide ray by resolution to check
        for r = 0:resolution
            u = r/resolution;
            xu = x2*u+x1*(1-u); yu = y2*u+y1*(1-u); zu = z2*u+z1*(1-u);
            x = round(xu);
            y = round(yu);
            z = round(zu);
            obsLogic = any(any(all(bsxfun(@eq,reshape([x,y,z].',1,3,[]),obs),2),3)); %Check if measurement is obstacle
            if 0<=x && x<=gridSize(2)-1 && 0<=y && y<=gridSize(1)-1 && ...
                0<=z && z<= gridSize(3)-1 %Check if measurement is within map
                rpCount = rpCount + 1;
                rayPts(rpCount,:) = [xu yu zu obsLogic];
                if obsLogic
                    obsInRange = [obsInRange; [x,y,z]];
                    epCount = epCount + 1;
                    endPts(epCount,:) = [xu,yu,zu];
                    break
                end
            end
        end
        epCount = epCount + 1;
        endPts(epCount,:) = [xu,yu,zu];
    end
    zCells = unique(round(rayPts),'rows');
    endPts(epCount+1:end,:) = []; rayPts(rpCount+1:end,:) = [];
end