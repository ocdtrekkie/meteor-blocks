@0x9e70b064dfed71d3;

using Spk = import "/sandstorm/package.capnp";
# This imports:
#   $SANDSTORM_HOME/latest/usr/include/sandstorm/package.capnp
# Check out that file to see the full, documented package definition format.

const pkgdef :Spk.PackageDefinition = (
  # The package definition. Note that the spk tool looks specifically for the
  # "pkgdef" constant.

  id = "7kszn2vf4a4rhg5vcfmky6pcvc8tdwegwxv0fnjr286g778av3h0",
  # Your app ID is actually its public key. The private key was placed in
  # your keyring. All updates must be signed with the same key.

  manifest = (
    # This manifest is included in your app package to tell Sandstorm
    # about your app.

    appTitle = (defaultText = "Meteor Blocks"),

    appVersion = 3,  # Increment this for every release.

    appMarketingVersion = (defaultText = "1.0.2"),

    actions = [
      # Define your "new document" handlers here.
      ( title = (defaultText = "New Blocks Model"),
        nounPhrase = (defaultText = "model"),
        command = .myCommand
        # The command to run when starting for the first time. (".myCommand"
        # is just a constant defined at the bottom of the file.)
      )
    ],

    continueCommand = .myCommand,
    # This is the command called to start your app back up after it has been
    # shut down for inactivity. Here we're using the same command as for
    # starting a new instance, but you could use different commands for each
    # case.

    metadata = (
       icons = (
         appGrid = (svg = embed "app-graphics/meteorblocks-128.svg"),
         grain = (svg = embed "app-graphics/meteorblocks-24.svg"),
         market = (svg = embed "app-graphics/meteorblocks-150.svg"),
       ),

       website = "https://github.com/ocdtrekkie/meteor-blocks",
       codeUrl = "https://github.com/ocdtrekkie/meteor-blocks",
       license = (openSource = mit),
       categories = [graphics],

       author = (
         contactEmail = "inbox@jacobweisz.com",
         pgpSignature = embed "pgp-signature",
         upstreamAuthor = "Sashko Stubailo",
       ),
       pgpKeyring = embed "pgp-keyring",

       description = (defaultText = embed "description.md"),

       shortDescription = (defaultText = "Voxel editor"),

       screenshots = [
         (width = 448, height = 364, png = embed "sandstorm-screenshot.png")
       ],

       changeLog = (defaultText = embed "CHANGELOG.md"),
    ),
  ),

  sourceMap = (
    # The following directories will be copied into your package.
    searchPath = [
      ( sourcePath = ".meteor-spk/deps" ),
      ( sourcePath = ".meteor-spk/bundle" )
    ]
  ),

  alwaysInclude = [ "." ]
  # This says that we always want to include all files from the source map.
  # (An alternative is to automatically detect dependencies by watching what
  # the app opens while running in dev mode. To see what that looks like,
  # run `spk init` without the -A option.)
);

const myCommand :Spk.Manifest.Command = (
  # Here we define the command used to start up your server.
  argv = ["/sandstorm-http-bridge", "4000", "--", "node", "start.js"],
  environ = [
    # Note that this defines the *entire* environment seen by your app.
    (key = "PATH", value = "/usr/local/bin:/usr/bin:/bin")
  ]
);
