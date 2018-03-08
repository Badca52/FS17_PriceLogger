logger = {};

logger.file = nil;
logger.fileName = nil;

function logger:logPrices()
  logger.fileName = getUserProfileAppPath() .. "modLogs" .. "/" .. getTimeSec() .. "_" .. "priceLog.log";
  logger.file = io.open(logger.fileName, "w");
  logger.file:write("crop,price", "\n");

  for fillT, info in pairs(priceLogger.crops) do
    if info.price ~= nil then
      logger.file:write(info.crop .. "," .. info.price, "\n");
    end;
  end;

  logger.file:close();
end;
