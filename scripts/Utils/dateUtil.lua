dateUtil = {};

function dateUtil.buildDate(day, hour, minute)
  local month = 0;
  local year = 2018;

  -- day % 365 to get day number, then use math.floor day / 365 to get how many years to add to 2018
  if day > 365 then
    day = day - 365;
    year = year + 1;
  end;

  if day < 32 then
    month = 1;
  elseif day < 60 then
    month = 2;
  elseif day < 91 then
    month = 3;
  elseif day < 121 then
    month = 4;
  elseif day < 152 then
    month = 5;
  elseif day < 182 then
    month = 6;
  elseif day < 213 then
    month = 7;
  elseif day < 244 then
    month = 8;
  elseif day < 274 then
    month = 9
  elseif day < 305 then
    month = 10;
  elseif day < 335 then
    month = 11;
  else
    month = 12;
  end;

  local date = year .. "-" .. month .. "-" .. day .. " " .. hour .. ":" .. minute;
  return date;
end;
