# Docker-BotCraft

Dockerized build context for the cross-platform build of StarCraft BroodWar and BWAPI bots. This image ships the following dependencies:

* RapidJSON 1.1
* BWAPI v4.1.2
* BWTA v2.2

## Usage

**1. Install docker**

The build environment is shipped within a docker image. The build process is runnable from any system that supports docker.

**2. Pull the image lionax/docker-botcraft**

This image is based on the dockcross/dockcross-x86 image with commonly used the dependencies already built into the image.

**3. Setup the compiler script**

You receive a compile script by running the command (assuming you are in the bot directory):

```
$ docker run --rm lionax/docker-botcraft > ./compile-bot
$ chmod u+x ./compile-bot
```

This redirects a helper script within the image to the destination provided. Alternatively you can direct the output to `/bin/build-bot` if you want to execute the command in every folder you are in.

**4. Run the compiler script**

Go to the projects root directory and run:

```
$ ./compile-bot cmake -Bbuild -H.
$ ./compile-bot make -Cbuild
```

The first command generates the make project files while the second command build the project into the `build/` directory. The process generates the bot.a and bot.dll library files, which can be used with BWAPI.

Note: *Currently use-less until BWAPI has an cross-compile ready interface for DLL bots - waiting for it's great moment then... :)*