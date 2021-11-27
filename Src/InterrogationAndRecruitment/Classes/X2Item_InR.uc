//---------------------------------------------------------------------------------------
//  FILE:   X2Item_InR.uc                                    
//
//	File created by Losu
//
//	File created	23/10/21    1:15
//	LAST UPDATED    23/10/21    1:15
//
//  Adds Captured unit templates and Interrogation Rewards for this mod's functions
//
//---------------------------------------------------------------------------------------

class X2Item_InR extends X2Item config (InterrogationAndRecruitment);

var config int AdventTrooperCaptiveSellValue, AdventStunlancerCaptiveSellValue, AdventPurifierCaptiveSellValue, AdventShieldbearerCaptiveSellValue, AdventCaptainCaptiveSellValue, AdventPriestCaptiveSellValue, AdventGeneralCaptiveSellValue, AndromedonCaptiveSellValue, ArchonCaptiveSellValue, BerserkerCaptiveSellValue, ChryssalidCaptiveSellValue, FacelessCaptiveSellValue, MutonCaptiveSellValue, SectoidCaptiveSellValue, ViperCaptiveSellValue;

//create the templates
static function array<X2DataTemplate> CreateTemplates()
{
	local array<X2DataTemplate> Resources;
	// Captives
	// ADVENT
	Resources.AddItem(CreateCaptive_InR('InR_Captive_AdventTrooper', "UILibrary_InR.Captive_Images.Captive_AdventTrooper", default.AdventTrooperCaptiveSellValue));
	Resources.AddItem(CreateCaptive_InR('InR_Captive_AdventStunlancer', "UILibrary_InR.Captive_Images.Captive_AdventStunlancer", default.AdventStunlancerCaptiveSellValue));
	Resources.AddItem(CreateCaptive_InR('InR_Captive_AdventPurifier', "UILibrary_InR.Captive_Images.Captive_AdventPurifier", default.AdventPurifierCaptiveSellValue));
	Resources.AddItem(CreateCaptive_InR('InR_Captive_AdventShieldbearer', "UILibrary_InR.Captive_Images.Captive_AdventShieldbearer", default.AdventShieldbearerCaptiveSellValue));
	Resources.AddItem(CreateCaptive_InR('InR_Captive_AdventCaptain', "UILibrary_InR.Captive_Images.Captive_AdventCaptain", default.AdventCaptainCaptiveSellValue));
	Resources.AddItem(CreateCaptive_InR('InR_Captive_AdventPriest', "UILibrary_InR.Captive_Images.Captive_AdventPriest", default.AdventPriestCaptiveSellValue));
	Resources.AddItem(CreateCaptive_InR('InR_Captive_AdventGeneral', "UILibrary_InR.Captive_Images.Captive_AdventGeneral", default.AdventGeneralCaptiveSellValue));

	// Alien
	Resources.AddItem(CreateCaptive_InR('InR_Captive_Andromedon', "UILibrary_InR.Captive_Images.Captive_Andromedon", default.AndromedonCaptiveSellValue));
	Resources.AddItem(CreateCaptive_InR('InR_Captive_Archon', "UILibrary_InR.Captive_Images.Captive_Archon", default.ArchonCaptiveSellValue));
	Resources.AddItem(CreateCaptive_InR('InR_Captive_Berserker', "UILibrary_InR.Captive_Images.Captive_Berserker", default.BerserkerCaptiveSellValue));
	Resources.AddItem(CreateCaptive_InR('InR_Captive_Chryssalid', "UILibrary_InR.Captive_Images.Captive_Chryssalid", default.ChryssalidCaptiveSellValue));
	Resources.AddItem(CreateCaptive_InR('InR_Captive_Faceless', "UILibrary_InR.Captive_Images.Captive_Faceless", default.FacelessCaptiveSellValue));
	Resources.AddItem(CreateCaptive_InR('InR_Captive_Muton', "UILibrary_InR.Captive_Images.Captive_Muton", default.MutonCaptiveSellValue));
	Resources.AddItem(CreateCaptive_InR('InR_Captive_Sectoid', "UILibrary_InR.Captive_Images.Captive_Sectoid", default.SectoidCaptiveSellValue));
	Resources.AddItem(CreateCaptive_InR('InR_Captive_Viper', "UILibrary_InR.Captive_Images.Captive_Viper", default.ViperCaptiveSellValue));

	// Rewards - Intel
	// ADVENT
	Resources.AddItem(CreateReward_InR('Interrogation_AdventTrooper_Intel', "UILibrary_InR.Interrogation_Images.AdventTrooper_Intel"));
	Resources.AddItem(CreateReward_InR('Interrogation_AdventStunlancer_Intel', "UILibrary_InR.Interrogation_Images.AdventStunlancer_Intel"));
	Resources.AddItem(CreateReward_InR('Interrogation_AdventPurifier_Intel', "UILibrary_InR.Interrogation_Images.AdventPurifier_Intel"));
	Resources.AddItem(CreateReward_InR('Interrogation_AdventShieldbearer_Intel', "UILibrary_InR.Interrogation_Images.AdventShieldbearer_Intel"));
	Resources.AddItem(CreateReward_InR('Interrogation_AdventCaptain_Intel', "UILibrary_InR.Interrogation_Images.AdventCaptain_Intel"));
	Resources.AddItem(CreateReward_InR('Interrogation_AdventPriest_Intel', "UILibrary_InR.Interrogation_Images.AdventPriest_Intel"));
	Resources.AddItem(CreateReward_InR('Interrogation_AdventGeneral_Intel', "UILibrary_InR.Interrogation_Images.AdventGeneral_Intel"));

	// Alien
	Resources.AddItem(CreateReward_InR('Interrogation_Andromedon_Intel', "UILibrary_InR.Interrogation_Images.Andromedon_Intel"));
	Resources.AddItem(CreateReward_InR('Interrogation_Archon_Intel', "UILibrary_InR.Interrogation_Images.Archon_Intel"));
	Resources.AddItem(CreateReward_InR('Interrogation_Berserker_Intel', "UILibrary_InR.Interrogation_Images.Berserker_Intel"));
	Resources.AddItem(CreateReward_InR('Interrogation_Chryssalid_Intel', "UILibrary_InR.Interrogation_Images.Chryssalid_Intel"));
	Resources.AddItem(CreateReward_InR('Interrogation_Faceless_Intel', "UILibrary_InR.Interrogation_Images.Faceless_Intel"));
	Resources.AddItem(CreateReward_InR('Interrogation_Muton_Intel', "UILibrary_InR.Interrogation_Images.Muton_Intel"));
	Resources.AddItem(CreateReward_InR('Interrogation_Sectoid_Intel', "UILibrary_InR.Interrogation_Images.Sectoid_Intel"));
	Resources.AddItem(CreateReward_InR('Interrogation_Viper_Intel', "UILibrary_InR.Interrogation_Images.Viper_Intel"));

	// Rewards - Facility Lead
	// ADVENT
	Resources.AddItem(CreateReward_InR('Interrogation_AdventTrooper_FacilityLead', "UILibrary_InR.Interrogation_Images.AdventTrooper_FacilityLead"));
	Resources.AddItem(CreateReward_InR('Interrogation_AdventStunlancer_FacilityLead', "UILibrary_InR.Interrogation_Images.AdventStunlancer_FacilityLead"));
	Resources.AddItem(CreateReward_InR('Interrogation_AdventPurifier_FacilityLead', "UILibrary_InR.Interrogation_Images.AdventPurifier_FacilityLead"));
	Resources.AddItem(CreateReward_InR('Interrogation_AdventShieldbearer_FacilityLead', "UILibrary_InR.Interrogation_Images.AdventShieldbearer_FacilityLead"));
	Resources.AddItem(CreateReward_InR('Interrogation_AdventCaptain_FacilityLead', "UILibrary_InR.Interrogation_Images.AdventCaptain_FacilityLead"));
	Resources.AddItem(CreateReward_InR('Interrogation_AdventPriest_FacilityLead', "UILibrary_InR.Interrogation_Images.AdventPriest_FacilityLead"));
	Resources.AddItem(CreateReward_InR('Interrogation_AdventGeneral_FacilityLead', "UILibrary_InR.Interrogation_Images.AdventGeneral_FacilityLead"));

	// Alien
	Resources.AddItem(CreateReward_InR('Interrogation_Andromedon_FacilityLead', "UILibrary_InR.Interrogation_Images.Andromedon_FacilityLead"));
	Resources.AddItem(CreateReward_InR('Interrogation_Archon_FacilityLead', "UILibrary_InR.Interrogation_Images.Archon_FacilityLead"));
	Resources.AddItem(CreateReward_InR('Interrogation_Berserker_FacilityLead', "UILibrary_InR.Interrogation_Images.Berserker_FacilityLead"));
	Resources.AddItem(CreateReward_InR('Interrogation_Chryssalid_FacilityLead', "UILibrary_InR.Interrogation_Images.Chryssalid_FacilityLead"));
	Resources.AddItem(CreateReward_InR('Interrogation_Faceless_FacilityLead', "UILibrary_InR.Interrogation_Images.Faceless_FacilityLead"));
	Resources.AddItem(CreateReward_InR('Interrogation_Muton_FacilityLead', "UILibrary_InR.Interrogation_Images.Muton_FacilityLead"));
	Resources.AddItem(CreateReward_InR('Interrogation_Sectoid_FacilityLead', "UILibrary_InR.Interrogation_Images.Sectoid_FacilityLead"));
	Resources.AddItem(CreateReward_InR('Interrogation_Viper_FacilityLead', "UILibrary_InR.Interrogation_Images.Viper_FacilityLead"));
	
	return Resources;
}

//*******************************************************************************************
//                                     Templates
//*******************************************************************************************

static function X2DataTemplate CreateCaptive_InR(name TemplateName, string ImagePath, int SellValue)
{
	local X2ItemTemplate Template;

	`CREATE_X2TEMPLATE(class'X2ItemTemplate', Template, TemplateName);

	Template.strImage = "img:///" $ImagePath;
	Template.ItemCat = 'resource';
	Template.TradingPostValue = SellValue;
	Template.MaxQuantity = 1;

	return Template;
}

static function X2DataTemplate CreateReward_InR(name TemplateName, string ImagePath)
{
	local X2ItemTemplate Template;

	`CREATE_X2TEMPLATE(class'X2ItemTemplate', Template, TemplateName);

	Template.strImage = "img:///" $ImagePath;
	Template.ItemCat = 'resource';
	Template.HideInInventory = true;

	return Template;
}