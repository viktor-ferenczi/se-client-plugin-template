/* TODO: Uncomment and understand this patch

using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using HarmonyLib;
using Sandbox.Engine.Physics;
using ClientPlugin.Tools;

namespace ClientPlugin.Patches;

// ReSharper disable once UnusedType.Global
[HarmonyPatch(typeof(MyPhysics))]
public static class MyPhysicsPatch
{
    private static Config Config => Config.Current;
    
    // ReSharper disable once UnusedMember.Local
    [HarmonyTranspiler]
    [HarmonyPatch(nameof(MyPhysics.LoadData))]
    private static IEnumerable<CodeInstruction> LoadDataTranspiler(IEnumerable<CodeInstruction> instructions, MethodBase patchedMethod)
    {
        // Make your patch configurable, but here it needs restarting the game.
        // Alternatively, always patch. But make the functionality configurable inside your logic.
        if (!Config.Toggle)
            return instructions;
        
        // This call will create a .il file next to this patch file with the
        // original IL code of the patched method. Compare that with the modified.
        var il = instructions.ToList();
        il.RecordOriginalCode(patchedMethod);
        
        // You may want to verify whether the game's code has changed on an update.
        // If this fails, then your plugin will fail to load with a clean error
        // message instead of crashing. Then you can look into what changed in the
        // game code and fix your patch in the next version of your plugin.
        // This verification can be disabled by setting this environment variable:
        // `SE_PLUGIN_DISABLE_METHOD_VERIFICATION`
        // This may be required on Linux if Wine/Proton is using Mono, where IL
        // code may differ for some reason. It may also be required if multiple
        // plugins patch the same method, causing the second one loaded to fail
        // the validation.
        il.VerifyCodeHash(patchedMethod, "2bb5480c");

        // Modify the IL code of the method as needed.
        // Make sure to keep the stack balanced and don't delete labels which are still in use.
        var havokThreadCount = Math.Min(16, Environment.ProcessorCount);
        var i = il.FindIndex(ci => ci.opcode == OpCodes.Stloc_0);
        il.Insert(++i, new CodeInstruction(OpCodes.Ldc_I4, havokThreadCount));
        il.Insert(++i, new CodeInstruction(OpCodes.Stloc_0));

        // This call will create a .il file next to this patch file with the
        // modified IL code of the patched method. Compare that with the original.
        il.RecordPatchedCode(patchedMethod);
        return il;
    }
}

*/