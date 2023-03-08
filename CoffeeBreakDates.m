t1 = datetime(2013,1,1); t2 = datetime(3023,1,1);
dates = (t1:t2)';

year_list = year(dates); month_list = month(dates);
day_list = weekday(dates);  % 1 - Sunday, 3 - Tue, 4 - Wed

years = unique(year_list);
CBdates = zeros(length(dates),1);

for i = 1:length(years)
    y = years(i);
    for m = 1:12
        idx = year_list == y & month_list == m;
        if not(y == 3023)
            wed = find(day_list(idx)==4,1, "first");
            tues = find(day_list(idx)==3,3, "first");
            tue = tues(end);
            monthStartIdx = find(year_list==y & month_list == m,1,"first");
            CBdates(monthStartIdx+wed-1) = 1;
            CBdates(monthStartIdx+tue-1) = 1;
        end
    end
end

CoffeeBreakIdxs = find(CBdates);
CoffeeBreakDist = zeros(length(CoffeeBreakIdxs),1);
CoffeeBreakDist(2:end) = CoffeeBreakIdxs(2:end)-CoffeeBreakIdxs(1:end-1);
CoffeeBreakDist(1) = NaN;
minDist = min(CoffeeBreakDist);
distances = unique(CoffeeBreakDist);
idxMinDist = find(CoffeeBreakDist==minDist);
CoffeeBreakDate = dates(CoffeeBreakIdxs);
CoffeeBreakDateMinDist = dates(CoffeeBreakIdxs(idxMinDist));