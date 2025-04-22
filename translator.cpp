#include "translator.h"

Translator::Translator(QObject *parent) : QObject(parent)
{
      m_translator.load(":/translate_us.qm");
      m_app->installTranslator(&m_translator);
}
void Translator::setLanguage(int val){
    if(val == 0){
        m_translator.load(":/translate_us.qm");
    }
    if(val == 1){
        m_translator.load(":/translate_vn.qm");
    }
    m_app->installTranslator(&m_translator);
    emit languageChanged();
}
