CCVar@ cvar_Enabled;
CCVar@ cvar_AdminOnly;
CCVar@ cvar_BHOnly;
void PluginInit()
{
	g_Module.ScriptInfo.SetAuthor( "Lt." );
	g_Module.ScriptInfo.SetContactInfo( "https://steamcommunity.com/id/ibmlt" );
	g_Hooks.RegisterHook( Hooks::Player::PlayerPreThink, @PlPreThink );
	g_Hooks.RegisterHook( Hooks::Player::PlayerSpawn, @PlayerSpawn );
	@cvar_Enabled = CCVar("bh_enabled", 1, "Enable or Disable BunnyHop", ConCommandFlag::AdminOnly);
	@cvar_AdminOnly = CCVar("bh_adminonly", 0, "Set 1 if only used Admins.", ConCommandFlag::AdminOnly);
	@cvar_BHOnly = CCVar("bh_bhonly", 0, "Set 1 if only used bh values is true", ConCommandFlag::AdminOnly);
}
HookReturnCode PlayerSpawn( CBasePlayer@ pPlayer )
{
	KeyValueBuffer@ nPysc = g_EngineFuncs.GetPhysicsKeyBuffer(pPlayer.edict());
	nPysc.SetValue("sbh", "0");
	return HOOK_CONTINUE;
}
bool PluginAccessible(CBasePlayer@ cPlayer)
{
	if(cvar_Enabled.GetInt() == 0) return false;
	if(cPlayer is null || !cPlayer.IsConnected()) return false;
	if(!cPlayer.IsAlive())
	{
		return false;
	}
	if(cvar_AdminOnly.GetInt() == 1)
	{
		if(g_PlayerFuncs.AdminLevel(@cPlayer) <= 0) return false;
	}
	KeyValueBuffer@ nPysc = g_EngineFuncs.GetPhysicsKeyBuffer(cPlayer.edict());
	if(nPysc.GetValue("sfly") == "1") return false;
	if(cvar_BHOnly.GetInt() == 1)
	{
		string cVal = nPysc.GetValue("sbh");
		if(cVal != "1") return false;
	}
	return true;
}
HookReturnCode PlPreThink(CBasePlayer@ cPlayer, uint& out outvar)
{
	if(!PluginAccessible(cPlayer)) return HOOK_CONTINUE;
	cPlayer.pev.fuser2 = 0.0;
	int player_id = cPlayer.entindex();
	int nbut = cPlayer.pev.button;
	int obut = cPlayer.pev.oldbuttons;
	int uflags = cPlayer.pev.flags;
	if(uflags & FL_WATERJUMP == FL_WATERJUMP)
	{
		return HOOK_CONTINUE;
	}
	if(cPlayer.pev.waterlevel >= 2)
	{
		return HOOK_CONTINUE;
	}
	if((nbut & IN_JUMP) == IN_JUMP && (uflags & FL_ONGROUND == FL_ONGROUND) && (obut & IN_JUMP) == IN_JUMP)
	{
		cPlayer.pev.velocity.z += 320;
		cPlayer.pev.gaitsequence = 6;
		return HOOK_CONTINUE;
	}
	return HOOK_CONTINUE;
}