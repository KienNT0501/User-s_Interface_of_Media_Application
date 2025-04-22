#include "player.h"
#include <QDebug>
#include <taglib/fileref.h>
#include <taglib/tag.h>
#include <taglib/mpegfile.h>
#include <taglib/id3v2tag.h>
#include <taglib/id3v2frame.h>
#include <taglib/attachedpictureframe.h>
#include <QUrl>
#include <QMediaService>
#include <QMediaPlaylist>
#include <QMediaMetaData>
#include <QObject>
#include <QFileInfo>
#include <QTime>
#include <QDir>
#include <QStandardPaths>
#include "playlistmodel.h"
#include<fstream>
#include<string>
Player::Player(QObject *parent) : QObject(parent) {
    player = new QMediaPlayer(this);
    playlist = new QMediaPlaylist(this);
    player->setPlaylist(playlist);
    playlistModel = new PlaylistModel(this);
    //connect(playlist, &QMediaPlaylist::mediaChanged, this, &Player::onMediaChanged);
    //connect(player, &QMediaPlayer::durationChanged, this, &Player::onDurationChanged);
    connect(player, &QMediaPlayer::positionChanged, this, &Player::onPositionChanged);
    connect(player, &QMediaPlayer::currentMediaChanged,this,&Player::oncurrentMediaChanged);
    connect(player, &QMediaPlayer::durationChanged,this,[&](qint64 duration){
        qDebug()<<duration;
        m_duration = duration;
        qDebug()<<m_duration;
        updateDurationInfo(m_duration);
    });
    open();
    if (!playlist->isEmpty()) {
        playlist->setCurrentIndex(0);
    }
}
void Player::open()
{
    QDir directory(QStandardPaths::standardLocations(QStandardPaths::MusicLocation)[0]);
    QFileInfoList musics = directory.entryInfoList(QStringList() << "*.mp3",QDir::Files);
    QList<QUrl> urls;
    for (int i = 0; i < musics.length(); i++){
        urls.append(QUrl::fromLocalFile(musics[i].absoluteFilePath()));
    }
    addToPlaylist(urls);
}
void Player::addToPlaylist(const QList<QUrl> &urls)
{
    for (auto &url: urls) {

        playlist->addMedia(url);
        TagLib::FileRef f(url.path().toStdString().c_str());
        TagLib::Tag *tag = f.tag();
        if(tag){
            QString title = tag->title().isEmpty() ? "Unknow Title" : QString::fromWCharArray(tag->title().toCWString());
            QString artist = tag->artist().isEmpty() ? "Unknow Artist" : QString::fromWCharArray(tag->artist().toCWString());

            Song song(QString::fromWCharArray(tag->title().toCWString()),
                      QString::fromWCharArray(tag->artist().toCWString()),
                      getAlbumArtt(url),url.toDisplayString());
            qDebug()<<"Adding song to playlist : "<<title<<" - "<<artist<<url.toString()<<getAlbumArtt(url);
            playlistModel->addSong(song);
        }
        else{
            qWarning()<<"Can not retrieve information from: "<<url.toString();
        }
    }
}
void Player::setPlayMedia(bool isPlay)
{
    //playlist->setCurrentIndex(playlist->currentIndex()+1);
    if(!isPlay){
        player->play();
    }
    if(isPlay){
        player->pause();
    }
}
void Player::seek(qint64 mseconds)
{
    qint64 maxDuration = m_duration;
    qint64 newPosition = qBound(qint64(0), mseconds, maxDuration);
    qDebug()<<"Seeking to: "<<newPosition<<" / "<<maxDuration;
    player->pause();
    player->setPosition(newPosition);
    QTimer::singleShot(100,this,[=](){
        if(player->state()!=QMediaPlayer::PlayingState&&playButtonstate==true){
            player->play();
        }
    });
}

void Player::jumpTomedia(int index) {
    int count = playlist->mediaCount();
    qDebug() << "Jumping to index:" << index << " (Playlist count:" << count << ")";

    if (count <= 0) {
        qWarning() << "Playlist is empty! Cannot jump.";
        return;
    }

    if (index < 0 || index >= count) {
        qWarning() << "Invalid index! Skipping.";
        return;
    }

    playlist->setCurrentIndex(index);
    qDebug()<<"Day: "<<m_duration;
    emit currentIndexChanged(index);
}


void Player::next() {
    if(shuffleButton == false){
        int currentIndex = playlist->currentIndex();
        int totalCount = playlist->mediaCount();
        if (totalCount == 0) {
            qWarning() << "Playlist is empty!";
            return;
        }

        if (currentIndex < totalCount - 1) {
            playlist->setCurrentIndex(currentIndex + 1);
            qDebug() << "Current index:" << currentIndex << ", Total media count:" << totalCount;
            emit currentIndexChanged(currentIndex + 1);
        } else {
            qWarning() << "Already at the last song, move to the first song.";
            playlist->setCurrentIndex(0);
            emit currentIndexChanged(0);
        }
    }
    else{
        shuffle();
    }
}
void Player::previous() {
    if(shuffleButton == false){
        int currentIndex = playlist->currentIndex();
        int totalCount = playlist->mediaCount();
        if (totalCount == 0) {
            qWarning() << "Playlist is empty!";
            return;
        }
        if (currentIndex > 0) {
            playlist->setCurrentIndex(currentIndex - 1);
            qDebug() << "Current index:" << currentIndex << ", Total media count:" << totalCount;
            emit currentIndexChanged(currentIndex - 1);
        } else {
            qWarning() << "Already at the first song, move to the last song";
            playlist->setCurrentIndex(totalCount-1);
            emit currentIndexChanged(totalCount-1);
        }
    }
    else{
        shuffle();
    }
}
void Player::shuffle()
{
    int totalCount = playlist->mediaCount();
    int currentIndex = rand()%totalCount;
    playlist->setCurrentIndex(currentIndex);
    emit currentIndexChanged(currentIndex);
}

QString Player::updateDurationInfo(qint64 currentInfo)
{
    emit durationChanged(currentInfo);
    qDebug()<<"Inside the convertion: "<<currentInfo;
    currentInfo = currentInfo/1000;
    if (currentInfo==0) return "00:00";
    QTime currentTime((currentInfo / 3600) % 60,
                      (currentInfo / 60) % 60,
                      currentInfo % 60,
                      currentInfo % 1000);
    QString format = currentTime.hour()>0 ? "hh:mm:ss" : "mm:ss";
    emit displayChanged(currentTime.toString(format));

    return  currentTime.toString(format);
}

QString Player::updateCurrentPosition(qint64 currentInfo)
{

    currentInfo = currentInfo/1000;
    if (currentInfo==0) return "00:00";
    QTime currentTime((currentInfo / 3600) % 60,
                      (currentInfo / 60) % 60,
                      currentInfo % 60,
                      currentInfo % 1000);
    QString format = currentTime.hour()>0 ? "hh:mm:ss" : "mm:ss";

    return  currentTime.toString(format);
}

qint64 Player::getDuration() const
{
    return player->duration();
}

void Player::onPositionChanged(qint64 position)
{
    position = player->position();
    qDebug()<<"m_position: "<<position;
    qDebug()<<"m_duration: "<<m_duration;
    if(position == m_duration && position != 0&&playButtonstate == true){
        qDebug()<<"playbuttonstate"<<playButtonstate;
        if(replayButton == true){
            qDebug()<<"replayButtonState: "<<replayButton;
            playlist->setPlaybackMode(QMediaPlaylist::CurrentItemInLoop);

        }
        else{
            if(shuffleButton == true){
                qDebug()<<"shuffleButtonState: "<<shuffleButton;
                shuffle();
                player->play();
            }
            else{
                next();
            }

        }
    }
    emit positionChanged();
}

void Player::start()
{
    if(playlist->currentIndex()!= -1&&playButtonstate==true)
        qDebug()<<"Start media!";
    player->play();
}

void Player::stop()
{

    player->pause(); // Stop the timer
}
void Player::timeOut()
{
    if(m_position >= m_duration){
        qDebug()<<"do";
        if(replayButton == true){
            emit endSong();
        }
        else{
            if(shuffleButton == true){
                shuffle();
            }
            else{
                next();
            }
        }
    }
}

void Player::onoffState(bool val)
{
    playButtonstate = val;
}

void Player::shuffleButtonState(bool states)
{
    shuffleButton = states;
}

void Player::replayButtonState(bool states)
{
    replayButton = states;
}

qint64 Player::getc_position()
{
    return player->position();
}

void Player::setc_position(qint64 value)
{
    m_position = value;
}

void Player::oncurrentMediaChanged()
{
    qDebug()<<"in current media changed";
    start();
    emit currentMediaChanged();
}
QString Player::getAlbumArtt(QUrl url)
{
    static const char *IdPicture = "APIC" ;
    TagLib::MPEG::File mpegFile(url.path().toStdString().c_str());
    TagLib::ID3v2::Tag *id3v2tag = mpegFile.ID3v2Tag();
    TagLib::ID3v2::FrameList Frame ;
    TagLib::ID3v2::AttachedPictureFrame *PicFrame ;
    void *SrcImage ;
    unsigned long Size ;

    FILE *jpegFile;
    jpegFile = fopen(QString(url.fileName()+".jpg").toStdString().c_str(),"wb");

    if ( id3v2tag )
    {
        // picture frame
        Frame = id3v2tag->frameListMap()[IdPicture] ;
        if (!Frame.isEmpty() )
        {
            for(TagLib::ID3v2::FrameList::ConstIterator it = Frame.begin(); it != Frame.end(); ++it)
            {
                PicFrame = static_cast<TagLib::ID3v2::AttachedPictureFrame*>(*it) ;
                //  if ( PicFrame->type() ==
                //TagLib::ID3v2::AttachedPictureFrame::FrontCover)
                {
                    // extract image (in it’s compressed form)
                    Size = PicFrame->picture().size() ;
                    SrcImage = malloc ( Size ) ;
                    if ( SrcImage )
                    {
                        memcpy ( SrcImage, PicFrame->picture().data(), Size ) ;
                        fwrite(SrcImage,Size,1, jpegFile);
                        fclose(jpegFile);
                        free( SrcImage ) ;
                        return QUrl::fromLocalFile(url.fileName()+".jpg").toDisplayString();
                    }
                }
            }
        }
    }
    else
    {
        qDebug() <<"id3v2 not present";
        return "qrc:/Image/album_art.png";
    }
    return "qrc:/Image/album_art.png";

}

