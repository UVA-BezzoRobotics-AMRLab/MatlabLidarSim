function [zCells,rayPts,obsInRange,endPts] = lidarSim(angles,pos,obs,maxRange,resolution,gridSize)
    %Simulate lidar - return cell updates
    %zCells: intermediate lidar points (for plotting) with measured value
    %rayPts: All points tested between robot and max range
    %obsInRange: Obstacles within max lidar range
    %endPts: End of lidarScan - mimics robot return (used for plot shape)
    pos = squeeze(pos);
    rayPts = zeros(maxRange*resolution,3); endPts = zeros(maxRange*resolution,2);
    rpCount = 0;
    epCount = 0;
    obsInRange = [];
    x1 = pos(1);
    y1 = pos(2);
    anglesH = pos(3)+angles;
    for i = 1:length(angles)
        x2 = x1+cos(anglesH(i))*maxRange;
        y2 = y1+sin(anglesH(i))*maxRange;
        %Divide ray by resolution to check
        for r = 0:resolution
            u = r/resolution;
            xu = x2*u+x1*(1-u); yu = y2*u+y1*(1-u);
            x = round(xu);
            y = round(yu);
            obsLogic = any(any(all(bsxfun(@eq,reshape([x,y].',1,2,[]),obs),2),3));%Check if measurement is obstacle
            if 0<=x && x<=gridSize(2)-1 && 0<=y && y<=gridSize(1)-1 %Check if measurement is within map
                rpCount = rpCount + 1;
                rayPts(rpCount,:) = [xu yu obsLogic];
                if obsLogic
                    obsInRange = [obsInRange; [x,y]];
                    epCount = epCount + 1;
                    endPts(epCount,:) = [xu,yu];
                    break
                end
            end
        end
        epCount = epCount + 1;
        endPts(epCount,:) = [xu,yu];
    end
    zCells = unique(round(rayPts),'rows');
    endPts(epCount+1:end,:) = []; rayPts(rpCount+1:end,:) = [];
end