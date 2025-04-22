#ifndef TRANSLATOR_H
#define TRANSLATOR_H

#include <QObject>
#include <QTranslator>
#include<QGuiApplication>
class Translator : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString updateText READ updateText NOTIFY languageChanged)
public:
    explicit Translator(QObject *parent = nullptr);
    Q_INVOKABLE void setLanguage(int val);
    QString updateText()const{
        return "";
    }
signals:
    void languageChanged();
private:
    QTranslator m_translator;
    QGuiApplication* m_app;
};

#endif // TRANSLATOR_H
