#include "historymanager.h"
#include <QDir>
#include <QStandardPaths>

HistoryManager::HistoryManager()
{
    // create cache location if it does not exist, and load cache
    QDir dir(QStandardPaths::writableLocation(QStandardPaths::CacheLocation) + "/cache");
    if (!dir.exists())
        dir.mkpath(".");
}
