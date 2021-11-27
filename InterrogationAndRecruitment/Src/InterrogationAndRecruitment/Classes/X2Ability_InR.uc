//---------------------------------------------------------------------------------------
//  FILE:    X2Ability_RangerAbilitySet.uc
//  AUTHOR:  Timothy Talley  --  03/06/2014
//  PURPOSE: Defines all Ranger Based Class Abilities
//           
//---------------------------------------------------------------------------------------
//  Copyright (c) 2016 Firaxis Games, Inc. All rights reserved.
//---------------------------------------------------------------------------------------
class X2Ability_InR extends X2Ability;

static function array<X2DataTemplate> CreateTemplates()
{
	local array<X2DataTemplate> Templates;
	
	Templates.AddItem(InR_KnockoutStunned());

	return Templates;
}

static function X2AbilityTemplate InR_KnockoutStunned()
{
	local X2AbilityTemplate                			Template;
	local X2AbilityCost_ActionPoints 				ActionPointCost;
	local X2Condition_UnitProperty          		UnitPropertyCondition;
	local X2Condition_CanKnockOutTarget          	CanKOTarget;

	`CREATE_X2ABILITY_TEMPLATE(Template, 'InR_KnockoutStunned');
	Template.AbilitySourceName = 'eAbilitySource_Ability';
	Template.IconImage = "img:///UILibrary_PerkIcons.UIPerk_coupdegrace";
	Template.ShotHUDPriority = class'UIUtilities_Tactical'.const.STABILIZE_PRIORITY;
	Template.Hostility = eHostility_Offensive;
	Template.bLimitTargetIcons = true;
	Template.DisplayTargetHitChance = false;
	Template.bDontDisplayInAbilitySummary = true;
	Template.bDisplayInUITooltip = false;
	Template.eAbilityIconBehaviorHUD = eAbilityIconBehavior_ShowIfAvailable;
	Template.AbilityToHitCalc = default.DeadEye;
	Template.AbilityTargetStyle = new class'X2AbilityTarget_Single';
	Template.AbilityShooterConditions.AddItem(default.LivingShooterProperty);
	Template.AddShooterEffectExclusions();
	
	ActionPointCost = new class'X2AbilityCost_ActionPoints';
	ActionPointCost.iNumPoints = 1;
	ActionPointCost.bConsumeAllPoints = false;
	Template.AbilityCosts.AddItem(ActionPointCost);

	UnitPropertyCondition = new class'X2Condition_UnitProperty';
	UnitPropertyCondition.ExcludeAlive = false;
	UnitPropertyCondition.ExcludeDead = true;
	UnitPropertyCondition.ExcludeRobotic = true;
	UnitPropertyCondition.ExcludeFriendlyToSource = true;
	UnitPropertyCondition.ExcludeHostileToSource = false;
	UnitPropertyCondition.RequireWithinRange = true;
	UnitPropertyCondition.WithinRange = class'X2Ability_CarryUnit'.default.CARRY_UNIT_RANGE;
	Template.AbilityTargetConditions.AddItem(UnitPropertyCondition);

	CanKOTarget = new class'X2Condition_CanKnockOutTarget';
	Template.AbilityTargetConditions.AddItem(CanKOTarget);

	Template.AddTargetEffect(class'X2StatusEffects'.static.CreateUnconsciousStatusEffect());

	Template.AbilityTriggers.AddItem(default.PlayerInputTrigger);

	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;
	Template.BuildVisualizationFn = TypicalAbility_BuildVisualization;

	Template.bShowPostActivation = true;
	Template.bFrameEvenWhenUnitIsHidden = true;
	Template.AbilityConfirmSound = "TacticalUI_ActivateAbility";
	Template.CustomFireAnim = 'FF_Melee';

	return Template;
}
