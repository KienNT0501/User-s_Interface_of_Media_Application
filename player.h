#ifndef PLAYER_H
#define PLAYER_H

#include <QObject>
#include<QMediaPlayer>
#include<QMediaPlaylist>
#include<QTimer>
#include "playlistmodel.h"
#include <taglib/tag.h>
#include <taglib/taglib_export.h>
#include <taglib/fileref.h>
#include <taglib/id3v2tag.h>
#include <taglib/mpegfile.h>
#include <taglib/id3v2frame.h>
#include <taglib/id3v2header.h>
#include <taglib/attachedpictureframe.h>
class Player : public QObject
{
    Q_OBJECT
    Q_PROPERTY(qint64 duration READ getDuration NOTIFY durationChanged)
    Q_PROPERTY(qint64 c_position READ getc_position WRITE setc_position  NOTIFY positionChanged)

public:
    explicit Player(QObject *parent = nullptr);

signals:
    void currentIndexChanged(int index);
    void durationChanged(qint64 val);
    void positionChanged();
    void currentMediaChanged();

    void displayChanged(QString s);
    void endSong();
public slots:
    void open();
    void setPlayMedia(bool isPlay);
    void seek(qint64 mseconds);
    //void onMediaChanged();
    //void addSong(const QUrl url);
    void addToPlaylist(const QList<QUrl> &urls);
    QString getAlbumArtt(QUrl url);
    void jumpTomedia(int index);
    void next();
    void previous();
    void shuffle();
    //int shuffleControl(int size);
    //void currentIndex();
    QString updateDurationInfo(qint64 currentInfo);
    QString updateCurrentPosition(qint64 currentInfo);
    qint64 getDuration() const;
    void onPositionChanged(qint64 position);
    void start() ;
    void stop();
    void timeOut();
    void onoffState(bool val);
    void shuffleButtonState(bool states);
    void replayButtonState(bool states);
    qint64 getc_position();
    void setc_position(qint64 value);
    void oncurrentMediaChanged();
public:
    QMediaPlayer* player = nullptr;
    QMediaPlaylist *playlist = nullptr;
    QTimer *timer = nullptr;
    PlaylistModel* playlistModel = nullptr;
    qint64 m_duration = 0;
    qint64 m_counter=0;
    qint64 m_position =0;
    bool playButtonstate =true;
    bool shuffleButton = false;
    bool replayButton = false;
};

#endif // PLAYER_H
