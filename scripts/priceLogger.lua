priceLogger = {};
priceLogger.shops = {};
priceLogger.crops = {};
priceLogger.dtLogPrices = 0;
priceLogger.dateTime = nil;
priceLogger.firstLoad = true;
priceLogger.currentOperation = nil;
priceLogger.path = g_currentModDirectory;
if priceLogger.path:sub(-1) ~= '/' then
    priceLogger.path = priceLogger.path .. '/';
end;
priceLogger.modName = g_currentModName;

-- Load Source Files
source(priceLogger.path .. 'scripts/Load/shops.lua')
source(priceLogger.path .. 'scripts/Load/crops.lua')
source(priceLogger.path .. 'scripts/Log/logger.lua')
source(priceLogger.path .. 'scripts/Utils/dateUtil.lua')

function priceLogger:loadMap(name)
	print("--- Price Logger loaded ---");
  priceLogger.dtLogPrices = 0;
end;

function priceLogger:deleteMap()
end;

function priceLogger:keyEvent(unicode, sym, modifier, isDown)
end;

function priceLogger:mouseEvent(posX, posY, isDown, isUp, button)
end;

function priceLogger:update(dt)
  if (g_currentMission:getIsServer() and g_dedicatedServerInfo ~= nil) then
  --if true then -- debugging purposes
    if priceLogger.firstLoad then
      shops.load();
      crops.load();
      priceLogger.firstLoad = false;
      g_currentMission.environment:addHourChangeListener(self);
      --g_currentMission.environment:addMinuteChangeListener(self);
      --g_currentMission:setTimeScale(300);
      --DebugUtil.printTableRecursively(g_currentMission.environment, "0", 1,2);
    end;

    priceLogger.dtLogPrices = priceLogger.dtLogPrices + dt;
  	if priceLogger.dtLogPrices >= 60000 then  -- only log prices once every 60 seconds
      crops.update();
      priceLogger.dtLogPrices = 0;

      --priceLogger.currentOperation = "Logging Prices ...";
      --logger:logPrices();
      --priceLogger.currentOperation = nil;
    end;
	end;
end;

function priceLogger:minuteChanged()
  --local secondsF = 1000;
  local minutesF = 1000 * 60;
  local hoursF = minutesF * 60;

  --local secondsM = g_currentMission.environment.dayTime / secondsF;
  local minutesM = g_currentMission.environment.dayTime / minutesF;
  local hoursM = g_currentMission.environment.dayTime / hoursF % 24;

  --local seconds = math.floor(secondsM % 60);
  local minutes = math.floor(minutesM % 60);
  local hours = math.floor(hoursM % 24);
  --local dayTime = g_currentMission.environment:getDayAndDayTime();
  --print(dayTime);
  --DebugUtil.printTableRecursively(g_currentMission.environment, "0", 1,2);
  --print(g_currentMission.environment.currentDay);
  --print(hours);
  --print(minutes);
  --print(seconds);
  --local dt = {year=2018, month=1, day=g_currentMission.environment.currentDay, hour=hours, min=minutes, sec=seconds};
  --print(dt.year .. "-" .. dt.month .. "-" .. dt.day .. " " .. dt.hour .. ":" .. dt.min);
  --print(dateUtil.buildDate(g_currentMission.environment.currentDay, hours, minutes));
end;

function priceLogger:hourChanged()
  local minutesF = 1000 * 60;
  local hoursF = minutesF * 60;
  local hoursM = g_currentMission.environment.dayTime / hoursF % 24;
  local hours = math.floor(hoursM % 24);
  local currentDay = nil;
  if ssEnvironment ~= nil then
    currentDay = ssEnvironment:dayInYear(g_currentMission.environment.currentDay);
  else
    currentDay = g_currentMission.environment.currentDay;
  end;

  priceLogger.dateTime = dateUtil.buildDate(currentDay, hours, 0)
  logger:logPrices();
  --DebugUtil.printTableRecursively(g_currentMission.environment, "0", 1,10);
  --print(g_currentMission.environment.dayTime);
  --local dayMinutes = getTime();
  --local hour = math.floor(dayMinutes / 60);
  --local minutes = math.floor(dayMinutes % 60);
  --print(getTime());
  --print(hour .. ":" .. minutes);
end;

function priceLogger:draw()
		setTextBold(true);
		setTextAlignment(RenderText.ALIGN_CENTER);
		setTextColor(1, 0, 0.8, 1);

    --if priceLogger.currentOperation ~= nil then
    --  renderText(.5, .1, g_currentMission.moneyTextSize, priceLogger.currentOperation);
    --end;
end;



addModEventListener(priceLogger);
