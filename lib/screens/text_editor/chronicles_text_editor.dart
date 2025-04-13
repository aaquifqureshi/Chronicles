/*
* File Name        : chronicles_text_editor.dart
* Group            : trOlsz Group
* Description      : This file contains code for our text editor where
*                    users can write their journey as diaries, read diaries,
*                    modify diaries and delete them.
*/

import 'package:chronicles/services/file_database.dart';
import 'package:chronicles/utilities/components/buttons/galactic_ocean_button.dart';
import 'package:chronicles/utilities/components/floating_action_button/text_editor_fab.dart';
import 'package:chronicles/utilities/components/text_editor/editor_textbox.dart';
import 'package:flutter/material.dart';
import 'package:chronicles/utilities/components/date_time/chronicles_date_time.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:chronicles/services/file_manager.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../utilities/components/alerts/text_editor_alerts.dart';
import '../../utilities/components/text_editor/reaction_type_data.dart';

String noSaveLeaveMessage = "You are leaving this editor without saving...";

final titleTextStyle = TextStyle(
  color: Color(0xFF1F1F1F),
  fontFamily: 'Hind',
  fontWeight: FontWeight.w500,
  fontSize: 22.0,
);

TextStyle emojiTextStyle = TextStyle(
  fontFamily: 'Hind',
  fontSize: 14.0,
  fontWeight: FontWeight.w400,
);

class TextEditor extends StatefulWidget {
  String? fileName;
  int? milliSinceEpoch;
  bool? isModify;

  TextEditor({super.key, this.fileName, this.isModify});

  @override
  State<TextEditor> createState() => _TextEditorState();
}

class _TextEditorState extends State<TextEditor> {
  List<TextEditingController> controllers = [];
  List<TextEditingController> noEditController = [];
  TextEditingController noEditTitleController = TextEditingController();

  List<bool> editModes = [];
  TextEditingController titleController = TextEditingController();

  final FileDatabase _fileDB = FileDatabase.instance;

  String createdAt = '';
  String modifiedAt = '';
  ReactionType reactionType = ReactionType.none;

  late ChroniclesDateTime nowTime;

  FlutterTts flutterTts = FlutterTts();
  TextEditingController ttsController = TextEditingController();
  List<dynamic> languages = [];
  String? selectedLanguage;
  List<Map> voices = [];
  Object? selectedVoice;
  bool isPlaying = false;
  int ttsIndex = 0;

  final SpeechToText flutterStt = SpeechToText();
  bool speechEnabled = false;
  TextEditingController sttController = TextEditingController();

  bool hasUnsavedChanged() {
    if (noEditTitleController.text != titleController.text) {
      return true;
    }
    if (noEditController.length != controllers.length) {
      return true;
    }

    for (int i = 0; i < controllers.length; i++) {
      if (noEditController[i].text != controllers[i].text) {
        return true;
      }
    }

    return false;
  }

  void noSaveClose() {
    if (hasUnsavedChanged()) {
      saveAlert(
        context,
        message: noSaveLeaveMessage,
        onPressExit: () {
          Navigator.pushNamedAndRemoveUntil(
            context,
            '/Dashboard',
            (Route<dynamic> route) => false,
          );
        },
        onPressSave: () {
          _saveFile();
          Navigator.pushNamedAndRemoveUntil(
            context,
            '/Dashboard',
            (Route<dynamic> route) => false,
          );
        },
      );
    } else {
      Navigator.pushNamedAndRemoveUntil(
        context,
        '/Dashboard',
        (Route<dynamic> route) => false,
      );
    }
  }

  void _saveFileToDB({
    required int milliSinceEpoch,
    required String title,
    required String content,
    required String lastModified,
    required String createdAt,
    required String reactionType,
  }) {
    RegExp exp = RegExp(r'!\[([^\]]*)\]\(([^)]+)\)');
    bool isImage = exp.hasMatch(content);
    RegExpMatch? match;

    if (isImage) {
      match = exp.firstMatch(content);
      if (match != null && match.groupCount >= 1) {
        if (match.group(1) != 'Type Image Description Here') {
          content = 'Image Desc: ${match.group(1)!}';
        } else {
          content = 'Image: No Description';
        }
      }
    }

    if (title == '') {
      title = createdAt;
    }
    _fileDB.saveFileToDatabase(
      fileNameInMillisSinceEpoch: milliSinceEpoch,
      title: title,
      content: content,
      lastModified: lastModified,
      createdAt: createdAt,
      reactionType: reactionType,
    );
  }

  void _updateFileToDB({
    required int milliSinceEpoch,
    required String title,
    required String content,
    required String lastModified,
    required String reactionType,
  }) {
    RegExp exp = RegExp(r'!\[([^\]]*)\]\(([^)]+)\)');
    bool isImage = exp.hasMatch(content);
    RegExpMatch? match;

    if (isImage) {
      match = exp.firstMatch(content);
      if (match != null && match.groupCount >= 1) {
        if (match.group(1) != 'Type Image Description Here') {
          content = 'Image Desc: ${match.group(1)!}';
        } else {
          content = 'Image: No Description';
        }
      }
    }

    if (title == '') {
      title = createdAt;
    }

    _fileDB.updateFile(
      id: milliSinceEpoch,
      title: title,
      content: content,
      modifiedAt: lastModified,
      reactionType: reactionType,
    );
  }

  void _deleteFileToDB({required int milliSinceEpoch}) {
    _fileDB.deleteFile(milliSinceEpoch);
  }

  void _onReorder(int oldIndex, int newIndex) {
    setState(() {
      if (newIndex > oldIndex) {
        newIndex -= 1;
      }
      final TextEditingController controller = controllers.removeAt(oldIndex);
      final bool editMode = editModes.removeAt(oldIndex);
      controllers.insert(newIndex, controller);
      editModes.insert(newIndex, editMode);
    });
  }

  void _insertController() {
    setState(() {
      controllers.add(TextEditingController());
      editModes.add(true);
    });
  }

  void _insertImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    int imageMilliSinceEpoch = DateTime.now().millisecondsSinceEpoch;
    String imagePath = await FileManager.saveImageFile(
      filename: widget.fileName!,
      image: image!,
      imageName: '$imageMilliSinceEpoch.${image.name.split('.').last}',
    );
    setState(() {
      controllers.add(
        TextEditingController(
            text: '![Type Image Description Here]($imagePath)'),
      );
      editModes.add(false);
    });
  }

  void _deleteController(int index) {
    setState(() {
      controllers.removeAt(index);
      editModes.removeAt(index);
    });
  }

  void _toggleEditMode(int index) {
    setState(() {
      editModes[index] = !editModes[index];

      if (index > 0) {
        _removeController();
      }
    });
  }

  void _removeController() {
    setState(() {
      for (int i = 0; i < controllers.length; i++) {
        if (controllers[i].text.isEmpty) {
          _deleteController(i);
        }
      }
    });
  }

  void _saveFile() {
    setState(() {
      if (widget.isModify == false) {
        _saveFileToDB(
          milliSinceEpoch: nowTime.getMilliSecondSinceEpoch(),
          title: titleController.text,
          content: controllers[0].text,
          lastModified: modifiedAt,
          createdAt: createdAt,
          reactionType: reactionType.toString(),
        );
        FileManager.saveFileAsJson(
          title: titleController.text,
          createDate: createdAt,
          modifyDate: modifiedAt,
          controller: controllers,
          milliSinceEpoch: nowTime.getMilliSecondSinceEpoch(),
          reactionType: reactionType.toString(),
        );
      } else if (widget.fileName != null && widget.isModify == true) {
        int milliSinceEpoch =
            int.parse(widget.fileName!.replaceAll('.json', ''));
        _updateFileToDB(
          milliSinceEpoch: milliSinceEpoch,
          title: titleController.text,
          content: controllers[0].text.length >= 25
              ? controllers[0].text.substring(0, 25)
              : controllers[0].text,
          lastModified: modifiedAt,
          reactionType: reactionType.toString(),
        );

        FileManager.modifyJsonFile(
          fileName: widget.fileName!,
          title: titleController.text,
          createDate: createdAt,
          modifyDate: modifiedAt,
          controller: controllers,
          reactionType: reactionType.toString(),
        );
      }
    });
  }

  void _loadFile(String fileName) {
    setState(() {
      FileManager.loadJsonFile(fileName).then((fileData) {
        if (fileData != null) {
          setState(() {
            titleController.text = fileData['title'];
            createdAt = fileData['createdAt'];
            modifiedAt = fileData['modifiedAt'];
            if (fileData['reaction'] != null) {
              reactionType = ReactionType.values.firstWhere(
                (element) => element.toString() == fileData['reaction'],
                orElse: () => ReactionType.none,
              );
            } else {
              reactionType = ReactionType.none;
            }
            controllers = List.generate(
              fileData['controllers'].length,
              (index) => TextEditingController(
                text: fileData['controllers'][index],
              ),
            );
            for (int i = 0; i < controllers.length; i++) {
              noEditController
                  .add(TextEditingController(text: controllers[i].text));
            }
            noEditTitleController.text = titleController.text;
            editModes = List.generate(controllers.length, (index) => false);
          });
        }
      });
    });
  }

  void _deleteFile() {
    setState(() {
      int milliSinceEpoch = int.parse(widget.fileName!.split('.').first);
      _deleteFileToDB(milliSinceEpoch: milliSinceEpoch);
      FileManager.deleteJsonFile(fileName: widget.fileName!);
    });
  }

  void reactionFunction() {
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            backgroundColor: Color(0xFFf1f1f1),
            insetPadding: EdgeInsets.symmetric(
              horizontal: 80,
              vertical: 240,
            ),
            child: SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          reactionType = ReactionType.crying;
                        });
                        Navigator.pop(context);
                      },
                      child: ListTile(
                        leading: SvgPicture.asset(
                          "assets/images/icons/reaction/crying.svg",
                          semanticsLabel: 'Crying Logo',
                        ),
                        title: Text(
                          'Crying!',
                          style: emojiTextStyle,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          reactionType = ReactionType.sad;
                        });
                        Navigator.pop(context);
                      },
                      child: ListTile(
                        leading: SvgPicture.asset(
                          "assets/images/icons/reaction/sad.svg",
                          semanticsLabel: 'Sad Logo',
                        ),
                        title: Text(
                          'Sad!',
                          style: emojiTextStyle,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          reactionType = ReactionType.noSadNoHappy;
                        });
                        Navigator.pop(context);
                      },
                      child: ListTile(
                        leading: SvgPicture.asset(
                          "assets/images/icons/reaction/normal.svg",
                          semanticsLabel: 'normal Logo',
                        ),
                        title: Text(
                          'Ah No Expressions...!',
                          style: emojiTextStyle,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          reactionType = ReactionType.smile;
                        });
                        Navigator.pop(context);
                      },
                      child: ListTile(
                        leading: SvgPicture.asset(
                          "assets/images/icons/reaction/smile.svg",
                          semanticsLabel: 'Smile Logo',
                        ),
                        title: Text(
                          'Smile Please!',
                          style: emojiTextStyle,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          reactionType = ReactionType.happy;
                        });
                        Navigator.pop(context);
                      },
                      child: ListTile(
                        leading: SvgPicture.asset(
                          "assets/images/icons/reaction/happy.svg",
                          semanticsLabel: 'Happy Logo',
                        ),
                        title: Text('Show Teeth!'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  Future<void> loadLanguages() async {
    languages = await flutterTts.getLanguages;

    setState(() {
      selectedLanguage = null;
    });
  }

  Future<void> loadVoices() async {
    List<dynamic> rawVoices = await flutterTts.getVoices;
    voices = rawVoices.whereType<Map<dynamic, dynamic>>().toList();

    setState(() {
      selectedVoice = null;
    });
  }

  Future<void> playTts(StateSetter setStateDialog) async {
    while (ttsIndex < controllers.length && isPlaying) {
      TextEditingController imageController = TextEditingController();
      RegExp exp = RegExp(r'!\[([^\]]*)\]\(([^)]+)\)');
      bool isImage = exp.hasMatch(controllers[ttsIndex].text);
      RegExpMatch? match;

      if (isImage) {
        match = exp.firstMatch(controllers[ttsIndex].text);
        if (match != null && match.groupCount >= 1) {
          imageController.text = 'IMAGE: ${match.group(1)!}';

          setState(() {
            ttsController.text = imageController.text;
          });
          setStateDialog(() {
            ttsController.text = imageController.text;
          });
          ttsController.text = imageController.text;
        }
      } else {
        setState(() {
          ttsController.text = controllers[ttsIndex].text;
        });

        setStateDialog(() {
          ttsController.text = controllers[ttsIndex].text;
        });
      }

      try {
        int value = await flutterTts.speak(ttsController.text);
        await flutterTts.awaitSpeakCompletion(true);

        if (value == 1) {
          setStateDialog(() {
            ttsIndex++;
          });
        }
      } catch (e) {
        print("Speaking problem $e");
      }
    }
    if (isPlaying) {
      ttsController.text = 'YOUR CHRONICLES HAS SPOKEN, YOU CAN REPLAY IT...';
      await flutterTts.speak(ttsController.text);
    }
  }

  Future<void> pauseTts() async {
    setState(() {
      isPlaying = false;
    });

    await flutterTts.pause();
  }

  Future<void> ttsFunction() async {
    await loadLanguages();
    await loadVoices();

    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Color(0xFFFFFFFF),
          insetPadding: EdgeInsets.symmetric(
            horizontal: 30,
            vertical: 60,
          ),
          child: languages.isEmpty
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : StatefulBuilder(
                  builder: (BuildContext context, StateSetter setStateDialog) {
                    List<Map<dynamic, dynamic>> filteredVoices =
                        selectedLanguage != null
                            ? voices
                                .where((voice) =>
                                    voice["name"].contains(selectedLanguage))
                                .toList()
                            : voices;
                    return Container(
                      padding: EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                DropdownButton<String>(
                                  value: selectedLanguage,
                                  hint: Text("Select language"),
                                  items: languages.map((language) {
                                    return DropdownMenuItem<String>(
                                      child: Text(language),
                                      value: language,
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    setStateDialog(() {
                                      selectedLanguage = value;
                                    });
                                  },
                                ),
                                filteredVoices.isNotEmpty
                                    ? DropdownButton<Object>(
                                        value: selectedVoice != null &&
                                                filteredVoices
                                                    .contains(selectedVoice)
                                            ? selectedVoice
                                            : null,
                                        hint: Text("Select Voice"),
                                        items: filteredVoices
                                            .map<DropdownMenuItem<Object>>(
                                                (voice) {
                                          return DropdownMenuItem<Object>(
                                            value: voice,
                                            child: Text(voice["name"]),
                                          );
                                        }).toList(),
                                        onChanged: (value) {
                                          setStateDialog(() {
                                            selectedVoice = value;
                                          });
                                        },
                                      )
                                    : Text(
                                        softWrap: true,
                                        "No voices available for selected language."),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 40.0,
                          ),
                          Expanded(
                            flex: 2,
                            child: SingleChildScrollView(
                              child: RichText(
                                softWrap: true,
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 18.0,
                                    color: Color(0xFF1F1F1F),
                                  ),
                                  text: ttsController.text,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    if (selectedLanguage != null &&
                                        selectedVoice != null) {
                                      flutterTts.setLanguage(
                                          selectedLanguage ?? 'en-US');

                                      final voiceMap = selectedVoice
                                          as Map<dynamic, dynamic>;
                                      if (voiceMap.containsKey("name") &&
                                          voiceMap.containsKey("locale")) {
                                        flutterTts.setVoice({
                                          "name": voiceMap["name"],
                                          "locale": voiceMap["locale"]
                                        });
                                      }
                                      setState(() {
                                        ttsIndex = 0;
                                        isPlaying = true;
                                      });
                                      playTts(setStateDialog);
                                    } else {
                                      flutterTts.setLanguage('en-US');
                                      flutterTts.setVoice(
                                          {"name": "Karen", "locale": "en-US"});

                                      setState(() {
                                        ttsIndex = 0;
                                        isPlaying = true;
                                      });
                                      playTts(setStateDialog);
                                    }
                                  },
                                  icon: Icon(
                                    Icons.play_arrow,
                                    color: Color(0xFF4EABCC),
                                    size: 40,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    pauseTts();
                                  },
                                  icon: Icon(
                                    Icons.pause,
                                    color: Color(0xFF4EABCC),
                                    size: 40,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          GalacticOceanButton(
                            onPress: () {
                              pauseTts();
                              Navigator.pop(context);
                            },
                            buttonLabel: Text(
                              'Close',
                              style: TextStyle(
                                fontFamily: 'Hind',
                                fontSize: 12.0,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFFFFFFFF),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
        );
      },
    );
  }

  void sttFunction() async {
    speechEnabled = await flutterStt.initialize();

    showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setStateDialog) {
            return Dialog(
              backgroundColor: Color(0xFFFFFFFF),
              insetPadding: EdgeInsets.symmetric(
                horizontal: 30,
                vertical: 60,
              ),
              child: Container(
                margin: EdgeInsets.all(20.0),
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    Expanded(
                      child: Text(
                        textAlign: TextAlign.center,
                        maxLines: null,
                        flutterStt.isListening
                            ? 'Listening...'
                            : speechEnabled
                                ? 'Press the Mic Button, to let me hear your inner voice.'
                                : 'Speech is not available.',
                        style: TextStyle(
                          fontFamily: 'Hind',
                          fontSize: 18.0,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF1F1F1F),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 50.0,
                    ),
                    Expanded(
                      flex: 2,
                      child: Center(
                        child: Text(
                          softWrap: true,
                          sttController.text,
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 18.0,
                            color: Color(0xFF1F1F1F),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            onPressed: () {
                              if (flutterStt.isListening) {
                                stopListening(setStateDialog);
                              } else {
                                startListening(setStateDialog);
                              }
                            },
                            icon: Icon(
                              flutterStt.isListening
                                  ? Icons.mic
                                  : Icons.mic_off,
                              color: Color(0xFF4EABCC),
                              size: 40,
                            ),
                          ),
                          IconButton(
                            onPressed: addSttToController,
                            icon: Icon(
                              Icons.add,
                              color: Color(0xFF4EABCC),
                              size: 40,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    GalacticOceanButton(
                      onPress: () {
                        Navigator.pop(context);
                      },
                      buttonLabel: Text('Close'),
                    ),
                  ],
                ),
              ),
            );
          });
        });
  }

  void startListening(StateSetter setStateDialog) async {
    await flutterStt.listen(onResult: (result) {
      setStateDialog(() {
        sttController.text = result.recognizedWords;
      });
    });
    setStateDialog(() {});
  }

  void stopListening(StateSetter setStateDialog) async {
    await flutterStt.stop();
    setStateDialog(() {});
  }

  void addSttToController() {
    final String recognizedText = sttController.text;

    if (recognizedText.isNotEmpty) {
      setState(() {
        if (controllers.isNotEmpty && controllers.first.text.isEmpty) {
          controllers.first.text = recognizedText;
        } else {
          controllers.add(TextEditingController(text: recognizedText));
          editModes.add(true);
        }
      });
      sttController.clear();
    }
  }

  @override
  void initState() {
    nowTime = ChroniclesDateTime(nowTime: DateTime.now());
    if (widget.fileName == null) {
      controllers.add(TextEditingController());
      noEditController.add(TextEditingController());
      editModes.add(true);

      String weekday = nowTime.getHalfStringWeekDay();
      int day = nowTime.getIntDay();
      String month = nowTime.getHalfStringMonth();
      int year = nowTime.getIntYear();

      createdAt = '$weekday, $day-$month-$year';
      modifiedAt = '$weekday, $day-$month-$year';
      reactionType = ReactionType.none;

      widget.fileName = '${nowTime.getMilliSecondSinceEpoch()}.json';
    } else {
      String? milliSinceEpochString = widget.fileName?.split('.').first;
      int milliSinceEpoch = int.parse(milliSinceEpochString!);
      nowTime.convertMilliSecondsSinceEpochToDateTime(milliSinceEpoch);

      _loadFile(widget.fileName!);
    }

    loadLanguages();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          noSaveClose();
        }
      },
      child: Scaffold(
        floatingActionButton: TextEditorFab(
          reactionType: reactionType,
          reactionFunction: reactionFunction,
          sttFunction: sttFunction,
          ttsFunction: ttsFunction,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(createdAt),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                    onPressed: () {
                      setState(() {
                        _saveFile();
                      });
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        '/Dashboard',
                        (Route<dynamic> route) => false,
                      );
                    },
                    icon: Icon(
                      Icons.save_rounded,
                      color: Color(0xFF4EABCC),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        _deleteFile();
                      });
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        '/Dashboard',
                        (Route<dynamic> route) => false,
                      );
                    },
                    icon: Icon(
                      Icons.delete_outline_sharp,
                      color: Color(0xFF4EABCC),
                    ),
                  ),
                ],
              ),
            ],
          ),
          leading: IconButton(
            onPressed: () {
              noSaveClose();
            },
            icon: Icon(Icons.arrow_back),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20.0, top: 20.0),
                child: TextField(
                  style: TextStyle(
                    color: Color(0xFF1F1F1F),
                    fontFamily: 'Hind',
                    fontWeight: FontWeight.w600,
                    fontSize: 22.0,
                  ),
                  controller: titleController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Title',
                  ),
                  onTapUpOutside: (event) {
                    FocusScope.of(context).unfocus();
                  },
                  onTapOutside: (event) {
                    FocusScope.of(context).unfocus();
                  },
                ),
              ),
              const SizedBox(height: 30.0),
              ReorderableListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: controllers.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    minVerticalPadding: 0.0,
                    key: ValueKey(controllers[index]),
                    leading: Icon(
                      Icons.drag_indicator,
                      color: Color(0xFF4EABCC),
                    ),
                    title: EditorTextBox(
                      controller: controllers[index],
                      editMode: editModes[index],
                      onToggleEdit: () => _toggleEditMode(index),
                      onDelete: () => _deleteController(index),
                    ),
                  );
                },
                onReorder: _onReorder,
              ),
              SizedBox(
                height: 20.0,
              ),
              Container(
                padding: EdgeInsets.only(left: 20, right: 18.0),
                margin: EdgeInsets.only(bottom: 18.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      color: Color(0x104EABCC),
                      child: MaterialButton(
                        onPressed: _insertController,
                        child: Icon(
                          Icons.text_fields,
                          color: Color(0xFF4EABCC),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10.0,
                    ),
                    Container(
                      color: Color(0x104EABCC),
                      child: MaterialButton(
                        onPressed: _insertImage,
                        child: Icon(
                          Icons.image,
                          color: Color(0xFF4EABCC),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 100.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
