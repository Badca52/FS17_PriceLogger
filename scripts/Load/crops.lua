crops = {};

function crops.load()
  --print "Loading Stored Fruits"

  for i, shop in pairs(priceLogger.shops) do
    for fillType, v in pairs(shop.acceptedFillTypes) do
      if priceLogger.crops[fillType] == nil then
        local cropName = g_i18n:getText(FillUtil.fillTypeIntToName[fillType]);
        priceLogger.crops[fillType] = {};
        priceLogger.crops[fillType].crop = cropName;
        priceLogger.crops[fillType].price = 0;
      end;
    end;
  end;
end;

function crops.update()
  --print "- Updating Crops";

  -- go through the list of fillTypes that sellplaces accept
	for fillT, info in pairs(priceLogger.crops) do

			local bestShop = nil;
			-- go through shops to get prices
			for k, shop in pairs(priceLogger.shops) do

				if shop.acceptedFillTypes[fillT] ~= nil then  -- if shop buys our shit
					if bestShop == nil then
						bestShop = shop;
					end;
					if bestShop.mapHotspot ~= nil then
						if bestShop.mapHotspot.fullViewName ~= nil then
							if bestShop.pricingDynamics ~= nil then
								if bestShop.pricingDynamics[fillT] ~= nil then
										shopPrice = math.floor(shop:getEffectiveFillTypePrice(fillT) * 1000);
										if shopPrice > math.floor(bestShop:getEffectiveFillTypePrice(fillT) * 1000) then
											bestShop = shop;
									end;
								end;
							end;
						end;
					end;
				end;
			end;

      priceLogger.crops[fillT].price = math.floor(bestShop:getEffectiveFillTypePrice(fillT) * 1000);

	end;
end;
