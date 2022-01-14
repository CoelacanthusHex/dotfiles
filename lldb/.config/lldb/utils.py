import os

def chdir(debugger, args, result, dict):
    """Change the working directory, or cd to ${HOME}."""
    dir = args.strip()
    if dir:
        os.chdir(args)
    else:
        os.chdir(os.path.expanduser('~'))
    print("Current working directory: %s" % os.getcwd())
