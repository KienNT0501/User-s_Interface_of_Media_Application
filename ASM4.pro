QT += core quick multimedia gui

CONFIG += c++11

# You can make your code fail to compile if it uses deprecated APIs.
# In order to do so, uncomment the following line.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

SOURCES += \
        main.cpp \
        player.cpp \
        playlistmodel.cpp \
        translator.cpp

RESOURCES += qml.qrc \
            Image.qrc


# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH =

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target
LIBS += -ltag
#INCLUDEPATH+= /mingw64/include/taglib
#INCLUDEPATH += /include/QtCore
#INCLUDEPATH += $$[QT_INSTALL_HEADERS]
DISTFILES += \
    translate_vn.ts
HEADERS += \
    player.h \
    playlistmodel.h \
    translator.h
TRANSLATIONS += translate_vn.ts\
                translate_us.ts
