priceLogger = {};
priceLogger.shops = {};
priceLogger.crops = {};
priceLogger.dtLogPrices = 0;
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
  if priceLogger.firstLoad then
    shops.load();
    crops.load();
    priceLogger.firstLoad = false
  end;

  priceLogger.dtLogPrices = priceLogger.dtLogPrices + dt;
	if priceLogger.dtLogPrices >= 60000 then  -- only log prices once every 60 seconds
    crops.update();
    priceLogger.dtLogPrices = 0;

    if (g_currentMission:getIsServer() and g_dedicatedServerInfo ~= nil) then
      --priceLogger.currentOperation = "Logging Prices ...";
      logger:logPrices();
      --priceLogger.currentOperation = nil;
    end;
	end;
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
