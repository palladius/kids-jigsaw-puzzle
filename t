



g3:
   # from here https://docs.google.com/presentation/d/16YNRPXAlMB9Nem-9lNiP-uWKU4ioQCVvKFYrjJKEqw8/edit?slide=id.g37ada5a7fc7_0_3627#slide=id.g37ada5a7fc7_0_3627
  add workspace internall thingy: gemini extensions link /google/src/files/head/depot/google3/devtools/devassist/gemini_cli_for_google/extensions/workspace/
  alias gemini g3: |
      echo "alias gemini='/google/bin/releases/gemini-cli/tools/gemini'" >> ~/.bashrc

extensions:
<<<<<<< HEAD
  Pickle Rick (by Gal Zahavi): gemini extensions install https://github.com/galz10/pickle-rick-extension
  Riccardo (by Riccardo): gemini extensions install https://github.com/palladius/gemini-cli-custom-commands
  Conductor (official): gemini extensions install https://github.com/gemini-cli-extensions/conductor
  Workspace (official): gemini extensions install https://github.com/gemini-cli-extensions/workspace
=======
  pickle rick: gemini extensions install https://github.com/galz10/pickle-rick-extension
  Riccardo: gemini extensions install https://github.com/palladius/gemini-cli-custom-commands
  Conductor: gemini extensions install https://github.com/gemini-cli-extensions/conductor

google3:
    # Link the extension using the full depot path
    go/superpowers-cli: gemini extensions link /google/src/files/head/depot/google3/coresystems/sre/prodai/gemini_cli/superpowers
>>>>>>> a483bd554 ( sobenme)

