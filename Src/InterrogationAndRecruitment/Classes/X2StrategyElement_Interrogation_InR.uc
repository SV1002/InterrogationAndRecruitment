//*******************************************************************************************
//  FILE:   Interrogation and Recruitment stuff                  
//  
//	File created	23/10/21    1:15
//	LAST UPDATED    23/10/21    1:15
//
//  ADDS ADVENT & Alien Interrogations
// 		a tech needs bProvingGround + "Tech_InR" as the prefix of the template name to show up in the Interrogation Facility
//		or added to the 'bypass' list for UIChooseInRProject .. InterrogationAndRecruitment configs
//		the new techs here won't show up in the proving ground list due to the SpecialRequirementsFn :)
//
//*******************************************************************************************
class X2StrategyElement_Interrogation_InR extends X2StrategyElement_XpackTechs config (InterrogationAndRecruitment);

var config int AdventTrooperInterrogationDays, AdventStunlancerInterrogationDays, AdventPurifierInterrogationDays, AdventShieldbearerInterrogationDays, AdventCaptainInterrogationDays, AdventPriestInterrogationDays, AdventGeneralInterrogationDays, AndromedonInterrogationDays, ArchonInterrogationDays, BerserkerInterrogationDays, ChryssalidInterrogationDays, FacelessInterrogationDays, MutonInterrogationDays, SectoidInterrogationDays, ViperInterrogationDays;

var config int AdventTrooperMinIntel, AdventStunlancerMinIntel, AdventPurifierMinIntel, AdventShieldbearerMinIntel, AdventCaptainMinIntel, AdventPriestMinIntel, AdventGeneralMinIntel, AndromedonMinIntel, ArchonMinIntel, BerserkerMinIntel, ChryssalidMinIntel, FacelessMinIntel, MutonMinIntel, SectoidMinIntel, ViperMinIntel;

var config int AdventTrooperMaxIntel, AdventStunlancerMaxIntel, AdventPurifierMaxIntel, AdventShieldbearerMaxIntel, AdventCaptainMaxIntel, AdventPriestMaxIntel, AdventGeneralMaxIntel, AndromedonMaxIntel, ArchonMaxIntel, BerserkerMaxIntel, ChryssalidMaxIntel, FacelessMaxIntel, MutonMaxIntel, SectoidMaxIntel, ViperMaxIntel;

var config int AdventTrooperFacilityLeadChance, AdventStunlancerFacilityLeadChance, AdventPurifierFacilityLeadChance, AdventShieldbearerFacilityLeadChance, AdventCaptainFacilityLeadChance, AdventPriestFacilityLeadChance, AdventGeneralFacilityLeadChance, AndromedonFacilityLeadChance, ArchonFacilityLeadChance, BerserkerFacilityLeadChance, ChryssalidFacilityLeadChance, FacelessFacilityLeadChance, MutonFacilityLeadChance, SectoidFacilityLeadChance, ViperFacilityLeadChance;

var config bool AdventTrooperGivesCorpse, AdventStunlancerGivesCorpse, AdventPurifierGivesCorpse, AdventShieldbearerGivesCorpse, AdventCaptainGivesCorpse, AdventPriestGivesCorpse, AdventGeneralGivesCorpse, AndromedonGivesCorpse, ArchonGivesCorpse, BerserkerGivesCorpse, ChryssalidGivesCorpse, FacelessGivesCorpse, MutonGivesCorpse, SectoidGivesCorpse, ViperGivesCorpse;

var config bool AdventTrooperGivesAutopsy, AdventStunlancerGivesAutopsy, AdventPurifierGivesAutopsy, AdventShieldbearerGivesAutopsy, AdventCaptainGivesAutopsy, AdventPriestGivesAutopsy, AdventGeneralGivesAutopsy, AndromedonGivesAutopsy, ArchonGivesAutopsy, BerserkerGivesAutopsy, ChryssalidGivesAutopsy, FacelessGivesAutopsy, MutonGivesAutopsy, SectoidGivesAutopsy, ViperGivesAutopsy;

var config bool bSkipPGExclusion;

static function array<X2DataTemplate> CreateTemplates()
{
	local array<X2DataTemplate> Techs;

		// ADVENT
		Techs.AddItem(CreateTech_InR_Interrogation('Tech_InR_Interrogation_AdventTrooper', default.AdventTrooperInterrogationDays, "UILibrary_InR.Interrogation_Images.AdventTrooper", 1, 'InR_Captive_AdventTrooper'));
		Techs.AddItem(CreateTech_InR_Interrogation('Tech_InR_Interrogation_AdventStunlancer', default.AdventStunlancerInterrogationDays, "UILibrary_InR.Interrogation_Images.AdventStunlancer", 1, 'InR_Captive_AdventStunlancer'));
		Techs.AddItem(CreateTech_InR_Interrogation('Tech_InR_Interrogation_AdventPurifier', default.AdventPurifierInterrogationDays, "UILibrary_InR.Interrogation_Images.AdventPurifier", 1, 'InR_Captive_AdventPurifier'));
		Techs.AddItem(CreateTech_InR_Interrogation('Tech_InR_Interrogation_AdventShieldbearer', default.AdventShieldbearerInterrogationDays, "UILibrary_InR.Interrogation_Images.AdventShieldbearer", 1, 'InR_Captive_AdventShieldbearer'));
		Techs.AddItem(CreateTech_InR_Interrogation('Tech_InR_Interrogation_AdventCaptain', default.AdventCaptainInterrogationDays, "UILibrary_InR.Interrogation_Images.AdventCaptain", 1, 'InR_Captive_AdventCaptain'));
		Techs.AddItem(CreateTech_InR_Interrogation('Tech_InR_Interrogation_AdventPriest', default.AdventPriestInterrogationDays, "UILibrary_InR.Interrogation_Images.AdventPriest", 1, 'InR_Captive_AdventPriest'));
		Techs.AddItem(CreateTech_InR_Interrogation('Tech_InR_Interrogation_AdventGeneral', default.AdventGeneralInterrogationDays, "UILibrary_InR.Interrogation_Images.AdventGeneral", 1, 'InR_Captive_AdventGeneral'));
		// Alien
		Techs.AddItem(CreateTech_InR_Interrogation('Tech_InR_Interrogation_Andromedon', default.AndromedonInterrogationDays, "UILibrary_InR.Interrogation_Images.Andromedon", 1, 'InR_Captive_Andromedon'));
		Techs.AddItem(CreateTech_InR_Interrogation('Tech_InR_Interrogation_Archon', default.ArchonInterrogationDays, "UILibrary_InR.Interrogation_Images.Archon", 1, 'InR_Captive_Archon'));
		Techs.AddItem(CreateTech_InR_Interrogation('Tech_InR_Interrogation_Berserker', default.BerserkerInterrogationDays, "UILibrary_InR.Interrogation_Images.Berserker", 1, 'InR_Captive_Berserker'));
		Techs.AddItem(CreateTech_InR_Interrogation('Tech_InR_Interrogation_Chryssalid', default.ChryssalidInterrogationDays, "UILibrary_InR.Interrogation_Images.Chryssalid", 1, 'InR_Captive_Chryssalid'));
		Techs.AddItem(CreateTech_InR_Interrogation('Tech_InR_Interrogation_Faceless', default.FacelessInterrogationDays, "UILibrary_InR.Interrogation_Images.Faceless", 1, 'InR_Captive_Faceless'));
		Techs.AddItem(CreateTech_InR_Interrogation('Tech_InR_Interrogation_Muton', default.MutonInterrogationDays, "UILibrary_InR.Interrogation_Images.Muton", 1, 'InR_Captive_Muton'));
		Techs.AddItem(CreateTech_InR_Interrogation('Tech_InR_Interrogation_Sectoid', default.SectoidInterrogationDays, "UILibrary_InR.Interrogation_Images.Sectoid", 1, 'InR_Captive_Sectoid'));
		Techs.AddItem(CreateTech_InR_Interrogation('Tech_InR_Interrogation_Viper', default.ViperInterrogationDays, "UILibrary_InR.Interrogation_Images.Viper", 1, 'InR_Captive_Viper'));

	return Techs;
}


//*******************************************************************************************
//                                   ADVENT Interrogations
//*******************************************************************************************

static function X2DataTemplate CreateTech_InR_Interrogation(name TemplateName, int iDays, string ImagePath, int Tier, name RequiredItem)
{
    local X2TechTemplate Template;
    local ArtifactCost Resources;

    // It is important to give the prefix "Tech_InR" so that the UIChoose page for the Facility knows what to show :)
    `CREATE_X2TEMPLATE(class'X2TechTemplate', Template, TemplateName);
    Template.PointsToComplete = StafferXDays(1, iDays); //5 days
    Template.strImage = "img:///" $ImagePath; 
    Template.bProvingGround = true;
    Template.bRepeatable = true;
    Template.SortingTier = Tier;

    Template.Requirements.RequiredItems.AddItem(RequiredItem);
    Template.Requirements.bVisibleIfItemsNotMet=false;
    Template.Requirements.SpecialRequirementsFn = AreWeInTheInterrogationFacility;

    
    // Item Rewards
    Template.ResearchCompletedFn = InterrogationTechCompleted;
    
    Resources.ItemTemplateName = RequiredItem;
    Resources.Quantity = 1;
    Template.Cost.ArtifactCosts.AddItem(Resources);

    return Template;
}

//*******************************************************************************************
//*******************************************************************************************

static function InterrogationTechCompleted(XComGameState NewGameState, XComGameState_Tech TechState)
{
    local X2ItemTemplateManager ItemTemplateManager;
    local XComGameState_HeadquartersXCom XComHQ;

    local X2ItemTemplate FacilityLeadItemTemplate, CorpseItemTemplate, IntelItemTemplate, LeadItemTemplate;    
    local int IntelAmount, FacilityLeadRoll, iRandRollChance;
    local bool bGivesAutopsy, bGivesCorpse;
    local name TechName;

    foreach NewGameState.IterateByClassType(class'XComGameState_HeadquartersXCom', XComHQ)    { break; }

    if(XComHQ == none)
    {
        XComHQ = XComGameState_HeadquartersXCom(`XCOMHISTORY.GetSingleGameStateObjectForClass(class'XComGameState_HeadquartersXCom'));
        XComHQ = XComGameState_HeadquartersXCom(NewGameState.ModifyStateObject(class'XComGameState_HeadquartersXCom', XComHQ.ObjectID));
    }
    
    ItemTemplateManager = class'X2ItemTemplateManager'.static.GetItemTemplateManager();
    FacilityLeadItemTemplate = ItemTemplateManager.FindItemTemplate('FacilityLeadItem');
    FacilityLeadRoll = `SYNC_RAND_STATIC(100);

    switch (TechState.GetMyTemplateName())
    {
        case 'Tech_InR_Interrogation_AdventTrooper':
            IntelAmount = default.AdventTrooperMinIntel + `SYNC_RAND_STATIC(default.AdventTrooperMaxIntel - default.AdventTrooperMinIntel + 1);

            IntelItemTemplate = ItemTemplateManager.FindItemTemplate('Interrogation_AdventTrooper_Intel');
            CorpseItemTemplate = ItemTemplateManager.FindItemTemplate('CorpseAdventTrooper');
            LeadItemTemplate = ItemTemplateManager.FindItemTemplate('Interrogation_AdventTrooper_FacilityLead');

            bGivesCorpse = default.AdventTrooperGivesCorpse;
            bGivesAutopsy = default.AdventTrooperGivesAutopsy;
            TechName = 'AutopsyAdventTrooper';
            iRandRollChance = default.AdventTrooperFacilityLeadChance;
        break;

        case 'Tech_InR_Interrogation_AdventStunlancer': 
            IntelAmount = default.AdventStunlancerMinIntel + `SYNC_RAND_STATIC(default.AdventStunlancerMaxIntel - default.AdventStunlancerMinIntel + 1);

            IntelItemTemplate = ItemTemplateManager.FindItemTemplate('Interrogation_AdventStunlancer_Intel');
            CorpseItemTemplate = ItemTemplateManager.FindItemTemplate('CorpseAdventStunlancer');
            LeadItemTemplate = ItemTemplateManager.FindItemTemplate('Interrogation_AdventStunlancer_FacilityLead');

            bGivesCorpse = default.AdventStunlancerGivesCorpse;
            bGivesAutopsy = default.AdventStunlancerGivesAutopsy;
            TechName = 'AutopsyAdventStunlancer';
            iRandRollChance = default.AdventStunlancerFacilityLeadChance;
        break;

        case 'Tech_InR_Interrogation_AdventPurifier': 
            IntelAmount = default.AdventPurifierMinIntel + `SYNC_RAND_STATIC(default.AdventPurifierMaxIntel - default.AdventPurifierMinIntel + 1);

            IntelItemTemplate = ItemTemplateManager.FindItemTemplate('Interrogation_AdventPurifier_Intel');
            CorpseItemTemplate = ItemTemplateManager.FindItemTemplate('CorpseAdventPurifier');
            LeadItemTemplate = ItemTemplateManager.FindItemTemplate('Interrogation_AdventPurifier_FacilityLead');

            bGivesCorpse = default.AdventPurifierGivesCorpse;
            bGivesAutopsy = default.AdventPurifierGivesAutopsy;
            TechName = 'AutopsyAdventPurifier';
            iRandRollChance = default.AdventPurifierFacilityLeadChance;
        break;

        case 'Tech_InR_Interrogation_AdventShieldbearer': 
            IntelAmount = default.AdventShieldbearerMinIntel + `SYNC_RAND_STATIC(default.AdventShieldbearerMaxIntel - default.AdventShieldbearerMinIntel + 1);

            IntelItemTemplate = ItemTemplateManager.FindItemTemplate('Interrogation_AdventShieldbearer_Intel');
            CorpseItemTemplate = ItemTemplateManager.FindItemTemplate('CorpseAdventShieldbearer');
            LeadItemTemplate = ItemTemplateManager.FindItemTemplate('Interrogation_AdventShieldbearer_FacilityLead');

            bGivesCorpse = default.AdventShieldbearerGivesCorpse;
            bGivesAutopsy = default.AdventShieldbearerGivesAutopsy;
            TechName = 'AutopsyAdventShieldbearer';
            iRandRollChance = default.AdventShieldbearerFacilityLeadChance;
        break;

        case 'Tech_InR_Interrogation_AdventCaptain': 
            IntelAmount = default.AdventCaptainMinIntel + `SYNC_RAND_STATIC(default.AdventCaptainMaxIntel - default.AdventCaptainMinIntel + 1);

            IntelItemTemplate = ItemTemplateManager.FindItemTemplate('Interrogation_AdventCaptain_Intel');
            CorpseItemTemplate = ItemTemplateManager.FindItemTemplate('CorpseAdventCaptain');
            LeadItemTemplate = ItemTemplateManager.FindItemTemplate('Interrogation_AdventCaptain_FacilityLead');

            bGivesCorpse = default.AdventCaptainGivesCorpse;
            bGivesAutopsy = default.AdventCaptainGivesAutopsy;
            TechName = 'AutopsyAdventCaptain';
            iRandRollChance = default.AdventCaptainFacilityLeadChance;
        break;

        case 'Tech_InR_Interrogation_AdventPriest': 
            IntelAmount = default.AdventPriestMinIntel + `SYNC_RAND_STATIC(default.AdventPriestMaxIntel - default.AdventPriestMinIntel + 1);

            IntelItemTemplate = ItemTemplateManager.FindItemTemplate('Interrogation_AdventPriest_Intel');
            CorpseItemTemplate = ItemTemplateManager.FindItemTemplate('CorpseAdventPriest');
            LeadItemTemplate = ItemTemplateManager.FindItemTemplate('Interrogation_AdventPriest_FacilityLead');

            bGivesCorpse = default.AdventPriestGivesCorpse;
            bGivesAutopsy = default.AdventPriestGivesAutopsy;
            TechName = 'AutopsyAdventPriest';
            iRandRollChance = default.AdventPriestFacilityLeadChance;
        break;

        case 'Tech_InR_Interrogation_AdventGeneral': 
            IntelAmount = default.AdventGeneralMinIntel + `SYNC_RAND_STATIC(default.AdventGeneralMaxIntel - default.AdventGeneralMinIntel + 1);

            IntelItemTemplate = ItemTemplateManager.FindItemTemplate('Interrogation_AdventGeneral_Intel');
            CorpseItemTemplate = ItemTemplateManager.FindItemTemplate('CorpseAdventGeneral');
            LeadItemTemplate = ItemTemplateManager.FindItemTemplate('Interrogation_AdventGeneral_FacilityLead');

            bGivesCorpse = default.AdventGeneralGivesCorpse;
            bGivesAutopsy = default.AdventGeneralGivesAutopsy;
            TechName = 'AutopsyAdventGeneral';
            iRandRollChance = default.AdventGeneralFacilityLeadChance;
        break;

        case 'Tech_InR_Interrogation_Andromedon': 
            IntelAmount = default.AndromedonMinIntel + `SYNC_RAND_STATIC(default.AndromedonMaxIntel - default.AndromedonMinIntel + 1);

            IntelItemTemplate = ItemTemplateManager.FindItemTemplate('Interrogation_Andromedon_Intel');
            CorpseItemTemplate = ItemTemplateManager.FindItemTemplate('CorpseAndromedon');
            LeadItemTemplate = ItemTemplateManager.FindItemTemplate('Interrogation_Andromedon_FacilityLead');

            bGivesCorpse = default.AndromedonGivesCorpse;
            bGivesAutopsy = default.AndromedonGivesAutopsy;
            TechName = 'AutopsyAndromedon';
            iRandRollChance = default.AndromedonFacilityLeadChance;
        break;

        case 'Tech_InR_Interrogation_Archon': 
            IntelAmount = default.ArchonMinIntel + `SYNC_RAND_STATIC(default.ArchonMaxIntel - default.ArchonMinIntel + 1);

            IntelItemTemplate = ItemTemplateManager.FindItemTemplate('Interrogation_Archon_Intel');
            CorpseItemTemplate = ItemTemplateManager.FindItemTemplate('CorpseArchon');
            LeadItemTemplate = ItemTemplateManager.FindItemTemplate('Interrogation_Archon_FacilityLead');

            bGivesCorpse = default.ArchonGivesCorpse;
            bGivesAutopsy = default.ArchonGivesAutopsy;
            TechName = 'AutopsyArchon';
            iRandRollChance = default.ArchonFacilityLeadChance;
        break;

        case 'Tech_InR_Interrogation_Berserker': 
            IntelAmount = default.BerserkerMinIntel + `SYNC_RAND_STATIC(default.BerserkerMaxIntel - default.BerserkerMinIntel + 1);

            IntelItemTemplate = ItemTemplateManager.FindItemTemplate('Interrogation_Berserker_Intel');
            CorpseItemTemplate = ItemTemplateManager.FindItemTemplate('CorpseBerserker');
            LeadItemTemplate = ItemTemplateManager.FindItemTemplate('Interrogation_Berserker_FacilityLead');

            bGivesCorpse = default.BerserkerGivesCorpse;
            bGivesAutopsy = default.BerserkerGivesAutopsy;
            TechName = 'AutopsyBerserker';
            iRandRollChance = default.BerserkerFacilityLeadChance;
        break;

        case 'Tech_InR_Interrogation_Chryssalid': 
            IntelAmount = default.ChryssalidMinIntel + `SYNC_RAND_STATIC(default.ChryssalidMaxIntel - default.ChryssalidMinIntel + 1);

            IntelItemTemplate = ItemTemplateManager.FindItemTemplate('Interrogation_Chryssalid_Intel');
            CorpseItemTemplate = ItemTemplateManager.FindItemTemplate('CorpseChryssalid');
            LeadItemTemplate = ItemTemplateManager.FindItemTemplate('Interrogation_Chryssalid_FacilityLead');

            bGivesCorpse = default.ChryssalidGivesCorpse;
            bGivesAutopsy = default.ChryssalidGivesAutopsy;
            TechName = 'AutopsyChryssalid';
            iRandRollChance = default.ChryssalidFacilityLeadChance;
        break;

        case 'Tech_InR_Interrogation_Faceless': 
            IntelAmount = default.FacelessMinIntel + `SYNC_RAND_STATIC(default.FacelessMaxIntel - default.FacelessMinIntel + 1);

            IntelItemTemplate = ItemTemplateManager.FindItemTemplate('Interrogation_Faceless_Intel');
            CorpseItemTemplate = ItemTemplateManager.FindItemTemplate('CorpseFaceless');
            LeadItemTemplate = ItemTemplateManager.FindItemTemplate('Interrogation_Faceless_FacilityLead');

            bGivesCorpse = default.FacelessGivesCorpse;
            bGivesAutopsy = default.FacelessGivesAutopsy;
            TechName = 'AutopsyFaceless';
            iRandRollChance = default.FacelessFacilityLeadChance;
        break;

        case 'Tech_InR_Interrogation_Muton': 
            IntelAmount = default.MutonMinIntel + `SYNC_RAND_STATIC(default.MutonMaxIntel - default.MutonMinIntel + 1);

            IntelItemTemplate = ItemTemplateManager.FindItemTemplate('Interrogation_Muton_Intel');
            CorpseItemTemplate = ItemTemplateManager.FindItemTemplate('CorpseMuton');
            LeadItemTemplate = ItemTemplateManager.FindItemTemplate('Interrogation_Muton_FacilityLead');

            bGivesCorpse = default.MutonGivesCorpse;
            bGivesAutopsy = default.MutonGivesAutopsy;
            TechName = 'AutopsyMuton';
            iRandRollChance = default.MutonFacilityLeadChance;
        break;

        case 'Tech_InR_Interrogation_Sectoid': 
            IntelAmount = default.SectoidMinIntel + `SYNC_RAND_STATIC(default.SectoidMaxIntel - default.SectoidMinIntel + 1);

            IntelItemTemplate = ItemTemplateManager.FindItemTemplate('Interrogation_Sectoid_Intel');
            CorpseItemTemplate = ItemTemplateManager.FindItemTemplate('CorpseSectoid');
            LeadItemTemplate = ItemTemplateManager.FindItemTemplate('Interrogation_Sectoid_FacilityLead');

            bGivesCorpse = default.SectoidGivesCorpse;
            bGivesAutopsy = default.SectoidGivesAutopsy;
            TechName = 'AutopsySectoid';
            iRandRollChance = default.SectoidFacilityLeadChance;
        break;

        case 'Tech_InR_Interrogation_Viper': 
            IntelAmount = default.ViperMinIntel + `SYNC_RAND_STATIC(default.ViperMaxIntel - default.ViperMinIntel + 1);

            IntelItemTemplate = ItemTemplateManager.FindItemTemplate('Interrogation_Viper_Intel');
            CorpseItemTemplate = ItemTemplateManager.FindItemTemplate('CorpseViper');
            LeadItemTemplate = ItemTemplateManager.FindItemTemplate('Interrogation_Viper_FacilityLead');

            bGivesCorpse = default.ViperGivesCorpse;
            bGivesAutopsy = default.ViperGivesAutopsy;
            TechName = 'AutopsyViper';
            iRandRollChance = default.ViperFacilityLeadChance;
        break;

        default:
        break;
    }

    if (bGivesCorpse)
    {
        class'XComGameState_HeadquartersXCom'.static.GiveItem(NewGameState, CorpseItemTemplate);
    }

    if (FacilityLeadRoll < iRandRollChance)
    {
        GiveInterrogationItemReward(NewGameState, TechState, LeadItemTemplate);
        class'XComGameState_HeadquartersXCom'.static.GiveItem(NewGameState, FacilityLeadItemTemplate);
    }
    else if (IntelItemTemplate != none)
    {
        GiveInterrogationItemReward(NewGameState, TechState, IntelItemTemplate);
    }

    TechState.IntelReward = IntelAmount;
    XComHQ.AddResource(NewGameState, 'Intel', IntelAmount);

    // May have redundant code, or can be optimised more...
    if (bGivesAutopsy)
    {
        foreach `XCOMHISTORY.IterateByClassType(class'XComGameState_Tech', TechState)
        {
            if(TechState.GetMyTemplateName() == TechName && !`XCOMHQ.IsTechResearched(TechName) && `XCOMHQ.IsTechResearched('AlienBiotech'))
            {
                NewGameState = class'XComGameStateContext_ChangeContainer'.static.CreateChangeState("Giving Autopsy Tech from Interrogation");
                TechState = XComGameState_Tech(NewGameState.ModifyStateObject(class'XComGameState_Tech', TechState.ObjectID));
                TechState.TimesResearched++;
                XComHQ.TechsResearched.AddItem(TechState.GetReference());
                TechState.bSeenResearchCompleteScreen = true;

                if(TechState.GetMyTemplate().ResearchCompletedFn != none)
                {
                    TechState.GetMyTemplate().ResearchCompletedFn(NewGameState, TechState);
                }

                `XEVENTMGR.TriggerEvent('ResearchCompleted', TechState, TechState, NewGameState);

                `XCOMGAME.GameRuleset.SubmitGameState(NewGameState);
            break;
            }
        }
    }
}

private static function GiveInterrogationItemReward(XComGameState NewGameState, XComGameState_Tech TechState, X2ItemTemplate ItemTemplate)
{	
	class'XComGameState_HeadquartersXCom'.static.GiveItem(NewGameState, ItemTemplate);

	TechState.ItemRewards.Length = 0; // Reset the item rewards array in case the tech is repeatable
	TechState.ItemRewards.AddItem(ItemTemplate); // Needed for UI Alert display info
	TechState.bSeenResearchCompleteScreen = false; // Reset the research report for techs that are repeatable
}


//helper func            
//Template.Requirements.SpecialRequirementsFn = AreWeInTheInterrogationFacility;
static function bool AreWeInTheInterrogationFacility()
{
    if(default.bSkipPGExclusion)
    {
        return true;
    }

    //if the screen is not in the stack, assume we're not in the INTERROGATION facility but inside the Proving Ground
    if (`HQPRES.ScreenStack.IsNotInStack(class'UIChooseInRProject'))
    {
        return false;
    }

    return true;
}