function M1 = updateOccupancyMap3D(z,M0,mapSize)
    % Calculate the probability of being occupied
    prob = zeros(size(z,1),1);
    prob(z(:,4)<1) = 0.14;
    prob(z(:,4)>=1) = 0.86;
    IDx = sub2ind(mapSize,z(:,2)+1,z(:,1)+1,z(:,3)+1);
    if ~isequal(z,zeros(1,4)) %If outside the map, do not update map
        M0(IDx) = prob.*M0(IDx)./(prob.*M0(IDx)+(1-prob).*(1-M0(IDx)));
    end
    M1 = M0;
end
