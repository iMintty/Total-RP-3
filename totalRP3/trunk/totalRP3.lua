--[[
	Total RP 3, by Telkostrasz (Kirin Tor - Eu/Fr)
--]]

local Globals = TRP3_GLOBALS;
local Utils = TRP3_UTILS;
local Log = Utils.log;

--*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
-- LOADING SEQUENCE
--*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*

-- Called when TRP3 is loaded.
function Globals.addon:OnInitialize()
	
end

-- Called upon PLAYER_LOGIN after all addons are loaded.
function Globals.addon:OnEnable()
	Log.log("OnEnable() START");
	
	TRP3_Flyway_Patches(); -- Adapt saved variables structures between versions
	TRP3_ModuleManagement_Init();
	TRP3_InitModules();
	
	-- Inits impl
	TRP3_InitConfiguration();
	TRP3_InitLocalization(TRP3_GetConfigValue("Locale"));
	TRP3_InitCommunicationProtocol();
	TRP3_InitProfiles();
	TRP3_InitRegister();
	
	-- Inits UI
	TRP3_UI_PlaceMinimapIcon();
	TRP3_UI_InitToolbar();
	TRP3_UI_InitTargetFrame();
	TRP3_UI_InitMainPage();
	TRP3_UI_InitConfiguration();
	TRP3_UI_InitRegister();
	TRP3_UI_InitPopups();
	
	TRP3_LoadProfile(); -- Load profile
	TRP3_SelectMenu("main_00_player"); -- Select first menu
	print(TRP3_L("GEN_WELCOME_MESSAGE")); -- Welcome \o/
	-- Version \o/
	print(TRP3_L("GEN_WELCOME_VERSION"):format(Globals.version_display));
	TRP3_MainFrameVersionText:SetText(TRP3_L("GEN_VERSION"):format(Globals.version_display));
	
	TRP3_StartModules();
	
	-- Must be called after module start.
	TRP3_Configuration_OnModuleLoaded();
	
	Log.log("OnEnable() DONE");
end