"""Still garbage, will revisit."""
COMMAND = "help"
HELP_HEADER = "Available commands for Lion:"
HELP_FOOTER = "Get detailed help for any command with `!help command`."
HELP_LIST = (
    ("!users", "display the total user count for this server."),
    ("!poll", "create a new poll."),
    ("!garages", "see the status of UCF parking garages."),
    ("!help", "view this menu."),
)


async def command_help_menu(client, message):
    """"""
    response = HELP_HEADER + "\n"
    for command, description in HELP_LIST:
        response += "**{0}**\n".format(command)
        response += "   {0}\n".format(description)
    response += "\n" + HELP_FOOTER

    await client.send_message(message.channel, response)
