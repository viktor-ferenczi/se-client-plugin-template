using System.Diagnostics.CodeAnalysis;
using HarmonyLib;
using Sandbox.Game.Multiplayer;

namespace ClientPlugin.Patches;

// ReSharper disable once UnusedType.Global
[HarmonyPatch(typeof(MyPlayerCollection))]
[SuppressMessage("ReSharper", "UnusedType.Global")]
[SuppressMessage("ReSharper", "UnusedMember.Global")]
public static class MyPlayerCollectionPatch
{
    private static Config Config => Config.Current;

    [HarmonyPrefix]
    [HarmonyPatch(nameof(MyPlayerCollection.SendDirtyBlockLimits))]
    public static bool SendDirtyBlockLimitsPrefix()
    {
        // Use the config to enable patches corresponding to your plugin's features
        if (!Config.Toggle)
            return true;
            
        // Return false to replace the original method
        // Return true to call the original method
        return true;
    }
}
