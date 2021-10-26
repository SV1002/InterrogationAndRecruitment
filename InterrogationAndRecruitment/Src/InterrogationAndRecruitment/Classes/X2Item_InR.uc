//---------------------------------------------------------------------------------------
//  FILE:   X2Item_InR.uc                                    
//
//	File created by Losu
//
//	File created	23/10/21    1:15
//	LAST UPDATED    23/10/21    1:15
//
//  Adds Captured unit templates for this mod's functions
//
//---------------------------------------------------------------------------------------

class X2Item_InR extends X2Item config (InterrogationAndRecruitment);

var config int AdventTrooperCaptiveSellValue;
var config int AdventStunlancerCaptiveSellValue;
var config int AdventPurifierCaptiveSellValue;
var config int AdventShieldbearerCaptiveSellValue;
var config int AdventCaptainCaptiveSellValue;
var config int AdventPriestCaptiveSellValue;
var config int AdventGeneralCaptiveSellValue;

var config int AndromedonCaptiveSellValue;
var config int ArchonCaptiveSellValue;
var config int BerserkerCaptiveSellValue;
var config int ChryssalidCaptiveSellValue;
var config int FacelessCaptiveSellValue;
var config int MutonCaptiveSellValue;
var config int SectoidCaptiveSellValue;
var config int ViperCaptiveSellValue;

//create the templates
static function array<X2DataTemplate> CreateTemplates()
{
	local array<X2DataTemplate> Resources;
	
	Resources.AddItem(CreateCaptive_AdventTrooper());
	Resources.AddItem(CreateCaptive_AdventStunlancer());
	Resources.AddItem(CreateCaptive_AdventPurifier());
	Resources.AddItem(CreateCaptive_AdventShieldbearer());
	Resources.AddItem(CreateCaptive_AdventCaptain());
	Resources.AddItem(CreateCaptive_AdventPriest());
	Resources.AddItem(CreateCaptive_AdventGeneral());
	
	Resources.AddItem(CreateCaptive_Andromedon());
	Resources.AddItem(CreateCaptive_Archon());
	Resources.AddItem(CreateCaptive_Berserker());
	Resources.AddItem(CreateCaptive_Chryssalid());
	Resources.AddItem(CreateCaptive_Faceless());
	Resources.AddItem(CreateCaptive_Muton());
	Resources.AddItem(CreateCaptive_Sectoid());
	Resources.AddItem(CreateCaptive_Viper());
	
	return Resources;
}

//*******************************************************************************************
//                                 ADVENT Captives
//*******************************************************************************************

static function X2DataTemplate CreateCaptive_AdventTrooper()
{
	local X2ItemTemplate Template;

	`CREATE_X2TEMPLATE(class'X2ItemTemplate', Template, 'InR_Captive_AdventTrooper');

	Template.strImage = "img:///UILibrary_InR.Captive_Images.Captive_AdventTrooper";
	Template.ItemCat = 'resource';
	Template.TradingPostValue = default.AdventTrooperCaptiveSellValue;
	Template.MaxQuantity = 1;

	return Template;
}

static function X2DataTemplate CreateCaptive_AdventStunlancer()
{
	local X2ItemTemplate Template;

	`CREATE_X2TEMPLATE(class'X2ItemTemplate', Template, 'InR_Captive_AdventStunlancer');

	Template.strImage = "img:///UILibrary_InR.Captive_Images.Captive_AdventStunlancer";
	Template.ItemCat = 'resource';
	Template.TradingPostValue = default.AdventStunlancerCaptiveSellValue;
	Template.MaxQuantity = 1;

	return Template;
}

static function X2DataTemplate CreateCaptive_AdventShieldbearer()
{
	local X2ItemTemplate Template;

	`CREATE_X2TEMPLATE(class'X2ItemTemplate', Template, 'InR_Captive_AdventShieldbearer');

	Template.strImage = "img:///UILibrary_InR.Captive_Images.Captive_AdventShieldbearer";
	Template.ItemCat = 'resource';
	Template.TradingPostValue = default.AdventShieldbearerCaptiveSellValue;
	Template.MaxQuantity = 1;

	return Template;
}

static function X2DataTemplate CreateCaptive_AdventPurifier()
{
	local X2ItemTemplate Template;

	`CREATE_X2TEMPLATE(class'X2ItemTemplate', Template, 'InR_Captive_AdventPurifier');

	Template.strImage = "img:///UILibrary_InR.Captive_Images.Captive_AdventPurifier";
	Template.ItemCat = 'resource';
	Template.TradingPostValue = default.AdventPurifierCaptiveSellValue;
	Template.MaxQuantity = 1;

	return Template;
}

static function X2DataTemplate CreateCaptive_AdventCaptain()
{
	local X2ItemTemplate Template;

	`CREATE_X2TEMPLATE(class'X2ItemTemplate', Template, 'InR_Captive_AdventCaptain');

	Template.strImage = "img:///UILibrary_InR.Captive_Images.Captive_AdventCaptain";
	Template.ItemCat = 'resource';
	Template.TradingPostValue = default.AdventCaptainCaptiveSellValue;
	Template.MaxQuantity = 1;

	return Template;
}

static function X2DataTemplate CreateCaptive_AdventPriest()
{
	local X2ItemTemplate Template;

	`CREATE_X2TEMPLATE(class'X2ItemTemplate', Template, 'InR_Captive_AdventPriest');

	Template.strImage = "img:///UILibrary_InR.Captive_Images.Captive_AdventPriest";
	Template.ItemCat = 'resource';
	Template.TradingPostValue = default.AdventPriestCaptiveSellValue;
	Template.MaxQuantity = 1;

	return Template;
}

static function X2DataTemplate CreateCaptive_AdventGeneral()
{
	local X2ItemTemplate Template;

	`CREATE_X2TEMPLATE(class'X2ItemTemplate', Template, 'InR_Captive_AdventGeneral');

	Template.strImage = "img:///UILibrary_InR.Captive_Images.Captive_AdventGeneral";
	Template.ItemCat = 'resource';
	Template.TradingPostValue = default.AdventGeneralCaptiveSellValue;
	Template.MaxQuantity = 1;

	return Template;
}

//*******************************************************************************************
//                                 Alien Captives
//*******************************************************************************************

static function X2DataTemplate CreateCaptive_Andromedon()
{
	local X2ItemTemplate Template;

	`CREATE_X2TEMPLATE(class'X2ItemTemplate', Template, 'InR_Captive_Andromedon');

	Template.strImage = "img:///UILibrary_InR.Captive_Images.Captive_Andromedon";
	Template.ItemCat = 'resource';
	Template.TradingPostValue = default.AndromedonCaptiveSellValue;
	Template.MaxQuantity = 1;

	return Template;
}

static function X2DataTemplate CreateCaptive_Archon()
{
	local X2ItemTemplate Template;

	`CREATE_X2TEMPLATE(class'X2ItemTemplate', Template, 'InR_Captive_Archon');

	Template.strImage = "img:///UILibrary_InR.Captive_Images.Captive_Archon";
	Template.ItemCat = 'resource';
	Template.TradingPostValue = default.ArchonCaptiveSellValue;
	Template.MaxQuantity = 1;

	return Template;
}

static function X2DataTemplate CreateCaptive_Berserker()
{
	local X2ItemTemplate Template;

	`CREATE_X2TEMPLATE(class'X2ItemTemplate', Template, 'InR_Captive_Berserker');

	Template.strImage = "img:///UILibrary_InR.Captive_Images.Captive_Berserker";
	Template.ItemCat = 'resource';
	Template.TradingPostValue = default.BerserkerCaptiveSellValue;
	Template.MaxQuantity = 1;

	return Template;
}

static function X2DataTemplate CreateCaptive_Chryssalid()
{
	local X2ItemTemplate Template;

	`CREATE_X2TEMPLATE(class'X2ItemTemplate', Template, 'InR_Captive_Chryssalid');

	Template.strImage = "img:///UILibrary_InR.Captive_Images.Captive_Chryssalid";
	Template.ItemCat = 'resource';
	Template.TradingPostValue = default.ChryssalidCaptiveSellValue;
	Template.MaxQuantity = 1;

	return Template;
}

static function X2DataTemplate CreateCaptive_Faceless()
{
	local X2ItemTemplate Template;

	`CREATE_X2TEMPLATE(class'X2ItemTemplate', Template, 'InR_Captive_Faceless');

	Template.strImage = "img:///UILibrary_InR.Captive_Images.Captive_Faceless";
	Template.ItemCat = 'resource';
	Template.TradingPostValue = default.FacelessCaptiveSellValue;
	Template.MaxQuantity = 1;

	return Template;
}

static function X2DataTemplate CreateCaptive_Muton()
{
	local X2ItemTemplate Template;

	`CREATE_X2TEMPLATE(class'X2ItemTemplate', Template, 'InR_Captive_Muton');

	Template.strImage = "img:///UILibrary_InR.Captive_Images.Captive_Muton";
	Template.ItemCat = 'resource';
	Template.TradingPostValue = default.MutonCaptiveSellValue;
	Template.MaxQuantity = 1;

	return Template;
}

static function X2DataTemplate CreateCaptive_Sectoid()
{
	local X2ItemTemplate Template;

	`CREATE_X2TEMPLATE(class'X2ItemTemplate', Template, 'InR_Captive_Sectoid');

	Template.strImage = "img:///UILibrary_InR.Captive_Images.Captive_Sectoid";
	Template.ItemCat = 'resource';
	Template.TradingPostValue = default.SectoidCaptiveSellValue;
	Template.MaxQuantity = 1;

	return Template;
}

static function X2DataTemplate CreateCaptive_Viper()
{
	local X2ItemTemplate Template;

	`CREATE_X2TEMPLATE(class'X2ItemTemplate', Template, 'InR_Captive_Viper');

	Template.strImage = "img:///UILibrary_InR.Captive_Images.Captive_Viper";
	Template.ItemCat = 'resource';
	Template.TradingPostValue = default.ViperCaptiveSellValue;
	Template.MaxQuantity = 1;

	return Template;
}