#ifndef PLAYLISTMODEL_H
#define PLAYLISTMODEL_H


#include <QAbstractListModel>
class Song{
public:
    Song();
    Song(const QString songname, const QString singer, const QString imageSource, const QString musicSource);
    QString getSongname() const;
    QString getSingername() const;
    QString getImageSource() const;
    QString getMusicSource() const;
private:
    QString m_songname;
    QString m_singer;
    QString m_imageSource;
    QString m_musicSource;
};
class PlaylistModel : public QAbstractListModel
{
    Q_OBJECT
public:

    enum SongRoles{
        NameRoles = Qt::UserRole+1,
        SingerRoles,
        imageSourceRoles,
        musicSourceRoles
    };
    explicit PlaylistModel(QObject *parent = nullptr);
    //PlaylistModel(QObject *parent = nullptr);
    void addSong(const Song &song);
    int rowCount(const QModelIndex&parent = QModelIndex())const override;
    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;
    Q_INVOKABLE QString d_data(int i, int role) const;

protected:
    QHash<int, QByteArray> roleNames() const override;

private:
    QList<Song> m_data;
};

#endif // PLAYLISTMODEL_H
