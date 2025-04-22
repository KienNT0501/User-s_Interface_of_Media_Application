#include "playlistmodel.h"
PlaylistModel::PlaylistModel(QObject *parent)
    : QAbstractListModel(parent)
{
}
Song::Song()
    :m_songname(""), m_singer(""),m_imageSource(""),m_musicSource(""){}
Song:: Song(const QString songname, const QString singer, const QString imageSource, const QString musicSource){
    m_songname = songname;
    m_singer = singer;
    m_imageSource = imageSource;
    m_musicSource = musicSource;
}
QString Song::getSongname()const{
    return m_songname;
}
QString Song::getSingername()const{
    return m_singer;
}
QString Song::getImageSource()const{
    return m_imageSource;
}
QString Song::getMusicSource()const{
    return m_musicSource;
}
void PlaylistModel::addSong(const Song &song){
    beginInsertRows(QModelIndex(),rowCount(),rowCount());
    m_data<<song;
    endInsertRows();
}
int PlaylistModel::rowCount(const QModelIndex&parent) const{
    Q_UNUSED(parent);
    return m_data.count();
}
QVariant PlaylistModel:: data(const QModelIndex &index, int role ) const{
    if(index.row()<0||index.row()>=m_data.count())return QVariant();
    const Song & song = m_data[index.row()];
    if(role==NameRoles)return song.getSongname();
    if(role==SingerRoles)return song.getSingername();
    if(role==imageSourceRoles)return song.getImageSource();
    if(role==musicSourceRoles)return song.getMusicSource();
    return QVariant();
}
QHash<int,QByteArray> PlaylistModel::roleNames() const{
    QHash<int, QByteArray> roles;
    roles[NameRoles] = "nameSong";
    roles[SingerRoles] = "nameSinger";
    roles[imageSourceRoles] = "imageSource";
    roles[musicSourceRoles] = "musicSource";
    return roles;
}
 QString PlaylistModel::d_data(int i, int role) const{
    QString dataGetting;
    if(role == 0){
     dataGetting = m_data[i].getSongname();
    }
    if(role == 1){
     dataGetting = m_data[i].getSingername();
    }
    return dataGetting;
}
