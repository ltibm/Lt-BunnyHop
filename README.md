## Installation
1. Download  **lt_bunnyhop.as** and copy to **scripts/plugins** folder.
2. Open your **default_plugins.txt** in **svencoop** folder
  and put in;
```
"plugin"
{
    "name" "Lt - BunnyHop"
    "script" "lt_bunnyhop"
    "concommandns" "lt"
}
```
3. Send command **as_reloadplugins** to server or restart server.

## Commands
- usage **as_command lt.bh_enabled 1**
- **lt.bh_enabled**: 0 or 1, Enable or Disable current plugin (default 1).
- **lt.bh_adminonly**: 0 or 1 BunnyHop admin only (default 0)
- **lt.bh_bhonly** : 0 or 1 Parachute only sbh pysc code only (default 0);