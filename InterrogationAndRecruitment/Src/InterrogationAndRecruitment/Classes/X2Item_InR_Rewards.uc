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

class X2Item_InR_Rewards extends X2Item config (InterrogationAndRecruitment);

//create the templates
static function array<X2DataTemplate> CreateTemplates()
{
	local array<X2DataTemplate> Resources;
	
	Resources.AddItem(CreateInterrogation_AdventTrooper_Intel());
	Resources.AddItem(CreateInterrogation_AdventStunlancer_Intel());
	Resources.AddItem(CreateInterrogation_AdventPurifier_Intel());
	Resources.AddItem(CreateInterrogation_AdventShieldbearer_Intel());
	Resources.AddItem(CreateInterrogation_AdventCaptain_Intel());
	Resources.AddItem(CreateInterrogation_AdventPriest_Intel());
	Resources.AddItem(CreateInterrogation_AdventGeneral_Intel());

	Resources.AddItem(CreateInterrogation_Andromedon_Intel());
	Resources.AddItem(CreateInterrogation_Archon_Intel());
	Resources.AddItem(CreateInterrogation_Berserker_Intel());
	Resources.AddItem(CreateInterrogation_Chryssalid_Intel());
	Resources.AddItem(CreateInterrogation_Faceless_Intel());
	Resources.AddItem(CreateInterrogation_Muton_Intel());
	Resources.AddItem(CreateInterrogation_Sectoid_Intel());
	Resources.AddItem(CreateInterrogation_Viper_Intel());
	
	Resources.AddItem(CreateInterrogation_AdventTrooper_FacilityLead());
	Resources.AddItem(CreateInterrogation_AdventStunlancer_FacilityLead());
	Resources.AddItem(CreateInterrogation_AdventPurifier_FacilityLead());
	Resources.AddItem(CreateInterrogation_AdventShieldbearer_FacilityLead());
	Resources.AddItem(CreateInterrogation_AdventCaptain_FacilityLead());
	Resources.AddItem(CreateInterrogation_AdventPriest_FacilityLead());
	Resources.AddItem(CreateInterrogation_AdventGeneral_FacilityLead());

	Resources.AddItem(CreateInterrogation_Andromedon_FacilityLead());
	Resources.AddItem(CreateInterrogation_Archon_FacilityLead());
	Resources.AddItem(CreateInterrogation_Berserker_FacilityLead());
	Resources.AddItem(CreateInterrogation_Chryssalid_FacilityLead());
	Resources.AddItem(CreateInterrogation_Faceless_FacilityLead());
	Resources.AddItem(CreateInterrogation_Muton_FacilityLead());
	Resources.AddItem(CreateInterrogation_Sectoid_FacilityLead());
	Resources.AddItem(CreateInterrogation_Viper_FacilityLead());
	
	return Resources;
}

//*******************************************************************************************
//                                 ADVENT Rewards
//*******************************************************************************************

static function X2DataTemplate CreateInterrogation_AdventTrooper_Intel()
{
	local X2ItemTemplate Template;

	`CREATE_X2TEMPLATE(class'X2ItemTemplate', Template, 'Interrogation_AdventTrooper_Intel');

	Template.strImage = "img:///UILibrary_InR.Interrogation_Images.AdventTrooper_Intel";
	Template.ItemCat = 'resource';
	Template.HideInInventory = true;

	return Template;
}

static function X2DataTemplate CreateInterrogation_AdventStunlancer_Intel()
{
	local X2ItemTemplate Template;

	`CREATE_X2TEMPLATE(class'X2ItemTemplate', Template, 'Interrogation_AdventStunlancer_Intel');

	Template.strImage = "img:///UILibrary_InR.Interrogation_Images.AdventStunlancer_Intel";
	Template.ItemCat = 'resource';
	Template.HideInInventory = true;

	return Template;
}

static function X2DataTemplate CreateInterrogation_AdventPurifier_Intel()
{
	local X2ItemTemplate Template;

	`CREATE_X2TEMPLATE(class'X2ItemTemplate', Template, 'Interrogation_AdventPurifier_Intel');

	Template.strImage = "img:///UILibrary_InR.Interrogation_Images.AdventPurifier_Intel";
	Template.ItemCat = 'resource';
	Template.HideInInventory = true;

	return Template;
}

static function X2DataTemplate CreateInterrogation_AdventShieldbearer_Intel()
{
	local X2ItemTemplate Template;

	`CREATE_X2TEMPLATE(class'X2ItemTemplate', Template, 'Interrogation_AdventShieldbearer_Intel');

	Template.strImage = "img:///UILibrary_InR.Interrogation_Images.AdventShieldbearer_Intel";
	Template.ItemCat = 'resource';
	Template.HideInInventory = true;

	return Template;
}

static function X2DataTemplate CreateInterrogation_AdventCaptain_Intel()
{
	local X2ItemTemplate Template;

	`CREATE_X2TEMPLATE(class'X2ItemTemplate', Template, 'Interrogation_AdventCaptain_Intel');

	Template.strImage = "img:///UILibrary_InR.Interrogation_Images.AdventCaptain_Intel";
	Template.ItemCat = 'resource';
	Template.HideInInventory = true;

	return Template;
}

static function X2DataTemplate CreateInterrogation_AdventPriest_Intel()
{
	local X2ItemTemplate Template;

	`CREATE_X2TEMPLATE(class'X2ItemTemplate', Template, 'Interrogation_AdventPriest_Intel');

	Template.strImage = "img:///UILibrary_InR.Interrogation_Images.AdventPriest_Intel";
	Template.ItemCat = 'resource';
	Template.HideInInventory = true;

	return Template;
}

static function X2DataTemplate CreateInterrogation_AdventGeneral_Intel()
{
	local X2ItemTemplate Template;

	`CREATE_X2TEMPLATE(class'X2ItemTemplate', Template, 'Interrogation_AdventGeneral_Intel');

	Template.strImage = "img:///UILibrary_InR.Interrogation_Images.AdventGeneral_Intel";
	Template.ItemCat = 'resource';
	Template.HideInInventory = true;

	return Template;
}

static function X2DataTemplate CreateInterrogation_AdventTrooper_FacilityLead()
{
	local X2ItemTemplate Template;

	`CREATE_X2TEMPLATE(class'X2ItemTemplate', Template, 'Interrogation_AdventTrooper_FacilityLead');

	Template.strImage = "img:///UILibrary_InR.Interrogation_Images.AdventTrooper_FacilityLead";
	Template.ItemCat = 'resource';
	Template.HideInInventory = true;

	return Template;
}

static function X2DataTemplate CreateInterrogation_AdventStunlancer_FacilityLead()
{
	local X2ItemTemplate Template;

	`CREATE_X2TEMPLATE(class'X2ItemTemplate', Template, 'Interrogation_AdventStunlancer_FacilityLead');

	Template.strImage = "img:///UILibrary_InR.Interrogation_Images.AdventStunlancer_FacilityLead";
	Template.ItemCat = 'resource';
	Template.HideInInventory = true;

	return Template;
}

static function X2DataTemplate CreateInterrogation_AdventPurifier_FacilityLead()
{
	local X2ItemTemplate Template;

	`CREATE_X2TEMPLATE(class'X2ItemTemplate', Template, 'Interrogation_AdventPurifier_FacilityLead');

	Template.strImage = "img:///UILibrary_InR.Interrogation_Images.AdventPurifier_FacilityLead";
	Template.ItemCat = 'resource';
	Template.HideInInventory = true;

	return Template;
}

static function X2DataTemplate CreateInterrogation_AdventShieldbearer_FacilityLead()
{
	local X2ItemTemplate Template;

	`CREATE_X2TEMPLATE(class'X2ItemTemplate', Template, 'Interrogation_AdventShieldbearer_FacilityLead');

	Template.strImage = "img:///UILibrary_InR.Interrogation_Images.AdventShieldbearer_FacilityLead";
	Template.ItemCat = 'resource';
	Template.HideInInventory = true;

	return Template;
}

static function X2DataTemplate CreateInterrogation_AdventCaptain_FacilityLead()
{
	local X2ItemTemplate Template;

	`CREATE_X2TEMPLATE(class'X2ItemTemplate', Template, 'Interrogation_AdventCaptain_FacilityLead');

	Template.strImage = "img:///UILibrary_InR.Interrogation_Images.AdventCaptain_FacilityLead";
	Template.ItemCat = 'resource';
	Template.HideInInventory = true;

	return Template;
}

static function X2DataTemplate CreateInterrogation_AdventPriest_FacilityLead()
{
	local X2ItemTemplate Template;

	`CREATE_X2TEMPLATE(class'X2ItemTemplate', Template, 'Interrogation_AdventPriest_FacilityLead');

	Template.strImage = "img:///UILibrary_InR.Interrogation_Images.AdventPriest_FacilityLead";
	Template.ItemCat = 'resource';
	Template.HideInInventory = true;

	return Template;
}

static function X2DataTemplate CreateInterrogation_AdventGeneral_FacilityLead()
{
	local X2ItemTemplate Template;

	`CREATE_X2TEMPLATE(class'X2ItemTemplate', Template, 'Interrogation_AdventGeneral_FacilityLead');

	Template.strImage = "img:///UILibrary_InR.Interrogation_Images.AdventGeneral_FacilityLead";
	Template.ItemCat = 'resource';
	Template.HideInInventory = true;

	return Template;
}

//*******************************************************************************************
//                                 Alien Rewards
//*******************************************************************************************

static function X2DataTemplate CreateInterrogation_Andromedon_Intel()
{
	local X2ItemTemplate Template;

	`CREATE_X2TEMPLATE(class'X2ItemTemplate', Template, 'Interrogation_Andromedon_Intel');

	Template.strImage = "img:///UILibrary_InR.Interrogation_Images.Andromedon_Intel";
	Template.ItemCat = 'resource';
	Template.HideInInventory = true;

	return Template;
}

static function X2DataTemplate CreateInterrogation_Archon_Intel()
{
	local X2ItemTemplate Template;

	`CREATE_X2TEMPLATE(class'X2ItemTemplate', Template, 'Interrogation_Archon_Intel');

	Template.strImage = "img:///UILibrary_InR.Interrogation_Images.Archon_Intel";
	Template.ItemCat = 'resource';
	Template.HideInInventory = true;

	return Template;
}

static function X2DataTemplate CreateInterrogation_Berserker_Intel()
{
	local X2ItemTemplate Template;

	`CREATE_X2TEMPLATE(class'X2ItemTemplate', Template, 'Interrogation_Berserker_Intel');

	Template.strImage = "img:///UILibrary_InR.Interrogation_Images.Berserker_Intel";
	Template.ItemCat = 'resource';
	Template.HideInInventory = true;

	return Template;
}

static function X2DataTemplate CreateInterrogation_Chryssalid_Intel()
{
	local X2ItemTemplate Template;

	`CREATE_X2TEMPLATE(class'X2ItemTemplate', Template, 'Interrogation_Chryssalid_Intel');

	Template.strImage = "img:///UILibrary_InR.Interrogation_Images.Chryssalid_Intel";
	Template.ItemCat = 'resource';
	Template.HideInInventory = true;

	return Template;
}

static function X2DataTemplate CreateInterrogation_Faceless_Intel()
{
	local X2ItemTemplate Template;

	`CREATE_X2TEMPLATE(class'X2ItemTemplate', Template, 'Interrogation_Faceless_Intel');

	Template.strImage = "img:///UILibrary_InR.Interrogation_Images.Faceless_Intel";
	Template.ItemCat = 'resource';
	Template.HideInInventory = true;

	return Template;
}

static function X2DataTemplate CreateInterrogation_Muton_Intel()
{
	local X2ItemTemplate Template;

	`CREATE_X2TEMPLATE(class'X2ItemTemplate', Template, 'Interrogation_Muton_Intel');

	Template.strImage = "img:///UILibrary_InR.Interrogation_Images.Muton_Intel";
	Template.ItemCat = 'resource';
	Template.HideInInventory = true;

	return Template;
}

static function X2DataTemplate CreateInterrogation_Sectoid_Intel()
{
	local X2ItemTemplate Template;

	`CREATE_X2TEMPLATE(class'X2ItemTemplate', Template, 'Interrogation_Sectoid_Intel');

	Template.strImage = "img:///UILibrary_InR.Interrogation_Images.Sectoid_Intel";
	Template.ItemCat = 'resource';
	Template.HideInInventory = true;

	return Template;
}

static function X2DataTemplate CreateInterrogation_Viper_Intel()
{
	local X2ItemTemplate Template;

	`CREATE_X2TEMPLATE(class'X2ItemTemplate', Template, 'Interrogation_Viper_Intel');

	Template.strImage = "img:///UILibrary_InR.Interrogation_Images.Viper_Intel";
	Template.ItemCat = 'resource';
	Template.HideInInventory = true;

	return Template;
}

static function X2DataTemplate CreateInterrogation_Andromedon_FacilityLead()
{
	local X2ItemTemplate Template;

	`CREATE_X2TEMPLATE(class'X2ItemTemplate', Template, 'Interrogation_Andromedon_FacilityLead');

	Template.strImage = "img:///UILibrary_InR.Interrogation_Images.Andromedon_FacilityLead";
	Template.ItemCat = 'resource';
	Template.HideInInventory = true;

	return Template;
}

static function X2DataTemplate CreateInterrogation_Archon_FacilityLead()
{
	local X2ItemTemplate Template;

	`CREATE_X2TEMPLATE(class'X2ItemTemplate', Template, 'Interrogation_Archon_FacilityLead');

	Template.strImage = "img:///UILibrary_InR.Interrogation_Images.Archon_FacilityLead";
	Template.ItemCat = 'resource';
	Template.HideInInventory = true;

	return Template;
}

static function X2DataTemplate CreateInterrogation_Berserker_FacilityLead()
{
	local X2ItemTemplate Template;

	`CREATE_X2TEMPLATE(class'X2ItemTemplate', Template, 'Interrogation_Berserker_FacilityLead');

	Template.strImage = "img:///UILibrary_InR.Interrogation_Images.Berserker_FacilityLead";
	Template.ItemCat = 'resource';
	Template.HideInInventory = true;

	return Template;
}

static function X2DataTemplate CreateInterrogation_Chryssalid_FacilityLead()
{
	local X2ItemTemplate Template;

	`CREATE_X2TEMPLATE(class'X2ItemTemplate', Template, 'Interrogation_Chryssalid_FacilityLead');

	Template.strImage = "img:///UILibrary_InR.Interrogation_Images.Chryssalid_FacilityLead";
	Template.ItemCat = 'resource';
	Template.HideInInventory = true;

	return Template;
}

static function X2DataTemplate CreateInterrogation_Faceless_FacilityLead()
{
	local X2ItemTemplate Template;

	`CREATE_X2TEMPLATE(class'X2ItemTemplate', Template, 'Interrogation_Faceless_FacilityLead');

	Template.strImage = "img:///UILibrary_InR.Interrogation_Images.Faceless_FacilityLead";
	Template.ItemCat = 'resource';
	Template.HideInInventory = true;

	return Template;
}

static function X2DataTemplate CreateInterrogation_Muton_FacilityLead()
{
	local X2ItemTemplate Template;

	`CREATE_X2TEMPLATE(class'X2ItemTemplate', Template, 'Interrogation_Muton_FacilityLead');

	Template.strImage = "img:///UILibrary_InR.Interrogation_Images.Muton_FacilityLead";
	Template.ItemCat = 'resource';
	Template.HideInInventory = true;

	return Template;
}

static function X2DataTemplate CreateInterrogation_Sectoid_FacilityLead()
{
	local X2ItemTemplate Template;

	`CREATE_X2TEMPLATE(class'X2ItemTemplate', Template, 'Interrogation_Sectoid_FacilityLead');

	Template.strImage = "img:///UILibrary_InR.Interrogation_Images.Sectoid_FacilityLead";
	Template.ItemCat = 'resource';
	Template.HideInInventory = true;

	return Template;
}

static function X2DataTemplate CreateInterrogation_Viper_FacilityLead()
{
	local X2ItemTemplate Template;

	`CREATE_X2TEMPLATE(class'X2ItemTemplate', Template, 'Interrogation_Viper_FacilityLead');

	Template.strImage = "img:///UILibrary_InR.Interrogation_Images.Viper_FacilityLead";
	Template.ItemCat = 'resource';
	Template.HideInInventory = true;

	return Template;
}