# Space Engineers Client Plugin Template

[Server/Client version of the template](https://github.com/sepluginloader/PluginTemplate)

## Prerequisites

- [Space Engineers](https://store.steampowered.com/app/244850/Space_Engineers/)
- [Python 3.x](https://python.org) (tested with 3.9)
- [Pulsar](https://github.com/SpaceGT/Pulsar)
- [.NET Framework 4.8.1 Developer Pack](https://dotnet.microsoft.com/en-us/download/dotnet-framework/net481)

## Create your plugin project

1. Click on **Use this template** (top right corner on GitHub) and follow the wizard to create your repository
2. Clone your repository to have a local working copy
3. Run `setup.py`, enter the name of your plugin project in `CapitalizedWords` format
4. Let `setup.py` auto-detect your install location or fill it in manually
5. Open the solution in Visual Studio or Rider
6. Make a test build, the plugin's DLL should be deployed (see the build log for the path)
7. Test that the empty plugin can be enabled in Pulsar
8. Replace the contents of this file with the description of your plugin
9. Follow the TODO comments in the source code

In case of questions please feel free to ask the SE plugin developer community on the
[Pulsar](https://discord.gg/z8ZczP2YZY) Discord server in their relevant text channels. 
They also have dedicated channels for plugin ideas, should you look for a new one.

_Good luck!_

## Remarks

### AI assisted plugin development (don't laugh)

Read the `.github\copilot-instructions.md` file for further hints and insight into plugin development.

Use "AI" (Copilot, IDE integrated LLMs) to cut down on typing and to review your code.

__How to set up an AI assisted development environment as of November 2025__
- Install VSCode + Copilot plugin + Cline plugin
- Follow all the installation and configuration instructions
- Pay $100/year for Copilot Plug if you can afford it
- Select GPT-5 for Plan mode and GPT-5-mini for Act mode

You may want to keep the same project open in your usual editor (VS, Rider) for manual editing and debugging and use VSCode only for the AI.

__How to efficiently develop with AI__
- Always Plan first, then Act on the code base
- Give as specific instructions as you can
- Work in small, iterative steps, commit each step once works
- Auto-approve editing files inside the project (you can always revert it)

Expect the best setup and models to evolv rapidly.

Make sure the AI reads the above instructions and the README of your plugin before working on the code, 
otherwise it may be a bit lost.

### Plugin configuration

You can have a nice configuration dialog with little effort in the game client.
Customize the `Config` class in the `ClientPlugin` project, just follow the examples.
It supports many different data types, including key binding. Once you have more
options than can fit on the screen the dialog will have a vertical scrollbar.

![Example config dialog](Doc/ConfigDialogExample.png "Example config dialog")

### Debugging

- Always use a debug build if you want to set breakpoints and see variable values.
- A debug build defines `DEBUG`, so you can add conditional code in `#if DEBUG` blocks.
- While debugging a specific target unload the other two. It prevents the IDE to be confused.
- If breakpoints do not "stick" or do not work, then make sure that:
  - Other projects are unloaded, only the debugged one and Shared are loaded.
  - Debugger is attached to the running process.
  - You are debugging the code which is running (no code changes made since the build).

### Accessing internal, protected and private members in game code

Enable the Krafs publicizer to significantly reduce the amount of reflections you need to write.

This can be done by systematically uncommenting the commented out project file and code sections marked with
"Uncomment to enable publicizer support" in the comments. Make sure not to miss any of those. List the game assemblies
you need to publicize in `GameAssembliesToPublicize.cs`. In case of problems read about the 
[Krafs Publicizer](https://github.com/krafs/Publicizer) or reach out on the [Pulsar](https://discord.gg/z8ZczP2YZY) Discord server.

### Troubleshooting

- If the IDE looks confused, then restarting it and the debugged game usually works.
- If the restart did not work, then try to delete caches used by your IDE and restart.
- If your build cannot deploy (just runs in a loop), then something locks the DLL file.
- Look for running game processes (maybe stuck running in the background) and kill them.

### Release

- Always make your final release from a RELEASE build. (More optimized, removes debug code.)
- Always test your RELEASE build before publishing. Sometimes it behaves differently.
- In case of client plugins the Pulsar compiles your code, watch out for differences.

### Communication

- In your documentation always include how players or server admins should report bugs.
- Try to be reachable and respond on a timely manner over your communication channels.
- Be open for constructive critics.

### Abandoning your project

- Always consider finding a new maintainer, ask around at least once.
- If you ever abandon the project, then make it clear on its GitHub page.
- Abandoned projects should be made hidden on PluginHub and Torch's plugin list.
- Keep the code available on GitHub, so it can be forked and continued by others.
